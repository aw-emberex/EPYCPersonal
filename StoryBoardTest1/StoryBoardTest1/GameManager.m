//
//  GameManager.m
//  StoryBoardTest1
//
//  Created by Alex Wait on 4/27/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import "GameData.h"

@implementation GameManager

static GameManager *_instance = nil;

@synthesize appDelegate, gameEntryEntity, managedObjectContent, squiggleEntity, squigglePointEntity;
@synthesize mainGameDataInstance = _mainGameDataInstance;
@synthesize currentGameEntry = _currentGameEntry;

+ (GameManager *)getInstance {
    if (_instance == nil) {
        _instance = [[self alloc] init];
    }
    return _instance;
}

- (GameEntry *)requestLatestGameEntry {
    _currentGameEntry = (GameEntry *) [[self.mainGameDataInstance gameEntries] lastObject];
    if (!_currentGameEntry) {
        _currentGameEntry = [self createNewGameEntry];
    }
    NSLog(@"Latest Game Entry is %@", _currentGameEntry);
    NSLog(@"Squiggles %@, %d", _currentGameEntry.squiggles, [_currentGameEntry.squiggles count]);
    return _currentGameEntry;
}

- (GameEntry *)createNewGameEntry {
    GameEntry *entry = (GameEntry *) [NSEntityDescription insertNewObjectForEntityForName:@"GameEntry" inManagedObjectContext:managedObjectContent];
    [entry setOwningGameData:_mainGameDataInstance];
    return entry;
}

- (Squiggle *)createNewSquiggle {
    Squiggle *squiggle = (Squiggle *) [NSEntityDescription insertNewObjectForEntityForName:@"Squiggle" inManagedObjectContext:appDelegate.managedObjectContext];
    return squiggle;
}

- (id)init {
    self = [super init];
    if (self) {
        appDelegate = (EPYCAppDelegate *) [[UIApplication sharedApplication] delegate];
        self.managedObjectContent = self.appDelegate.managedObjectContext;
        self.gameEntryEntity = [NSEntityDescription entityForName:@"GameEntry" inManagedObjectContext:managedObjectContent];
        self.squigglePointEntity = [NSEntityDescription entityForName:@"SquigglePoint" inManagedObjectContext:managedObjectContent];
        self.squiggleEntity = [NSEntityDescription entityForName:@"Squiggle" inManagedObjectContext:managedObjectContent];
        self.gameDataEntity = [NSEntityDescription entityForName:@"GameData" inManagedObjectContext:managedObjectContent];
        [self loadMainGameData];
    }
    return self;
}

- (GameData *)getMainGameData {
    //if (_mainGameDataInstance == nil) {
    [self loadMainGameData];
    //}
    return _mainGameDataInstance;
}

- (void)loadMainGameData {
    NSError *__autoreleasing error;
    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:@"GameData"];
    [fetch setReturnsObjectsAsFaults:NO];

    NSArray *result = (NSArray *) [managedObjectContent executeFetchRequest:fetch error:&error];

    if ([result count] == 0) {
        _mainGameDataInstance = (GameData *) [NSEntityDescription insertNewObjectForEntityForName:@"GameData" inManagedObjectContext:managedObjectContent];
        NSLog(@"OMG %@", error);
        [self saveContext];
    } else {
        _mainGameDataInstance = [result objectAtIndex:0];
        NSLog(@"%@", _mainGameDataInstance);
        NSLog(@"%d", [_mainGameDataInstance.gameEntries count]);
    }
}

- (void)deleteAllGameData {
    [managedObjectContent deleteObject:_mainGameDataInstance];
    [self saveContext];
    [self loadMainGameData];
}

- (void)saveContext {
    NSError *__autoreleasing error;
    BOOL result = [self.managedObjectContent save:&error];
    if (!result) {
        NSLog(@"Severe Error Saving: %@", error);
        abort();
    }
}

- (NSOrderedSet *)getGameEntries; {
    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:@"GameEntry"];
    NSError *__autoreleasing error;
    NSArray *result = [managedObjectContent executeFetchRequest:fetch error:&error];
    return [[NSOrderedSet alloc] initWithArray:result];
}

- (NSMutableOrderedSet *)getAllGameData {
    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:@"GameData"];
    NSError *__autoreleasing error;
    NSArray *result = [managedObjectContent executeFetchRequest:fetch error:&error];
    return [NSMutableOrderedSet orderedSetWithArray:result];
}
@end

