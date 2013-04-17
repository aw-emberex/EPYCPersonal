//
//  Tab1ViewController.m
//  StoryBoardTest1
//
//  Created by Alex Wait on 3/27/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import "UsersViewController.h"
#import "UserDataManager.h"
#import "UserCell.h"
#import "AddUserViewController.h"

@interface UsersViewController ()


@end

@implementation UsersViewController


@synthesize userDataManager = _userDataManager;
@synthesize userDisplayLabelView, usersTableView;

-(id) init {
    return [super init];
}

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
    _userDataManager = [UserDataManager getUserDataManager];
    [self updateLabels];
    self.usersTableView.scrollEnabled = YES;
}

-(void) updateLabels {
    User* currentUser = [_userDataManager getCurrentUser];
    if (currentUser) {
        [self.userDisplayLabelView setTitle:[NSString stringWithFormat:@"Current User: %@", currentUser.name]];
    } else {
        [self.userDisplayLabelView setTitle:@"No Current User"];
    }
}

-(NSArray*) viewControllers {
    return [self viewControllers];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString*) test {
    return @"aaasa";
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%d", [[_userDataManager getUsers] count]);
    return [[_userDataManager getUsers] count];
}

-(UserCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Users Table"];
    
    if (!cell) {
        NSArray* topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"UserCell" owner:nil options:nil];
        for (id currentObject in topLevelObjects) {
            if ([currentObject isKindOfClass:[UserCell class]]) {
                cell = (UserCell*) currentObject;
                break;
            }
        }
    }
    
    [cell setUserNameText:[[[_userDataManager getUsers] objectAtIndex:indexPath.row] name ]];
    [cell setNumberLabelText:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray* users = [_userDataManager getUsers];
    User* newSelectedUser = [users objectAtIndex:indexPath.row];
    [_userDataManager setCurrentUser:newSelectedUser];
    [self updateLabels];
}

-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_userDataManager deleteUserAtIndex:indexPath.row];
    }
    [self updateLabels];
    [self.usersTableView reloadData];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"userDetails"]) {
        UINavigationController* nav = segue.destinationViewController;
        AddUserViewController* segueDestination = [[nav viewControllers] objectAtIndex:0];
        [segueDestination setDelegate:self];
        NSLog(@"SUCCESS");
        
    }
}

-(void)didCancelDialog {
    NSLog(@"cancelled");
}

-(void)didAddUser:(User*)userToAdd {
    [_userDataManager addNewUser:userToAdd];
}

@end
