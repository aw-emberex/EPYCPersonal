//
//  MainView.m
//  Painter
//
//  Created by Edward Chiang on 2010/12/10.
//  Copyright 2010 Edward in Action. All rights reserved.
//
//  Adapted for EPYC by Alex Wait 5/4/2013
//

#import "MainView.h"


@implementation MainView

@synthesize color;
@synthesize lineWidth;

- (id) initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        // initialize squiggles and finishedSquiggles
        squiggles = [[NSMutableDictionary alloc] init];
        finishedSquiggles = [[NSMutableArray alloc] init];
        // the starting color is black
        color = [[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:1];
        lineWidth = 5;
        gameManager = [GameManager getInstance];
        [self setMultipleTouchEnabled:YES];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
  
  self = [super initWithFrame:frame];
  if (self) {
    gameManager = [GameManager getInstance];
  }
    [self setUserInteractionEnabled:FALSE];
  return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
  // Drawing code.
  CGContextRef context = UIGraphicsGetCurrentContext();    
    NSLog(@"%@ %@", squiggles, finishedSquiggles);
    for (Squiggle *squiggle in finishedSquiggles) {
        [self drawSquiggle:squiggle inContext:context];
    }
  
  for (NSString *key in squiggles) {
    Squiggle *squiggle = [squiggles valueForKey:key];
    [self drawSquiggle:squiggle inContext:context];
  }
}


// draws the given squiggle into the given context
- (void)drawSquiggle:(Squiggle*)someSquiggle inContext:(CGContextRef)context {
  // set the drawing color to the squiggle's color
    UIColor *squiggleColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];//squiggle.strokeColor;
    CGColorRef	colorRef = [squiggleColor CGColor];	// get the CGColor
    CGContextSetStrokeColorWithColor(context, colorRef);
  
    // set the line width to the squiggle's line width
    CGContextSetLineWidth(context, 3);
   
    // move to the point
    CGPoint firstPoint;
    SquigglePoint* firstSquigglePoint = [[someSquiggle points] objectAtIndex:0];
    firstPoint.x = [firstSquigglePoint.xPoint floatValue];
    firstPoint.y = [firstSquigglePoint.yPoint floatValue];
    
    CGContextMoveToPoint(context, firstPoint.x, firstPoint.y);
  
    // draw a line from each point to the next in order
    [someSquiggle.points enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        SquigglePoint* value = (SquigglePoint*)obj;
        CGPoint point;	// declare a new point
        point.x = [value.xPoint floatValue];
        point.y = [value.yPoint floatValue];
    
        // draw a line to the new point
        CGContextAddLineToPoint(context, point.x, point.y);
    }];
  
  CGContextStrokePath(context);
  UIGraphicsPushContext(context);
}


// called when the user lefts a finger from the screen
- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [touches enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        UITouch* touch = (UITouch*)obj;
   
        NSValue *touchValue2 = [NSValue valueWithPointer:CFBridgingRetain(touch)];
        NSString *key2 = [NSString stringWithFormat:@"%@", touchValue2];
        
        // retrieve the squiggle for this touch using the key
        Squiggle *squiggle = [squiggles valueForKey:key2];
        // remove the squiggle from the dictionary and place it in an array // of finished squiggles
        [finishedSquiggles addObject:squiggle]; // add to finishedSquiggles
        [squiggles removeObjectForKey:key2]; // remove from squiggles
    }];
}
//// clear the painting if the user touched the "Clear" button
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  // if the user touched the Clear button
  if (buttonIndex ==1 )
    [self resetView];	// clear the screen
}

// determines if this view can become the first responder
- (BOOL)canBecomeFirstResponder { 
  return YES;
}

//// called when a motion event, such as a shake, ends
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
  // if a shake event ended
  if (event.subtype == UIEventSubtypeMotionShake){
    // create an alert prompting the user about clearing the painting
    NSString *message = @"Are you sure you want to clear the screen?";

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Clear Screen?" message:message delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Clear", nil];
    [alert show];
  }// end if
  [super motionEnded:motion withEvent:event];
} // end method

// called whenever the user places a finger on the screen
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  NSArray *array = [ touches allObjects];	// get all the new touches
  // loop through each new touch
  for (UITouch *touch in array ) {
    // create and configure a new squiggle
      Squiggle *squiggle = [gameManager createNewSquiggle];

    CGPoint currentPoint = [touch locationInView:self];
      [squiggle addCGPoint:currentPoint];
    // the key for each touch is the value of the pointer
    
    // add the new touch to the dictionary under a unique key
    NSValue *touchValue = [NSValue valueWithPointer:CFBridgingRetain(touch)];
    NSString *key = [NSString stringWithFormat:@"%@", touchValue];

    [squiggles setValue:squiggle forKey:key];
  }
}


// called whenever the user drags a finger on the screen
- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  NSArray *array = [touches allObjects];	// get all the moved touches
  // loop through all the touches
  for (UITouch *touch in array) {
    // get the unique key for this touch
    
      NSValue *touchValue2 = [NSValue valueWithPointer:CFBridgingRetain(touch)];
    NSString *key2 = [NSString stringWithFormat:@"%@", touchValue2];
    // fetch the squiggle this touch should be added to using the key
    Squiggle *squiggle = [squiggles valueForKey:key2];
    
    // get the current and previous touch locations
    CGPoint current = [touch locationInView:self];
    CGPoint previous = [touch previousLocationInView:self];
    [squiggle addCGPoint:current];	// add the new point to the squiggle
      
    //finishedSquiggles addObject:[NSValue]
    
    // screen needs to be redrawn
    CGPoint lower, higher;
    lower.x = (previous.x > current.x ? current.x : previous.x);
    lower.y	= (previous.y > current.y ? current.y: previous.y);
    higher.x = (previous.x < current.x ? current.x : previous.x);
    higher.y = (previous.y < current.y ? current.y: previous.y);
    
    // redraw the screen in the required region
    [self setNeedsDisplayInRect:CGRectMake(lower.x - lineWidth,
                                           lower.y - lineWidth, higher.x - lower.x + lineWidth * 2,
                                           higher.y - lower.y + lineWidth * 2)];
      
  }
}

// clear the paintings in main view
- (void)resetView {
  [squiggles removeAllObjects];
  [finishedSquiggles removeAllObjects];
  [self setNeedsDisplay];	// refresh the display
}
@end