//
//  GameDataEntryTableViewController.m
//  EPYCPersonal
//
//  Created by Alex Wait on 5/13/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import "GameDataEntryTableViewController.h"
#import "GameDataViewController.h"
#import "GameDataCell.h"

@interface GameDataEntryTableViewController ()

@end

@implementation GameDataEntryTableViewController

@synthesize allGameDataSets = _allGameDataSets;


- (void)viewDidLoad {
    [super viewDidLoad];
    _allGameDataSets = [[GameManager getInstance] getAllGameData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)presentActiveGameAction:(id)sender {
    
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *myStoryboard = self.storyboard;
    GameDataViewController *tableViewController = [myStoryboard instantiateViewControllerWithIdentifier:@"GameDataViewStoryboardController"];
    GameData *gameData = [self.allGameDataSets objectAtIndex:indexPath.row];
    [tableViewController setGameData:gameData];
    [self.navigationController pushViewController:tableViewController animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSLog(@"count %d", [_allGameDataSets count]);
    return [_allGameDataSets count];
}

- (GameDataCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GameDataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GameDataCell"];

    if (!cell) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"GameDataTableCell" owner:nil options:nil];
        for (id currentObject in topLevelObjects) {
            if ([currentObject isKindOfClass:[GameDataCell class]]) {
                cell = (GameDataCell *) currentObject;
                NSDate* createdTime = [[_allGameDataSets objectAtIndex:indexPath.row] creationTime];
                NSString* date = [NSDateFormatter localizedStringFromDate:createdTime dateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterBehaviorDefault];
                cell.timeCreatedLabel.text = [NSString stringWithFormat:@"@ %@", date];
                break;
            }
        }
    }

    return cell;
}
@end
