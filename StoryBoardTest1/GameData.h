//
//  GameData.h
//  StoryBoardTest1
//
//  Created by Alex Wait on 4/28/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface GameData : NSManagedObject

@property (nonatomic, retain) NSOrderedSet *gameEntries;
@end

@interface GameData (CoreDataGeneratedAccessors)

- (void)insertObject:(NSManagedObject *)value inGameEntriesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromGameEntriesAtIndex:(NSUInteger)idx;
- (void)insertGameEntries:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeGameEntriesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInGameEntriesAtIndex:(NSUInteger)idx withObject:(NSManagedObject *)value;
- (void)replaceGameEntriesAtIndexes:(NSIndexSet *)indexes withGameEntries:(NSArray *)values;
- (void)addGameEntriesObject:(NSManagedObject *)value;
- (void)removeGameEntriesObject:(NSManagedObject *)value;
- (void)addGameEntries:(NSOrderedSet *)values;
- (void)removeGameEntries:(NSOrderedSet *)values;
@end
