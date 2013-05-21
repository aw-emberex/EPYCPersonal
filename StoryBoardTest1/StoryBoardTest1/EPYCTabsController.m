//
//  EPYCTabsController.m
//  EPYCPersonal
//
//  Created by Alex Wait on 5/4/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import "EPYCTabsController.h"

@interface EPYCTabsController ()

@end

@implementation EPYCTabsController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSelectedViewController:[self.viewControllers objectAtIndex:1]];
    [self setSelectedIndex:2];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
