//
//  CurrentGameDisplayController.m
//  EPYCPersonal
//
//  Created by Alex Wait on 5/28/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import "CurrentGameDisplayController.h"
#import "UIView+AnimateHidden.h"
#import "DrawingViewController.h"

@interface CurrentGameDisplayController ()

@end

@implementation CurrentGameDisplayController

@synthesize nextTurnButton = _nextTurnButton;
@synthesize endGameButton = _endGameButton;
@synthesize lastPhraseTextLabel = _lastPhraseTextLabel;
@synthesize latestDrawingView = _latestDrawingView;
@synthesize gameManager = _gameManager;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.lastPhraseTextLabel setHidden:YES];
        self.latestDrawingView.respondsToTouches = NO;
        self.latestDrawingView.hidden = YES;
        _gameManager = [GameManager getInstance];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nextTurnAction:(id)sender {
    GameEntry *latestGameEntry = [_gameManager requestLatestGameEntry];
    if ([[latestGameEntry squiggles] count] == 0) {
        UIStoryboard *myStoryboard = self.storyboard;
        DrawingViewController *drawingViewController = [myStoryboard instantiateViewControllerWithIdentifier:@"DrawingViewController"];
        [drawingViewController setDelegate:self];
        [self presentViewController:drawingViewController animated:YES completion:^{

        }];
        NSLog(@"Starting");
    } else {

    }
}

- (IBAction)endGameAction:(id)sender {


}
- (IBAction)enteredPhraseTextAction:(id)sender {
    NSString* phrase = self.phraseEnteredTextView.text;
    [_gameManager setCurrentGameDataPhraseText:phrase];
}

- (void)savedSquiggles:(NSOrderedSet *)squigglesSaved {
    NSLog(@"Saved Squiggles %@", squigglesSaved);
}

@end
