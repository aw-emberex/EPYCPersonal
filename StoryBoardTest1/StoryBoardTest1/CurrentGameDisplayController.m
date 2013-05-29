//
//  CurrentGameDisplayController.m
//  EPYCPersonal
//
//  Created by Alex Wait on 5/28/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import "CurrentGameDisplayController.h"

@interface CurrentGameDisplayController ()

@end

@implementation CurrentGameDisplayController

@synthesize nextTurnButton = _nextTurnButton;
@synthesize endGameButton = _endGameButton;
@synthesize lastPhraseTextLabel = _lastPhraseTextLabel;
@synthesize latestDrawingView = _latestDrawingView;

@synthesize gameManager = _gameManager;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.latestDrawingView setHidden:YES];
        self.latestDrawingView.respondsToTouches = NO;
        self.latestDrawingView.hidden = YES;
        _gameManager = [GameManager getInstance];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)nextTurnAction:(id)sender {

}
- (IBAction)endGameAction:(id)sender {
}

@end
