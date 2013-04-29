//
//  GameEntry.h
//  EPYCPersonal
//
//  Created by Alex Wait on 4/28/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GameData, Squiggle;

@interface GameEntry : NSManagedObject

@property (nonatomic, retain) NSString * phraseText;
@property (nonatomic, retain) GameData *owningGameData;
@property (nonatomic, retain) NSOrderedSet *squiggle;
@end

@interface GameEntry (CoreDataGeneratedAccessors)

- (void)insertObject:(Squiggle *)value inSquiggleAtIndex:(NSUInteger)idx;
- (void)removeObjectFromSquiggleAtIndex:(NSUInteger)idx;
- (void)insertSquiggle:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeSquiggleAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInSquiggleAtIndex:(NSUInteger)idx withObject:(Squiggle *)value;
- (void)replaceSquiggleAtIndexes:(NSIndexSet *)indexes withSquiggle:(NSArray *)values;
- (void)addSquiggleObject:(Squiggle *)value;
- (void)removeSquiggleObject:(Squiggle *)value;
- (void)addSquiggle:(NSOrderedSet *)values;
- (void)removeSquiggle:(NSOrderedSet *)values;
@end
