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
    
    NSFetchRequest* squigglepointfetch = [[NSFetchRequest alloc]init];
    [squigglepointfetch setEntity:[NSEntityDescription entityForName:@"SquigglePoint" inManagedObjectContext:_appDelegate.managedObjectContext]];
    
    NSFetchRequest* squiggleFetch = [[NSFetchRequest alloc]init];
    [squiggleFetch setEntity:[NSEntityDescription entityForName:@"Squiggle" inManagedObjectContext:_appDelegate.managedObjectContext]];
    
    NSError* __autoreleasing error2 = nil;
    NSArray* result = [_appDelegate.managedObjectContext executeFetchRequest:squigglepointfetch error:&error2];
    NSArray* result2 = [_appDelegate.managedObjectContext executeFetchRequest:squiggleFetch error:&error2];
    
    NSMutableSet* toDelete =[[NSMutableSet alloc] initWithArray:result];
    [toDelete addObjectsFromArray:result2];
    
    [toDelete enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        NSLog(@"Deleting!");
        [_appDelegate.managedObjectContext deleteObject:obj];
    }];
    [_appDelegate.managedObjectContext save:&error2];
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

-(void) testAllSquigglesShouldBeGone {
    NSError* __autoreleasing error;
    [_appDelegate.managedObjectContext save:&error];
    
    NSFetchRequest* newFetch = [[NSFetchRequest alloc]init];
    [newFetch setEntity:[NSEntityDescription entityForName:@"SquigglePoint" inManagedObjectContext:_appDelegate.managedObjectContext]];
    
    NSError* __autoreleasing error2 = nil;
    NSArray* result = [_appDelegate.managedObjectContext executeFetchRequest:newFetch error:&error2];
    STAssertEquals([result count], 0U, @"There shouldn't be any squiggle points left :)");
}

-(void) testCreatingPoint {
    SquigglePoint* testPoint = (SquigglePoint*)[NSEntityDescription insertNewObjectForEntityForName:@"SquigglePoint" inManagedObjectContext:_appDelegate.managedObjectContext];
    [testPoint setXPoint:[NSNumber numberWithInt:2]];
    [testPoint setYPoint:[NSNumber numberWithInt:221]];
    
    NSError* __autoreleasing error;
    [_appDelegate.managedObjectContext save:&error];
    
    NSFetchRequest* newFetch = [[NSFetchRequest alloc]init];
    [newFetch setEntity:[NSEntityDescription entityForName:@"SquigglePoint" inManagedObjectContext:_appDelegate.managedObjectContext]];
    
    //get point that was just set to core data
    NSError* __autoreleasing error2 = nil;
    NSArray* result = [_appDelegate.managedObjectContext executeFetchRequest:newFetch error:&error2];
    STAssertNotNil(testPoint, @"should be valid point");
    STAssertEquals([result count], 1U, @"Should only be one point in DB");
    SquigglePoint* pointRead = (SquigglePoint*) [result objectAtIndex:0];
    STAssertNotNil(pointRead, @"not nil");
    STAssertEqualObjects(pointRead.xPoint, [NSNumber numberWithInt:2], @"should be 2");
    STAssertEqualObjects(pointRead.yPoint, [NSNumber numberWithInt:221], @"should be 221");
    
    Squiggle* testSquiggle = (Squiggle*)[NSEntityDescription insertNewObjectForEntityForName:@"Squiggle" inManagedObjectContext:_appDelegate.managedObjectContext];
    [testSquiggle setLineWidth:[NSNumber numberWithInt:1]];
    //[testSquiggle addPointsObject:testPoint];
    testPoint.owningSquiggle = testSquiggle;
    [_appDelegate.managedObjectContext save:&error2];
    
    NSFetchRequest* squiggleFetch = [[NSFetchRequest alloc] init];
    [squiggleFetch setEntity:[NSEntityDescription entityForName:@"Squiggle" inManagedObjectContext:_appDelegate.managedObjectContext]];
    NSArray* squiggles = [_appDelegate.managedObjectContext executeFetchRequest:squiggleFetch error:&error2];
    STAssertEquals([squiggles count], 1U, @"Should only be 1 squiggle");
    Squiggle* readSquiggle = [squiggles objectAtIndex:0U];
    STAssertEqualObjects(readSquiggle.lineWidth, [NSNumber numberWithInt:1], @"line width should be right");
    STAssertEquals([[readSquiggle points] count], 1U, @"should have one have 1 point");
    
    NSOrderedSet* squiggleSet = readSquiggle.points;
    SquigglePoint* firstPoint = [squiggleSet objectAtIndex:0];
    STAssertEqualObjects(firstPoint.xPoint, [NSNumber numberWithInt:2], @"point should have been saved to 2");
}


@end
