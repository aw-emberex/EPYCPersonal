//
//  GameManager.h
//  StoryBoardTest1
//
//  Created by Alex Wait on 4/27/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Squiggle.h"
#import "SquigglePoint.h"
#import "GameEntry.h"
#import "EPYCAppDelegate.h"
#import <CoreData/CoreData.h>


@interface GameManager : NSObject {
    
}

+(GameManager*) getInstance;
-(NSOrderedSet*)getGameEntries;
@property (readonly, nonatomic) NSEntityDescription* squiggleEntity;
@property (readonly, nonatomic) NSEntityDescription* squigglePointEntity;
@property (readonly, nonatomic) NSEntityDescription* gameEntryEntity;
@property (readonly, nonatomic) EPYCAppDelegate* appDelegate;
@property (readonly, nonatomic) NSManagedObjectContext* managedObjectContent;

@end
