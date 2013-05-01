//
//  GameManager.m
//  StoryBoardTest1
//
//  Created by Alex Wait on 4/27/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import "GameManager.h"
#import "GameData.h"

@implementation GameManager

static GameManager* _instance = nil;

@synthesize appDelegate,gameEntryEntity,managedObjectContent, squiggleEntity,squigglePointEntity;
@synthesize mainGameDataInstance = _mainGameDataInstance;

+(GameManager*) getInstance {
    if (_instance == nil) {
        _instance = [[self alloc] init];
    }
    return _instance;
}

-(GameEntry *)createNewGameEntry {
    GameEntry* entry = (GameEntry*)[NSEntityDescription insertNewObjectForEntityForName:@"GameEntry" inManagedObjectContext:managedObjectContent];
    [entry setOwningGameData:_mainGameDataInstance];
    return entry;
}

- (id)init
{
    self = [super init];
    if (self) {
        appDelegate = (EPYCAppDelegate *)[[UIApplication sharedApplication] delegate];
        self.managedObjectContent = self.appDelegate.managedObjectContext;
        self.gameEntryEntity = [NSEntityDescription entityForName:@"GameEntry" inManagedObjectContext:managedObjectContent];
        self.squigglePointEntity = [NSEntityDescription entityForName:@"SquigglePoint" inManagedObjectContext:managedObjectContent];
        self.squiggleEntity = [NSEntityDescription entityForName:@"Squiggle" inManagedObjectContext:managedObjectContent];
        self.gameDataEntity = [NSEntityDescription entityForName:@"GameData" inManagedObjectContext:managedObjectContent];
        [self loadMainGameData];
    }
    return self;
}

-(GameData *)getMainGameData {
    if (_mainGameDataInstance == nil) {
        [self loadMainGameData];
    }
    return _mainGameDataInstance;
}

-(void) loadMainGameData {
    NSError* __autoreleasing error;
    NSArray* result = (NSArray*)[managedObjectContent executeFetchRequest:[NSFetchRequest fetchRequestWithEntityName:@"GameData"] error:&error];

    if ([result count] == 0) {
        _mainGameDataInstance = (GameData*)[NSEntityDescription insertNewObjectForEntityForName:@"GameData" inManagedObjectContext:managedObjectContent];
        NSLog(@"OMG %@", error);
        [self saveContext];
    } else {
        _mainGameDataInstance = [result objectAtIndex:0];
    }
}

-(void)deleteAllGameData {
    [managedObjectContent deleteObject:(NSManagedObject*)_mainGameDataInstance];
    [self saveContext];
    [self loadMainGameData];
}

-(void) saveContext {
    NSError* __autoreleasing error;
    BOOL result = [self.managedObjectContent save:&error];
    if (!result) {
        NSLog(@"Severe Error Saving: %@", error);
        abort();
    }
}

-(NSOrderedSet*)getGameEntries; {
    NSFetchRequest* fetch = [NSFetchRequest fetchRequestWithEntityName:@"GameEntry"];
    NSError* __autoreleasing error;
    NSArray* result = [managedObjectContent executeFetchRequest:fetch error:&error];
    return [[NSOrderedSet alloc]initWithArray:result];
}

@end
