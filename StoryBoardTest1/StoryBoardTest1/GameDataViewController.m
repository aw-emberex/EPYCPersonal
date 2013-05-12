//
//  GameDataViewController.m
//  EPYCPersonal
//
//  Created by Alex Wait on 05/11/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import "GameDataViewController.h"
#import "GCPagedScrollView.h"

@interface GameDataViewController ()

@end

@implementation GameDataViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    ALScrollViewPaging* scrollView;
    scrollView = [[ALScrollViewPaging alloc] initWithFrame:self.mainView.frame];
    self.scrollView = scrollView;
    [self.view addSubview:self.scrollView];

    NSMutableArray * testArray = [[NSMutableArray alloc] initWithCapacity:2];
    [testArray addObject:[self addThing]];
    [testArray addObject:[self addThing]];
    [testArray addObject:[self addThing]];
    [testArray addObject:[self addThing]];
    [testArray addObject:[self addThing]];

    [self.scrollView addPages:testArray];

    [self.scrollView setHasPageControl:YES];




    //[self.mainView addSubview:scrollView];
    

//    // dCGRect test = CGRectMake(0, 0, 300, 300);
//    GCPagedScrollView* scrollView = [[GCPagedScrollView alloc] initWithFrame:self.mainView.frame withPageControl:self.myPageControl];
//
//    //[self s]
//    [self.mainView addSubview:scrollView];
//    self.scrollView = scrollView;
//   // [self.scrollView setBackgroundColor:[UIColor blackColor]];
//
//
//    [self addThing];
//    [self addThing];
//    [self addThing];
//    [self addThing];
}

-(UIView*) addThing {
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.frame.size.width+0,
            self.scrollView.frame.size.height+0)];

    UILabel* numberLabel = [[UILabel alloc] initWithFrame:view.bounds];
    numberLabel.text = [NSString stringWithFormat:@"%d", 1];
    [numberLabel setTextColor:[UIColor redColor]];
    [view setBackgroundColor:[UIColor greenColor]];
    [view setAlpha:1];
    numberLabel.font = [UIFont boldSystemFontOfSize:50.0];
    [view addSubview:numberLabel];
    return view;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
