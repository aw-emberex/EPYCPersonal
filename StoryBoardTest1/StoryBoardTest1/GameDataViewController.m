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
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    ALScrollViewPaging *scrollView;
    scrollView = [[ALScrollViewPaging alloc] initWithFrame:self.mainView.frame withPageControl:self.myPageControl];
    self.scrollView = scrollView;
    [self.view addSubview:self.scrollView];

    NSMutableArray *pages = [[NSMutableArray alloc] initWithCapacity:2];

    [_gameData.gameEntries enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        GameEntry* entry = (GameEntry*)obj;
        if ([entry.squiggles count] == 0) return;
        DrawingView *drawingView = [self createDrawingViewWithGameEntry:entry withFrame:self.mainView.frame];
        [drawingView setBackgroundColor:[UIColor whiteColor]];
        [pages addObject:drawingView];
    }];
    [[self scrollView] addPages:pages];
    [self.scrollView setEventDelegate:self];
    self.phraseTextLabel.text = [[_gameData.gameEntries objectAtIndex:0] phraseText];
}

- (DrawingView *)createDrawingViewWithGameEntry:(GameEntry *)gameEntry withFrame:(CGRect)frame {
    DrawingView* newDrawingView = [[DrawingView alloc] initWithFrame:frame];
    [newDrawingView setPreviousSquiggles:[[gameEntry squiggles] array]];
    return newDrawingView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)changedPage:(NSInteger)newPage {
    GameEntry* current = [self.gameData.gameEntries objectAtIndex:newPage];
    self.phraseTextLabel.text = current.phraseText;
}

@end