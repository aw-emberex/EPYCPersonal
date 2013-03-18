//
//  EPYCViewController.m
//  EPYC
//
//  Created by Alex Wait on 3/16/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import "EPYCViewController.h"
#import "Phrase.h"

@interface EPYCViewController () <UITableViewDataSource>

@end

@implementation EPYCViewController
@synthesize phraseCollection, phraseTableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.phraseCollection = [[NSMutableArray alloc]init];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addPhrase:(id)sender {
    [self.phraseViewController resignFirstResponder];
    Phrase* newPhrase = [[Phrase alloc]initWithAll:[[self phraseViewController] text] :@"Alex Wait"];
    [self.phraseCollection addObject:newPhrase];
    [self.phraseTableView reloadData];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.phraseCollection count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* tableIdentifier = @"EPYC Phrase Table";
    UITableViewCell* currentCell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    
    if (currentCell == nil) {
        currentCell =  [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    currentCell.textLabel.text = [[self.phraseCollection objectAtIndex:indexPath.row] phraseText];
    return currentCell;
}


@end
