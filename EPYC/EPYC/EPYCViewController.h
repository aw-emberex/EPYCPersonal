//
//  EPYCViewController.h
//  EPYC
//
//  Created by Alex Wait on 3/16/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EPYCViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UITextView *phraseViewController;
@property (strong, nonatomic) NSMutableArray* phraseCollection;
@property (weak, nonatomic) IBOutlet UITableView *phraseTableView;

@end
