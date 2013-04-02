//
//  UserSelectionDelegate.h
//  StoryBoardTest1
//
//  Created by Alex Wait on 3/27/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserData.h"

@protocol CurrentUserDataSource <NSObject>

-(UserData*) didRequestCurrentUser;

@end
