//
//  Squiggle.m
//  EPYCPersonal
//
//  Created by Alex Wait on 5/6/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//


@implementation Squiggle

@dynamic lineWidth;
@dynamic colorRed;
@dynamic colorGreen;
@dynamic colorBlue;
@dynamic owningGameEntry;
@dynamic points;


- (void)awakeFromInsert {
    //after randoris investigate storing array of points as binary data or something
}

- (void)addCGPoints:(NSArray *)points {
    [points enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CGPoint point;
        [(NSValue *) obj getValue:&point];
        [self addCGPoint:point];
    }];
}

- (void)addCGPoint:(CGPoint)point {
    EPYCAppDelegate *appDelegate = (EPYCAppDelegate *) [[UIApplication sharedApplication] delegate];
    SquigglePoint *newPoint = (SquigglePoint *) [NSEntityDescription insertNewObjectForEntityForName:@"SquigglePoint" inManagedObjectContext:appDelegate.managedObjectContext];
    [newPoint setXPoint:[NSNumber numberWithFloat:point.x]];
    [newPoint setYPoint:[NSNumber numberWithFloat:point.y]];
    [newPoint setOwningSquiggle:self];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Points Length: %d, owningGameEntry %@", [self.points count], self.owningGameEntry];
}

- (void)setLineColor:(UIColor *)color {
    CGFloat blue, red, green, alpha; //not using alpha atm
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    self.colorRed = [NSNumber numberWithFloat:red];
    self.colorBlue = [NSNumber numberWithFloat:blue];
    self.colorGreen = [NSNumber numberWithFloat:green];
}

- (UIColor *)getSquiggleColor {
    return [UIColor colorWithRed:[self.colorRed floatValue] green:[self.colorGreen floatValue] blue:[self.colorBlue floatValue] alpha:1];
}

@end
