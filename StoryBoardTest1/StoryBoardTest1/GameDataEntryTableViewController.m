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


- (void)viewDidLoad
{
    [super viewDidLoad];

    _allGameDataSets = [[GameManager getInstance] getAllGameData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWi3llAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    UIStoryboard* myStoryboard = self.storyboard;
    GameDataViewController* tableViewController = [myStoryboard instantiateViewControllerWithIdentifier:@"GameDataViewStoryboardController"];
    GameData* gameData = [self.allGameDataSets objectAtIndex:indexPath.row];
    [tableViewController setGameData:gameData];
    [self.navigationController pushViewController:tableViewController animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSLog(@"count %d", [_allGameDataSets count]);
    return [_allGameDataSets count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GameDataCell* cell = [tableView dequeueReusableCellWithIdentifier:@"GameDataCell"];

    if (!cell) {
        NSArray* topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"GameDataTableCell" owner:nil options:nil];
        for (id currentObject in topLevelObjects) {
            if ([currentObject isKindOfClass:[GameDataCell class]]) {
                cell = (GameDataCell*) currentObject;
                break;
            }
        }
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


@end
