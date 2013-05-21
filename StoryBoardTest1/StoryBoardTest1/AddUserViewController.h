//
//  AddUserViewController.h
//  StoryBoardTest1
//
//  Created by Alex Wait on 4/16/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserDetailViewDelegate.h"

@interface AddUserViewController : UIViewController
- (IBAction)didCancel:(id)sender;

@property(weak, nonatomic) IBOutlet UITextField *userNameTextField;

- (void)setDelegate:(id <UserDetailViewDelegate>)delegate;

@property(readwrite, nonatomic) id <UserDetailViewDelegate> delegate;
@end
