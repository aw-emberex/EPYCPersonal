//
//  GameDataViewController.m
//  EPYCPersonal
//
//  Created by Alex Wait on 05/11/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import "GameDataViewController.h"
#import "DrawingView.h"

@interface GameDataViewController ()

@end

@implementation GameDataViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    ALScrollViewPaging *scrollView;
    scrollView = [[ALScrollViewPaging alloc] initWithFrame:self.mainView.frame andWithPageControl:self.myPageControl];
    self.scrollView = scrollView;
    [self.view addSubview:self.scrollView];

    NSMutableArray *testArray = [[NSMutableArray alloc] initWithCapacity:2];
    DrawingView *firstDrawingView = [self createDrawingViewWithGameEntry:[self.gameData.gameEntries objectAtIndex:0] withFrame:self.mainView.frame];
    [firstDrawingView setRespondsToTouches:NO];
    [testArray addObject:firstDrawingView];
    DrawingView *firstDrawingView2 = [self createDrawingViewWithGameEntry:[self.gameData.gameEntries objectAtIndex:0] withFrame:self.mainView.frame];
    [testArray addObject:firstDrawingView2];
    [[self scrollView] addPages:testArray];
}

- (DrawingView *)createDrawingViewWithGameEntry:(GameEntry *)gameEntry withFrame:(CGRect)frame {
    DrawingView* newDrawingView = [[DrawingView alloc] initWithFrame:frame];
    [newDrawingView setPreviousSquiggles:[[gameEntry squiggles] array]];
    return newDrawingView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
