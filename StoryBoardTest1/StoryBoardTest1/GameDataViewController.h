//
//  GameDataViewController.h
//  EPYCPersonal
//
//  Created by Alex Wait on 05/11/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCPagedScrollView.h"

@class GCPagedScrollView;

@interface GameDataViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel* someLabel;
@property (strong, nonatomic) IBOutlet ALScrollViewPaging *scrollView;
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIPageControl *myPageControl;

@end
