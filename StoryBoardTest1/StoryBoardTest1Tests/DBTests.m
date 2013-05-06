//
//  DBTests.m
//  StoryBoardTest1
//
//  Created by Alex Wait on 4/20/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import "DBTests.h"
#import "UserDataManager.h"
#import "EPYCAppDelegate.h"
#import "Squiggle.h"
#import "SquigglePoint.h"
#import "GameManager.h"
#import "GameData.h"

@implementation DBTests

static UserDataManager* userManager = nil;
static EPYCAppDelegate* _appDelegate = nil;

- (void)setUp
{
    userManager = [UserDataManager getUserDataManager];
     _appDelegate = (EPYCAppDelegate *)[[UIApplication sharedApplication] delegate];
    [userManager clearAllUsers];
    NSLog(@"calling setup");
    [super setUp];
    //delete main game data, should delete all data it owns as well 
}

- (void)tearDown
{    
    [super tearDown];
}

- (void) testClearUsers {
    NSLog(@"%@', ", [userManager getUsers]);
    NSInteger test = [[userManager getUsers] count];
    STAssertTrue(test == 0, @"No users should be in DB after setup is called");
}

-(void) testClearAllData {
    [[GameManager getInstance] deleteAllGameData];
    GameData* gameData = [[GameManager getInstance] mainGameDataInstance];
    STAssertEquals([[gameData gameEntries] count], 0U, @"shouldn't be any game entries");
}

-(void) testMainGameData {
    GameManager* manager = [GameManager getInstance];
    GameData* gameData = [manager getMainGameData];
    STAssertNotNil(gameData, @"should have game data");
    STAssertEquals([[gameData gameEntries] count], 0U, @"shouldn't be any game entries");
    STAssertNotNil([manager requestLatestGameEntry], @"new entry should be valid");
    gameData = [manager mainGameDataInstance];
    NSLog(@"AAAAAA %@", [gameData gameEntries]);
    STAssertEquals([(NSOrderedSet*)[gameData gameEntries] count], 1U, @"shouldn't be any game entries");
    
    GameEntry* newEntry = (GameEntry*)[(NSOrderedSet*)[gameData gameEntries] objectAtIndex:0];
    NSLog(@"Entry %@", newEntry);
    STAssertNotNil(newEntry, @"Should have valid squiggle");
    CGPoint testCGPoint;
    testCGPoint.x = 123;
    testCGPoint.y = 456;
    [[[newEntry squiggles] objectAtIndex:0] addCGPoint:testCGPoint];
    
    
    //get game data again
    GameData* gameData2 = [manager getMainGameData];
    GameEntry* newEntry2 = (GameEntry*)[(NSOrderedSet*)[gameData2 gameEntries] objectAtIndex:0];
    Squiggle* someSquiggle = [[newEntry2 squiggles] objectAtIndex:0];
    NSOrderedSet* pointsSet = [someSquiggle points];
    STAssertEquals([pointsSet count], 1U, @"New Squiggle should have one point!");
    SquigglePoint* firstPoint = (SquigglePoint*)[pointsSet objectAtIndex:0U];
    STAssertEqualObjects(firstPoint.xPoint, [NSNumber numberWithInt:123], @"points should be saved right");
    STAssertEqualObjects(firstPoint.yPoint, [NSNumber numberWithInt:456], @"points should be saved right");
}

@end