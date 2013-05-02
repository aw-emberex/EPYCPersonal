//
//  GameEntry.h
//  EPYCPersonal
//
//  Created by Alex Wait on 5/1/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GameData, Squiggle;

@interface GameEntry : NSManagedObject

@property (nonatomic, retain) NSString * phraseText;
@property (nonatomic, retain) GameData *owningGameData;
@property (nonatomic, retain) Squiggle *squiggle;

@end
