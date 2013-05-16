//
//  GameDataEntryTableViewController.h
//  EPYCPersonal
//
//  Created by Alex Wait on 5/13/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameDataEntryTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {}

@property NSMutableOrderedSet * allGameDataSets;

@end
