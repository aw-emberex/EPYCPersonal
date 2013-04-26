//
//  SquigglePoint.h
//  StoryBoardTest1
//
//  Created by Alex Wait on 4/25/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SquigglePoint : NSManagedObject

@property (nonatomic, retain) NSNumber * xPoint;
@property (nonatomic, retain) NSNumber * yPoint;
@property (nonatomic, retain) NSManagedObject *owningSquiggle;

@end
