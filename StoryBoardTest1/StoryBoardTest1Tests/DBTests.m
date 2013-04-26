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
    
    NSFetchRequest* newFetch = [[NSFetchRequest alloc]init];
    [newFetch setEntity:[NSEntityDescription entityForName:@"SquigglePoint" inManagedObjectContext:_appDelegate.managedObjectContext]];
    
    NSError* __autoreleasing error2 = nil;
    NSArray* result = [_appDelegate.managedObjectContext executeFetchRequest:newFetch error:&error2];
    
    NSSet* toDelete =[[NSSet alloc] initWithArray:result];
    [toDelete enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        NSLog(@"Deleting!");
        [_appDelegate.managedObjectContext deleteObject:obj];
    }];    
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
    
    NSError* __autoreleasing error2 = nil;
    NSArray* result = [_appDelegate.managedObjectContext executeFetchRequest:newFetch error:&error2];
    STAssertNotNil(testPoint, @"should be valid point");
    STAssertEquals([result count], 1U, @"Should only be one point in DB");
    SquigglePoint* pointRead = (SquigglePoint*) [result objectAtIndex:0];
    STAssertNotNil(pointRead, @"not nil");
    STAssertEqualObjects(pointRead.xPoint, [NSNumber numberWithInt:2], @"should be 2");
    STAssertEqualObjects(pointRead.yPoint, [NSNumber numberWithInt:221], @"should be 221");
}

- (void) testAddUser {
    STAssertTrue(YES, @"A");
}

@end
