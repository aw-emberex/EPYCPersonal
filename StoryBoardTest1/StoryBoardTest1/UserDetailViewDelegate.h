//
//  UserDetailViewDelegate.h
//  StoryBoardTest1
//
//  Created by Alex Wait on 4/16/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@protocol UserDetailViewDelegate <NSObject>
- (void)didCancelDialog;

- (void)didAddUser:(User *)userAdded;

- (User *)didRequestUser;
@end
