//
//  Tab1ViewController.h
//  StoryBoardTest1
//
//  Created by Alex Wait on 3/27/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserDataManager.h"

@interface Tab1ViewController : UIViewController

-(NSArray*) viewControllers;
-(NSString*) test;

@property (readonly, nonatomic) UserDataManager* userDataManager;

@end
