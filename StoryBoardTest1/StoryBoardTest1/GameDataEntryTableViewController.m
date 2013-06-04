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
#import "CurrentGameDisplayController.h"

@interface GameDataEntryTableViewController ()

@end

@implementation GameDataEntryTableViewController

@synthesize allGameDataSets = _allGameDataSets;
@synthesize unfinishedGames = _unfinishedGames;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadGameData];
    [self.navigationController setDelegate:self];
}

- (void)loadGameData {
    _allGameDataSets = [[GameManager getInstance] getAllFinishedGameData];
    _unfinishedGames = [[GameManager getInstance] getActiveGameData];
    self.gameManager = [GameManager getInstance];
    NSLog(@"all %@, un %@", _allGameDataSets, _unfinishedGames);
    if([_unfinishedGames count] == 0) {
        //[_gameManager createNewGameData];
        _unfinishedGames = [[GameManager getInstance] getActiveGameData];
        [_activeGameButton setTitle:@"Start New Game" forState:UIControlStateNormal];
        NSLog(@"Creating new one");
    } else {
        [_activeGameButton setTitle:@"Active Game" forState:UIControlStateNormal];
    }
}

-(BOOL)updateButtonTitle {
    if ([_unfinishedGames count] > 0) {
        GameData* blah = [_unfinishedGames objectAtIndex:0];
        [_activeGameButton setTitle:@"Start New Game" forState:UIControlStateNormal];
    } else {
        [_activeGameButton setTitle:@"Active Game" forState:UIControlStateNormal];
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (navigationController == self.navigationController && viewController == self) {
        NSLog(@"reloading...");
        [self loadGameData];
        [self.tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)presentActiveGameAction:(id)sender {
    if ([_unfinishedGames count] == 0) {
        [_gameManager createNewGameData];
        _unfinishedGames = [self.gameManager getActiveGameData];
    }
    GameData* mainData = [_unfinishedGames objectAtIndex:0]; //TODO: should only be atm -- but -- Do more!
    [self.gameManager setMainGameData:mainData];
    UIStoryboard *myStoryboard = self.storyboard;
    CurrentGameDisplayController *currentGameDataController = [myStoryboard instantiateViewControllerWithIdentifier:@"CurrentGameDataController"];
    currentGameDataController.mainGameData = mainData;
    [self.navigationController pushViewController:currentGameDataController animated:YES];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
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
