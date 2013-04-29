//
//  GameManager.m
//  StoryBoardTest1
//
//  Created by Alex Wait on 4/27/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import "GameManager.h"

@implementation GameManager

static GameManager* _instance = nil;
@synthesize appDelegate,gameEntryEntity,managedObjectContent, squiggleEntity,squigglePointEntity;

+(GameManager*) getInstance {
    if (_instance == nil) {
        _instance = [[self alloc] init];
    }
    return _instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        appDelegate = (EPYCAppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}

-(NSOrderedSet*)getGameEntries; {
    return nil;
}

@end
