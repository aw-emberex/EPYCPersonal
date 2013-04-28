//
//  Squiggle.h
//  StoryBoardTest1
//
//  Created by Alex Wait on 4/27/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SquigglePoint;

@interface Squiggle : NSManagedObject

@property (nonatomic, retain) NSNumber * lineWidth;
@property (nonatomic, retain) NSSet *points;
@end

@interface Squiggle (CoreDataGeneratedAccessors)

- (void)addPointsObject:(SquigglePoint *)value;
- (void)removePointsObject:(SquigglePoint *)value;
- (void)addPoints:(NSSet *)values;
- (void)removePoints:(NSSet *)values;

@end
