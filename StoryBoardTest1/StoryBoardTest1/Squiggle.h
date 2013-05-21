//
//  Squiggle.h
//  EPYCPersonal
//
//  Created by Alex Wait on 5/6/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GameEntry, SquigglePoint;

@interface Squiggle : NSManagedObject

@property(nonatomic, retain) NSNumber *lineWidth;
@property(nonatomic, retain) NSNumber *colorRed;
@property(nonatomic, retain) NSNumber *colorGreen;
@property(nonatomic, retain) NSNumber *colorBlue;
@property(nonatomic, retain) GameEntry *owningGameEntry;
@property(nonatomic, retain) NSOrderedSet *points;
@end

@interface Squiggle (CoreDataGeneratedAccessors)

- (void)insertObject:(SquigglePoint *)value inPointsAtIndex:(NSUInteger)idx;

- (void)removeObjectFromPointsAtIndex:(NSUInteger)idx;

- (void)insertPoints:(NSArray *)value atIndexes:(NSIndexSet *)indexes;

- (void)removePointsAtIndexes:(NSIndexSet *)indexes;

- (void)replaceObjectInPointsAtIndex:(NSUInteger)idx withObject:(SquigglePoint *)value;

- (void)replacePointsAtIndexes:(NSIndexSet *)indexes withPoints:(NSArray *)values;

- (void)addPointsObject:(SquigglePoint *)value;

- (void)removePointsObject:(SquigglePoint *)value;

- (void)addPoints:(NSOrderedSet *)values;

- (void)removePoints:(NSOrderedSet *)values;

//custom methods
- (void)addCGPoints:(NSArray *)points;

- (void)addCGPoint:(CGPoint)point;

- (void)setLineColor:(UIColor *)color;

- (UIColor *)getSquiggleColor;
@end
