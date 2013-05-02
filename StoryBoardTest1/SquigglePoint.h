//
//  SquigglePoint.h
//  EPYCPersonal
//
//  Created by Alex Wait on 5/1/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Squiggle;

@interface SquigglePoint : NSManagedObject

@property (nonatomic, retain) NSNumber * xPoint;
@property (nonatomic, retain) NSNumber * yPoint;
@property (nonatomic, retain) Squiggle *owningSquiggle;

@end
