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
static GameManager* gameManager = nil;

- (void)setUp
{
    userManager = [UserDataManager getUserDataManager];
     _appDelegate = (EPYCAppDelegate *)[[UIApplication sharedApplication] delegate];
    [userManager clearAllUsers];
    NSLog(@"calling setup");
    [super setUp];
    //delete main game data, should delete all data it owns as well
    gameManager = [GameManager getInstance];
    [gameManager deleteAllGameData];
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
    [gameManager deleteAllGameData];
    GameManager* manager = [GameManager getInstance];
    GameData* gameData = [manager getMainGameData];
    STAssertNotNil(gameData, @"should have game data");
    STAssertEquals([[gameData gameEntries] count], 0U, @"shouldn't be any game entries");
    STAssertNotNil([manager requestLatestGameEntry], @"new entry should be valid");
    gameData = [manager mainGameDataInstance];
    NSLog(@"AAAAAA %@", [gameData gameEntries]);
    STAssertEquals([[gameData gameEntries] count], 1U, @"shouldn't be any game entries");
    
    GameEntry* newEntry = (GameEntry*)[[gameData gameEntries] objectAtIndex:0];
    NSLog(@"Entry %@", newEntry);
    STAssertNotNil(newEntry, @"Should have valid squiggle");
    Squiggle* newSquiggle = [manager createNewSquiggle];
    newSquiggle.owningGameEntry = newEntry;
    CGPoint testCGPoint;
    testCGPoint.x = 123;
    testCGPoint.y = 456;
    [[[newEntry squiggles] objectAtIndex:0] addCGPoint:testCGPoint];
    
    
    //get game data again
    GameData* gameData2 = [manager getMainGameData];
    GameEntry* newEntry2 = (GameEntry*)[[gameData2 gameEntries] objectAtIndex:0];
    Squiggle* someSquiggle = [[newEntry2 squiggles] objectAtIndex:0];
    NSOrderedSet* pointsSet = [someSquiggle points];
    STAssertEquals([pointsSet count], 1U, @"New Squiggle should have one point!");
    SquigglePoint* firstPoint = (SquigglePoint*)[pointsSet objectAtIndex:0U];
    STAssertEqualObjects(firstPoint.xPoint, [NSNumber numberWithInt:123], @"points should be saved right");
    STAssertEqualObjects(firstPoint.yPoint, [NSNumber numberWithInt:456], @"points should be saved right");
    
    //now test saving game entry

    {
        GameEntry* secondGameEntry;
        secondGameEntry = [manager createNewGameEntry];
        [manager saveContext];
        STAssertNotNil(secondGameEntry, @"Second Game Should Be Valid");
        NSLog(@"second gameEntry %@", secondGameEntry);
        STAssertEquals([[manager getGameEntries] count], 2U, @"Should be two entries now");



    }


}

@end