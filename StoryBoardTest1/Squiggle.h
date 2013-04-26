//
//  Squiggle.h
//  StoryBoardTest1
//
//  Created by Alex Wait on 4/25/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SquigglePoint;

@interface Squiggle : NSManagedObject

@property (nonatomic, retain) NSNumber * lineWidth;
@property (nonatomic, retain) SquigglePoint *points;

@end
