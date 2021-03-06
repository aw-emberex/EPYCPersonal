//
//  GameManager.h
//  StoryBoardTest1
//
//  Created by Alex Wait on 4/27/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Squiggle.h"
#import "SquigglePoint.h"
#import "GameEntry.h"
#import "EPYCAppDelegate.h"

@class GameData;


@interface GameManager : NSObject {
}

+ (GameManager *)getInstance;

- (NSOrderedSet *)getGameEntries;

- (GameEntry *)requestLatestGameEntry;

- (GameEntry *)createNewGameEntry;

- (Squiggle *)createNewSquiggle;

- (void)deleteAllGameData;

- (void)saveContext;

- (GameData *)getMainGameData;

- (void)setCurrentGameDataPhraseText:(NSString *)phraseText;

-(void) setMainGameData:(GameData *)gameData;
- (NSMutableOrderedSet *)getActiveGameData;
- (void)createNewGameData;

@property(readwrite, nonatomic) GameData *mainGameDataInstance;

- (NSMutableOrderedSet *)getAllFinishedGameData;

@property(readwrite, nonatomic) GameEntry *currentGameEntry;
@property(readwrite, nonatomic) NSEntityDescription *squiggleEntity;
@property(readwrite, nonatomic) NSEntityDescription *squigglePointEntity;
@property(readwrite, nonatomic) NSEntityDescription *gameEntryEntity;
@property(readwrite, nonatomic) NSEntityDescription *gameDataEntity;
@property(readwrite, nonatomic) EPYCAppDelegate *appDelegate;
@property(readwrite, nonatomic) NSManagedObjectContext *managedObjectContent;


@end
