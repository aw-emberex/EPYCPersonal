//
//  Tab1ViewController.m
//  StoryBoardTest1
//
//  Created by Alex Wait on 3/27/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import "Tab1ViewController.h"
#import "UserDataManager.h"
#import "UserCell.h"

@interface Tab1ViewController ()


@end

@implementation Tab1ViewController


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
    User* currentUser = [_userDataManager getCurrentUser];
    if (currentUser) {
        [self.userDisplayLabelView setText:[_userDataManager getCurrentUser].name];
    } else {
        [self.userDisplayLabelView setText:@"No Current User"];
    }
    
    NSLog(@"is scroll enabled %d", self.usersTableView.scrollEnabled);
    self.usersTableView.scrollEnabled = YES;
    NSLog(@"now is it? %d", self.usersTableView.scrollEnabled);

}

-(NSArray*) viewControllers {
    return [self viewControllers];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"A");
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

@end
