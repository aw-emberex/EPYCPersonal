//
//  GameData.m
//  EPYCPersonal
//
//  Created by Alex Wait on 5/28/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import "GameData.h"
#import "GameEntry.h"


@implementation GameData

@dynamic creationTime;
@dynamic gameEntries;

-(void)awakeFromInsert {
    self.creationTime = [NSDate date];
}

@end
