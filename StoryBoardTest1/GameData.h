//
//  GameData.h
//  TapkuLibrary
//
//  Created by Alex Wait on 6/3/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GameEntry;

@interface GameData : NSManagedObject

@property (nonatomic, retain) NSDate * creationTime;
@property (nonatomic, retain) NSNumber * finished;
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
