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
#import "GameData.h"

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
    }
    return self;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _gameManager = [GameManager getInstance];
    self.latestDrawingView.respondsToTouches = NO;
    [self changeGameMode];
    // Do any additional setup after loading the view.
}

- (void)changeGameMode {
    GameEntry* latestEntry = [self getLatestEntry];
    if ([latestEntry isPhraseEntryMode]) {
        NSLog(@"phrase turn! %@", latestEntry);
        [_nextTurnButton setTitle:@"Enter Phrase" forState:UIControlStateNormal];
        [self.latestDrawingView setHiddenAnimated:NO withDuration:1.5];
        [self.phraseTextLabelView setHidden:NO];
        [self.previousPhraseView setHidden:YES];
        [self.latestDrawingView setPreviousSquiggles:latestEntry.squiggles];
        [self.latestDrawingView setNeedsDisplay];
    } else {
        //get previous drawing!
        GameEntry* secondLatest = [[[_gameManager getMainGameData] gameEntries] lastObject];
        NSLog(@"drawing turn! %@", latestEntry);
        [self.previousPhraseDisplayLabel setText:latestEntry.phraseText];
        [self.previousPhraseView setHidden:NO];
        [_nextTurnButton setTitle:@"Take Drawing Turn" forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nextTurnAction:(id)sender {
    GameEntry *latestGameEntry= [self getLatestEntry];
    if ([latestGameEntry isPhraseEntryMode] == NO) {
        UIStoryboard *myStoryboard = self.storyboard;
        DrawingViewController *drawingViewController = [myStoryboard instantiateViewControllerWithIdentifier:@"DrawingViewController"];
        [drawingViewController setDelegate:self];
        [self presentViewController:drawingViewController animated:YES completion:^{
            NSLog(@"done");
            [self changeGameMode];
        }];
    } else {
        //nothing here, will be taken care of by enter phrase button
    }
}

- (GameEntry *)getLatestEntry {
    GameEntry *latestGameEntry = [_gameManager requestLatestGameEntry];
    return latestGameEntry;
}

- (IBAction)endGameAction:(id)sender {
}

- (IBAction)enteredPhraseTextAction:(id)sender {
    NSString* phrase = self.phraseEnteredTextView.text;
    NSLog(@"User entered %@", phrase);
    [_gameManager setCurrentGameDataPhraseText:phrase];
    [self.phraseEnteredTextView resignFirstResponder];
    [self changeGameMode];
}

- (void)savedSquiggles:(NSOrderedSet *)squigglesSaved {
    //NSLog(@"Saved Squiggles %@", squigglesSaved);
    [_gameManager createNewGameEntry];
    //[_gameManager setCurrentGameEntrySquiggles:squigglesSaved];
    [self changeGameMode];
}

@end
