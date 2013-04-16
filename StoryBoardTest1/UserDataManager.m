//
//  UserDataManager.m
//  StoryBoardTest1
//
//  Created by Alex Wait on 3/31/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import "UserDataManager.h"
#import "User.h"

@implementation UserDataManager

@synthesize currentUser = _currentUser;
@synthesize appDelegate = _appDelegate;
@synthesize userEntity = _userEntity;
@synthesize currentUserList;

static UserDataManager* _selfSingleton = nil;

+(UserDataManager*) getUserDataManager {
    
    @synchronized([UserDataManager class]) {
        if (!_selfSingleton) {
            _selfSingleton = [[UserDataManager alloc]init];
        }
        return _selfSingleton;
    }
    return nil;
}

- (id) init {
    if (self = [super init]) {
        _appDelegate = (EPYCAppDelegate *)[[UIApplication sharedApplication] delegate];
        //other stuff here
        _userEntity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:_appDelegate.managedObjectContext];
    }
    //[self addNewUser:@"alex"];
    //NSLog(@"All Users %@",[self getUsers]);
    return self;
};

-(User*) getCurrentUser { //cache this until set
    NSFetchRequest* newFetch = [[NSFetchRequest alloc]init];
    //BAD
    NSPredicate* pred = [NSPredicate predicateWithFormat:@"isSelectedUser == true"];
//    NSPredicate* pred2 = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
//        bool test = [bindings objectForKey:@"isSelectedUser"];
//        if (test) {
//            return YES;
//        }
//        return NO;
//    }];
    [newFetch setEntity:_userEntity];
    [newFetch setPredicate:pred];
    
    NSError* __autoreleasing error = nil;
    NSArray* result = [_appDelegate.managedObjectContext executeFetchRequest:newFetch error:&error];
    NSLog(@"%@", result);
    if ([result count] > 0) {
        return [result objectAtIndex:0];
    }    
    return nil;
}

-(NSArray*) getUsers {
    if (self.currentUserList) {
        return self.currentUserList;
    }
    NSFetchRequest* newFetch = [[NSFetchRequest alloc]init];
    [newFetch setEntity:_userEntity];
    [newFetch setReturnsObjectsAsFaults:NO];
    NSError* __autoreleasing error = nil;
    NSArray* tempArray = [_appDelegate.managedObjectContext executeFetchRequest:newFetch error:&error];
    NSMutableArray* result = [[NSMutableArray alloc] initWithArray:tempArray];
    
    if (!self.currentUserList) {
        self.currentUserList = result;
    }
    return result;
}

-(void)setCurrentUser: (User*)newCurrentUser {
    User* oldUser = [self getCurrentUser];
    oldUser.isSelectedUser = [NSNumber numberWithBool:NO];
    newCurrentUser.isSelectedUser = [NSNumber numberWithBool:YES];
    NSError* __autoreleasing error;
    [_appDelegate.managedObjectContext save:&error];
}

-(void) addNewUser: (NSString*) userName {
    self.currentUserList = nil;
    User* user = (User*) [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:_appDelegate.managedObjectContext];
    user.isSelectedUser = [NSNumber numberWithBool:NO];
    user.name = userName;
    NSError* __autoreleasing error;
    [_appDelegate.managedObjectContext save:&error];
}

-(void)deleteUser:(User*)userToDelete {
    NSLog(@"deleting %@", userToDelete);
    NSLog(@"deleting %d", [self.currentUserList count]);
    [self.currentUserList removeObject:userToDelete];
    NSLog(@"deleting %d", [self.currentUserList count]);
    NSError* __autoreleasing error;
    [self.appDelegate.managedObjectContext deleteObject:userToDelete];
    [self.appDelegate.managedObjectContext save:&error];
    self.currentUserList = nil;
    [self getUsers];
}

-(void)deleteUserAtIndex:(int)index {
    User* user = [self.currentUserList objectAtIndex:index];
    [self deleteUser:user];
}

@end
