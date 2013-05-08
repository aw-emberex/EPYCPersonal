//
//  GameEntry.h
//  EPYCPersonal
//
//  Created by Alex Wait on 5/7/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GameData, Squiggle;

@interface GameEntry : NSManagedObject

@property (nonatomic, retain) NSString * phraseText;
@property (nonatomic, retain) NSNumber * originalViewportX;
@property (nonatomic, retain) NSNumber * originalViewportY;
@property (nonatomic, retain) GameData *owningGameData;
@property (nonatomic, retain) NSOrderedSet *squiggles;
@end

@interface GameEntry (CoreDataGeneratedAccessors)

- (void)insertObject:(Squiggle *)value inSquigglesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromSquigglesAtIndex:(NSUInteger)idx;
- (void)insertSquiggles:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeSquigglesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInSquigglesAtIndex:(NSUInteger)idx withObject:(Squiggle *)value;
- (void)replaceSquigglesAtIndexes:(NSIndexSet *)indexes withSquiggles:(NSArray *)values;
- (void)addSquigglesObject:(Squiggle *)value;
- (void)removeSquigglesObject:(Squiggle *)value;
- (void)addSquiggles:(NSOrderedSet *)values;
- (void)removeSquiggles:(NSOrderedSet *)values;
@end
