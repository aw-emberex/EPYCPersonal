//
//  Squiggle.m
//  EPYCPersonal
//
//  Created by Alex Wait on 5/1/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import "Squiggle.h"
#import "GameEntry.h"
#import "SquigglePoint.h"
#import "EPYCAppDelegate.h"
#import <Foundation/Foundation.h>


@implementation Squiggle

@dynamic lineWidth;
@dynamic owningGameEntry;
@dynamic points;

-(void)awakeFromInsert {
    //after randoris investigate storing array of points as binary data or something
}

-(void)addCGPoints: (NSArray*) points {
    [points enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CGPoint point;
         [(NSValue*)obj getValue:&point];
        [self addCGPoint:point];
    }];
}

-(void)addCGPoint: (CGPoint) point {
    EPYCAppDelegate* appDelegate = (EPYCAppDelegate *)[[UIApplication sharedApplication] delegate];
    SquigglePoint* newPoint = (SquigglePoint*)[NSEntityDescription insertNewObjectForEntityForName:@"SquigglePoint" inManagedObjectContext:appDelegate.managedObjectContext];
    [newPoint setXPoint:[NSNumber numberWithFloat:point.x]];
    [newPoint setYPoint:[NSNumber numberWithFloat:point.y]];
    [newPoint setOwningSquiggle:self];
}

@end
