//
//  GameManager.m
//  StoryBoardTest1
//
//  Created by Alex Wait on 4/27/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import "GameManager.h"

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
    return nil;
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
    return mainGameDataInstance;
}

-(void) loadMainGameData {
    NSError* __autoreleasing error;
    NSArray* result = (NSArray*)[managedObjectContent executeFetchRequest:[NSFetchRequest fetchRequestWithEntityName:@"GameData"] error:&error];

    if ([result count] == 0) {
        NSLog(@"OMG %@", error);
        abort();
    } else {
        //TODO: Insert new game data instance, set ID to 1?
    }
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
