//
//  GameDataEntryTableViewController.h
//  EPYCPersonal
//
//  Created by Alex Wait on 5/13/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface GameDataEntryTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate> {
}

@property NSMutableOrderedSet *allGameDataSets;
@property NSMutableOrderedSet *unfinishedGames;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet BButton *activeGameButton;
@property (strong, nonatomic) GameManager* gameManager;
@end
