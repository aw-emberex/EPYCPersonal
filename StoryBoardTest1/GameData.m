//
//  GameData.m
//  TapkuLibrary
//
//  Created by Alex Wait on 6/3/13.
//
//

#import "GameData.h"
#import "GameEntry.h"


@implementation GameData

@dynamic creationTime;
@dynamic finished;
@dynamic gameEntries;

-(void)awakeFromInsert {
    self.creationTime = [NSDate date];
}


@end
