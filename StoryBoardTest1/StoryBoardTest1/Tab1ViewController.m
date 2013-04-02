//
//  Tab1ViewController.m
//  StoryBoardTest1
//
//  Created by Alex Wait on 3/27/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import "Tab1ViewController.h"
#import "UserDataManager.h"

@interface Tab1ViewController ()


@end

@implementation Tab1ViewController


@synthesize userDataManager = _userDataManager;

-(id) init {
    NSLog(@"test!!!!!");
    return [super init];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _userDataManager = [UserDataManager getUserDataManager];
   // NSLog(@"all users: %@", [_userDataManager getUsers]);
    NSLog(@"loaded tab view 1 controller");
	// Do any additional setup after loading the view.
}

-(NSArray*) viewControllers {
    return [self viewControllers];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"A");
}

-(NSString*) test {
    return @"aaasa";
}

@end
