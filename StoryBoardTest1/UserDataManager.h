//
//  UserDataManager.h
//  StoryBoardTest1
//
//  Created by Alex Wait on 3/31/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "EPYCAppDelegate.h"

@interface UserDataManager : NSObject

@property (readonly, nonatomic) User* currentUser;
@property (readonly, nonatomic) EPYCAppDelegate* appDelegate;
@property (readonly, nonatomic) NSEntityDescription* userEntity;

+(UserDataManager*) getUserDataManager;
-(NSArray*) getUsers;
-(User*) getCurrentUser;

@end


