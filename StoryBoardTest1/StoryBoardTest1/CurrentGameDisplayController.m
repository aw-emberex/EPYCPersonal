//
//  CurrentGameDisplayController.m
//  EPYCPersonal
//
//  Created by Alex Wait on 5/28/13.
//  Copyright (c) 2013 Emberex. All rights reserved.

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
@synthesize mainGameData = _mainGameData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _gameManager = [GameManager getInstance];
    [_gameManager setMainGameData:self.mainGameData];
    self.latestDrawingView.respondsToTouches = NO;
    [self changeGameMode];
}

- (void)changeGameMode {
    GameEntry* latestEntry = [self getLatestEntry];
    NSOrderedSet *allGameEntries = [[_gameManager getMainGameData] gameEntries];
    if ([latestEntry isPhraseEntryMode]) {
        if ([allGameEntries count] == 1) {
            [self.latestDrawingView setHidden:YES];
            [self.phrasePromptTextLabel setText:@"Beginning Phrase"];
            [_nextTurnButton setTitle:@"Enter Beginning Phrase" forState:UIControlStateNormal];
        } else {
            GameEntry* previousEntry = [allGameEntries objectAtIndex:[allGameEntries count]-2];
            NSLog(@"Previous Entry %@", previousEntry);
            [self.latestDrawingView setHiddenAnimated:NO withDuration:1.5];
            [self.latestDrawingView setPreviousSquiggles:[previousEntry.squiggles array]];
            [self.latestDrawingView setNeedsDisplay];
            [_nextTurnButton setTitle:@"Enter Phrase" forState:UIControlStateNormal];
            [self.phrasePromptTextLabel setText:@"What was drawn?"];
        }
        [self.phraseTextLabelView setHidden:NO];
        [self.previousPhraseView setHidden:YES];
    } else {
        //Drawing turn
        NSLog(@"drawing turn! %@", latestEntry);
        [self.previousPhraseDisplayLabel setText:latestEntry.phraseText];
        [self.previousPhraseView setHidden:NO];
        [_nextTurnButton setTitle:@"Draw the Phrase" forState:UIControlStateNormal];
        [self.latestDrawingView setHidden:YES];
        [self.phraseTextLabelView setHidden:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)nextTurnAction:(id)sender {
    GameEntry *latestGameEntry= [self getLatestEntry];
    if ([latestGameEntry isPhraseEntryMode] == NO) {
        if ([latestGameEntry.squiggles count] != 0) {
            [_gameManager createNewGameEntry];
        }
        UIStoryboard *myStoryboard = self.storyboard;
        DrawingViewController *drawingViewController = [myStoryboard instantiateViewControllerWithIdentifier:@"DrawingViewController"];
        [drawingViewController setDelegate:self];
        [self presentViewController:drawingViewController animated:YES completion:^{
            [self changeGameMode];
        }];
    } else {
        NSString* phrase = self.phraseEnteredTextView.text;
        NSLog(@"User entered %@", phrase);
        [_gameManager setCurrentGameDataPhraseText:phrase];
        [self.phraseEnteredTextView resignFirstResponder];
        [self.phraseEnteredTextView setText:@""];
        [self changeGameMode];
    }
}

- (GameEntry *)getLatestEntry {
    GameEntry *latestGameEntry = [_gameManager requestLatestGameEntry];
    return latestGameEntry;
}

- (IBAction)endGameAction:(id)sender {
    [_gameManager getMainGameData].finished = [NSNumber numberWithBool:YES];
    [_gameManager saveContext];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)savedSquiggles:(NSOrderedSet *)squigglesSaved {
    [_gameManager createNewGameEntry];
    [self changeGameMode];
}

@end
