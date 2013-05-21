//
//  Tab1ViewController.h
//  StoryBoardTest1
//
//  Created by Alex Wait on 3/27/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserDataManager.h"
#import "UserDetailViewDelegate.h"

@interface UsersViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UserDetailViewDelegate>

-(NSString*) test;

@property (readonly, nonatomic) UserDataManager* userDataManager;
@property (weak, nonatomic) IBOutlet UINavigationItem *userDisplayLabelViewold;
@property (weak, nonatomic) IBOutlet UITableView *usersTableView;
@property (weak, nonatomic) IBOutlet UINavigationItem *userDisplayLabelView;

@end
