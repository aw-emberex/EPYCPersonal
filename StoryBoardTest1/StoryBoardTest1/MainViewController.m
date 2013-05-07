//
//  MainViewController.m
//  Painter
//
//  Created by Edward Chiang on 2010/11/20.
//  Copyright Edward 2010. All rights reserved.
//

#import "MainViewController.h"
#import "MainView.h"

@implementation MainViewController


#pragma mark - UIViewController

static EPYCAppDelegate* _appDelegate = nil;


-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
  return (toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(IBAction)cancelledDrawing:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"Dismissed!");
        [self cancelledDrawing];
    }];
}

-(IBAction)wantsToSaveDrawing:(id)sender {
    GameManager* manager = [GameManager getInstance];
    GameEntry* newestEntry = [manager requestLatestGameEntry];
    [createdSquiggles enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Squiggle* currentSquiggle = (Squiggle*)obj;
        currentSquiggle.owningGameEntry = newestEntry;
        NSLog(@"saving......%@", currentSquiggle);

    }];
    [manager saveContext];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)createdNewSquiggle:(Squiggle *)squiggle {
    NSLog(@"created %@", squiggle);
    [createdSquiggles addObject:squiggle];
}

-(void)cancelledDrawing {
    [createdSquiggles enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Squiggle* squiggle = (Squiggle*)obj;
        NSLog(@"deleting %@", squiggle);
        [_appDelegate.managedObjectContext deleteObject:squiggle];
    }];
    GameManager* manager = [GameManager getInstance];
    [manager saveContext];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
  [super viewDidLoad];
    _appDelegate = (EPYCAppDelegate *)[[UIApplication sharedApplication] delegate];
    createdSquiggles = [[NSMutableArray alloc] init];
    self.mainView.drawingViewDelegate = self;
    GameEntry* latestGameEntry = [[GameManager getInstance] requestLatestGameEntry]; //get from game manager
    NSLog(@"Latest Game Entry! %@", latestGameEntry);
    NSArray* savedSquiggles = [[latestGameEntry squiggles] array];
    [self.mainView setPreviousSquiggles:savedSquiggles];
    NSArray* colors = @[@"Red", @"Green", @"Blue", @"Black"];
    colorsMenu = [[MBButtonMenuViewController alloc] initWithButtonTitles:colors];
    [colorsMenu setDelegate:self];
}

- (void)didReceiveMemoryWarning {
  // Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
  // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [self.view becomeFirstResponder];	// make main view the first responder
} // end method

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
  [self.view resignFirstResponder];	// make main view the first responder
}

- (void)viewDidUnload {
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}

-(IBAction)didSelectLineButton:(id)sender {
    
}

-(IBAction)didSelectColorsButton:(id)sender {
    [colorsMenu showInView:[self mainView]];
}

-(void)buttonMenuViewController:(MBButtonMenuViewController *)buttonMenu buttonTappedAtIndex:(NSUInteger)index {
    NSLog(@"Did click!");
    [colorsMenu hide];
}

-(void)buttonMenuViewControllerDidCancel:(MBButtonMenuViewController *)buttonMenu {
    //do nothing for now! :)
    [colorsMenu hide];
}


- (void)setColor:(UIColor *)color{
  MainView *view = (MainView *)self.view;
  view.color = color;
}

- (void)setLineWidth:(float)width {
  MainView *view = (MainView *)self.view;
  [view setLineWidth:width];
  NSLog(@"Line width: %f", view.lineWidth);
}

- (void)resetView {
  MainView *view = (MainView *)self.view;
  [view resetView];
}

@end