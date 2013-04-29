//
//  GameData.h
//  EPYCPersonal
//
//  Created by Alex Wait on 4/28/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GameEntry;

@interface GameData : NSManagedObject

@property (nonatomic, retain) NSOrderedSet *gameEntries;
@end

@interface GameData (CoreDataGeneratedAccessors)

- (void)insertObject:(GameEntry *)value inGameEntriesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromGameEntriesAtIndex:(NSUInteger)idx;
- (void)insertGameEntries:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeGameEntriesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInGameEntriesAtIndex:(NSUInteger)idx withObject:(GameEntry *)value;
- (void)replaceGameEntriesAtIndexes:(NSIndexSet *)indexes withGameEntries:(NSArray *)values;
- (void)addGameEntriesObject:(GameEntry *)value;
- (void)removeGameEntriesObject:(GameEntry *)value;
- (void)addGameEntries:(NSOrderedSet *)values;
- (void)removeGameEntries:(NSOrderedSet *)values;
@end
