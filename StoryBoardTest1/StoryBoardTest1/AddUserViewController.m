//
//  AddUserViewController.m
//  StoryBoardTest1
//
//  Created by Alex Wait on 4/16/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import "AddUserViewController.h"

@interface AddUserViewController ()

@end

@implementation AddUserViewController

@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.delegate didCancelDialog];
}

- (BOOL)validateForm {
    NSString *name = [[self.userNameTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([name isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Must Provide Name" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        return NO;
    }
    return YES;
}

- (IBAction)didAddUser:(id)sender {
    if ([self validateForm]) {
        User *dbUser = [self.delegate didRequestUser];
        [dbUser setName:self.userNameTextField.text];
        [self.delegate didAddUser:dbUser];
        [self.userNameTextField resignFirstResponder];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
