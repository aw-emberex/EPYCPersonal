//
//  MainViewController.m
//  Painter
//
//  Created by Edward Chiang on 2010/11/20.
//  Copyright Edward 2010. All rights reserved.
//

#import "DrawingViewController.h"

@implementation DrawingViewController


#pragma mark - UIViewController

static EPYCAppDelegate *_appDelegate = nil;


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return (toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)cancelledDrawing:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        [self cancelledDrawing];
    }];
}

- (IBAction)wantsToSaveDrawing:(id)sender {
    GameManager *manager = [GameManager getInstance];
    GameEntry *newestEntry = [manager requestLatestGameEntry];
    [createdSquiggles enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Squiggle *currentSquiggle = (Squiggle *) obj;
        currentSquiggle.owningGameEntry = newestEntry;
        CGRect mainView = [self.mainView frame];
        [newestEntry setOriginalViewportX:[NSNumber numberWithFloat:mainView.size.width]];
        [newestEntry setOriginalViewportY:[NSNumber numberWithFloat:mainView.size.height]];

    }];
    [manager saveContext];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)createdNewSquiggle:(Squiggle *)squiggle {
    NSLog(@"created %@", squiggle);
    [createdSquiggles addObject:squiggle];
}

- (void)cancelledDrawing {
    [createdSquiggles enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Squiggle *squiggle = (Squiggle *) obj;
        [_appDelegate.managedObjectContext deleteObject:squiggle];
    }];
    [createdSquiggles removeAllObjects];
    GameManager *manager = [GameManager getInstance];
    [manager saveContext];
}

- (void)erasedDrawing {
    GameEntry *latest = [[GameManager getInstance] requestLatestGameEntry];
    [latest.squiggles enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Squiggle *squiggle = (Squiggle *) obj;
        [_appDelegate.managedObjectContext deleteObject:squiggle];
    }];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    _appDelegate = (EPYCAppDelegate *) [[UIApplication sharedApplication] delegate];
    createdSquiggles = [[NSMutableArray alloc] init];
    self.mainView.drawingViewDelegate = self;
    GameEntry *latestGameEntry = [[GameManager getInstance] requestLatestGameEntry]; //get from game manager
    NSLog(@"Latest Game Entry! %@", latestGameEntry);
    NSArray *savedSquiggles = [[latestGameEntry squiggles] array];
    [self.mainView setPreviousSquiggles:savedSquiggles];
    NSArray *colors = @[@"Red", @"Green", @"Blue", @"Black"];
    colorsMenu = [[MBButtonMenuViewController alloc] initWithButtonTitles:colors];
    NSArray *lineWidths = @[@"2", @"3", @"5", @"7", @"8"];
    lineWidthMenu = [[MBButtonMenuViewController alloc] initWithButtonTitles:lineWidths];
    [colorsMenu setDelegate:self];
    [lineWidthMenu setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.view becomeFirstResponder];    // make main view the first responder
} // end method

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.view resignFirstResponder];    // make main view the first responder
}

- (void)viewDidUnload {
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (IBAction)didSelectLineButton:(id)sender {
    [lineWidthMenu showInView:[self mainView]];
}

- (IBAction)didSelectColorsButton:(id)sender {
    [colorsMenu showInView:[self mainView]];
}
- (IBAction)undoLastSquiggleAction:(id)sender {
    [createdSquiggles removeLastObject];
    [self.mainView undoLastSquiggle];
    NSLog(@"createdSquiggles %@", createdSquiggles);
}

- (void)buttonMenuViewController:(MBButtonMenuViewController *)buttonMenu buttonTappedAtIndex:(NSUInteger)index {
    if (buttonMenu == colorsMenu) {
        [colorsMenu hide];
        if (index == 0U) {
            [self setColor:[UIColor redColor]];
            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"You Picked Red"];
        }
        else if (index == 1U) {
            [self setColor:[UIColor greenColor]];
            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"You Picked Green"];
        }
        else if (index == 2U) {
            [self setColor:[UIColor blueColor]];
            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"You Picked Blue"];
        }
        else if (index == 3U) {
            [self setColor:[UIColor blackColor]];
            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"You Picked Black"];
        }
    } else if (buttonMenu == lineWidthMenu) {
        [lineWidthMenu hide];
        switch (index) {
            case 0:
                [self setLineWidth:2];
                [[TKAlertCenter defaultCenter] postAlertWithMessage:@"Line Thickness 2"];
                break;
            case 1:
                [self setLineWidth:3];
                [[TKAlertCenter defaultCenter] postAlertWithMessage:@"Line Thickness 3"];
                break;
            case 2:
                [self setLineWidth:5];
                [[TKAlertCenter defaultCenter] postAlertWithMessage:@"Line Thickness 5"];
                break;
            case 3:
                [self setLineWidth:7];
                [[TKAlertCenter defaultCenter] postAlertWithMessage:@"Line Thickness 7"];
                break;
            case 4:
                [self setLineWidth:8];
                [[TKAlertCenter defaultCenter] postAlertWithMessage:@"Line Thickness 8"];
                break;
        }
    }
}

- (void)buttonMenuViewControllerDidCancel:(MBButtonMenuViewController *)buttonMenu {
    //do nothing for now! :)
    [colorsMenu hide];
    [lineWidthMenu hide];
}


- (void)setColor:(UIColor *)color {
    DrawingView *view = (DrawingView *) self.mainView;
    view.color = color;
}

- (void)setLineWidth:(float)width {
    DrawingView *view = (DrawingView *) self.mainView;
    [view setLineWidth:width];
    NSLog(@"Line width: %f", view.lineWidth);
}

- (void)resetView {
    DrawingView *view = (DrawingView *) self.mainView;
    [view resetView];
}

@end