//
//  CurrentGameDisplayController.h
//  EPYCPersonal
//
//  Created by Alex Wait on 5/28/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawingView.h"

@interface CurrentGameDisplayController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *nextTurnButton;
@property (weak, nonatomic) IBOutlet UIButton *endGameButton;
@property (weak, nonatomic) IBOutlet UILabel *lastPhraseTextLabel;
@property (weak, nonatomic) IBOutlet DrawingView *latestDrawingView;
@property (strong, nonatomic) GameManager * gameManager;

@end
