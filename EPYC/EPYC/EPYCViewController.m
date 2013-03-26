//
//  EPYCViewController.m
//  EPYC
//
//  Created by Alex Wait on 3/16/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import "EPYCViewController.h"
#import "EPYCAppDelegate.h"
#import "Phrase.h"

@interface EPYCViewController () <UITableViewDataSource>

@end

@implementation EPYCViewController
@synthesize phraseCollection, phraseTableView;
@synthesize appDelegate = _appDelegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.phraseCollection = [[NSMutableArray alloc]init];
    EPYCAppDelegate *appDelegate = (EPYCAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.appDelegate = appDelegate;
    [self setPhraseCollection:[self getPhraseCollection]];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addPhrase:(id)sender {
    [self.phraseViewController resignFirstResponder];
   //// Phrase* newPhrase = [[Phrase alloc]initWithAll:[[self phraseViewController] text] :@"Alex Wait"];
    //[self.phraseCollection addObject:newPhrase];
    

    NSManagedObjectContext* context = _appDelegate.managedObjectContext;
    Phrase* newPhrase = [NSEntityDescription insertNewObjectForEntityForName:@"Phrase" inManagedObjectContext:context];
    [newPhrase setPhraseText: [self.phraseViewController text]]; //real setter here
    NSError* __autoreleasing error;
    BOOL wasSaveSuccessful = [context save:&error];
    
    if (!wasSaveSuccessful) {
        NSLog(@"had an error!! %@", error.localizedDescription);
    }
    else {
        NSLog(@"YAY!");
        NSMutableArray* fetchedObjects = [[NSMutableArray alloc]initWithArray:[self getPhraseCollection]];
        
        NSLog(@"%@", fetchedObjects);
        NSLog(@"LENGTH: %lu", (unsigned long)[fetchedObjects count]);
        [self setPhraseCollection:fetchedObjects];
        [self.phraseTableView reloadData];
        //[self resetAllData];
    }
    
    //[self.phraseTableView reloadData];
}

-(NSMutableArray*) getPhraseCollection {
    NSFetchRequest* request = [[NSFetchRequest alloc]init];
    NSEntityDescription* whatObject = [NSEntityDescription entityForName:@"Phrase" inManagedObjectContext:_appDelegate.managedObjectContext];
    [request setEntity:whatObject];

    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"phraseText" ascending:YES];

    [request setSortDescriptors:[[NSArray alloc] initWithObjects:sortDescriptor, nil]];
    NSError* __autoreleasing error = nil;
    
    NSMutableArray* results = [[_appDelegate.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    return results;
}
- (IBAction)resetDataAction:(id)sender {
    [self resetAllData];
    [self setPhraseCollection:[self getPhraseCollection]];
    [self.phraseTableView reloadData];
    [self.phraseViewController resignFirstResponder];
}

-(void) resetAllData {
    NSLog(@"buttonReset Pressed");
    
    //Erase the persistent store from coordinator and also file manager.
    NSPersistentStore *store = [self.appDelegate.persistentStoreCoordinator.persistentStores lastObject];
    NSError *error = nil;
    NSURL *storeURL = store.URL;
    [self.appDelegate.persistentStoreCoordinator removePersistentStore:store error:&error];
    [[NSFileManager defaultManager] removeItemAtURL:storeURL error:&error];
    
    
    NSLog(@"Data Reset");
    
    //Make new persistent store for future saves   (Taken From Above Answer)
    if (![self.appDelegate.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // do something with the error
    }
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
