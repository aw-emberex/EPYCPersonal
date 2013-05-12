//
//  MainView.m
//  Painter
//
//  Created by Edward Chiang on 2010/12/10.
//  Copyright 2010 Edward in Action. All rights reserved.
//
//  Adapted for EPYC by Alex Wait 5/4/2013
//

#import "DrawingView.h"


@implementation DrawingView

@synthesize color;
@synthesize lineWidth;
@synthesize squiggles;
@synthesize finishedSquiggles;
@synthesize drawingViewDelegate;
@synthesize previousSquiggles;
@synthesize respondsToTouches;

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
        NSString* shakeSoundPath = [NSString stringWithFormat:@"%@/shakeSoundShort1.mp3", [[NSBundle mainBundle] resourcePath]];
        NSURL* url = [NSURL fileURLWithPath:shakeSoundPath];
        shakePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        [shakePlayer setNumberOfLoops:-1];
        [shakePlayer prepareToPlay];
        self.respondsToTouches = YES;
        [self becomeFirstResponder];
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

- (void)drawRect:(CGRect)rect {
  CGContextRef context = UIGraphicsGetCurrentContext();

    for (Squiggle *squiggle in previousSquiggles) {
        [self drawSquiggle:squiggle inContext:context];
    }
    
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
    UIColor *squiggleColor = [someSquiggle getSquiggleColor];
    CGColorRef	colorRef = [squiggleColor CGColor];	// get the CGColor
    CGContextSetStrokeColorWithColor(context, colorRef);
    
    float originalWidth = [someSquiggle.owningGameEntry.originalViewportX floatValue];
    float originalHeight = [someSquiggle.owningGameEntry.originalViewportY floatValue];
    
    float currentWidth = self.frame.size.width;
    float currentHeight = self.frame.size.height;
    
    float widthRatio = currentWidth/originalWidth;
    float heightRatio = currentHeight/originalHeight;

    if (heightRatio == INFINITY) heightRatio = 1;
    if (widthRatio == INFINITY) widthRatio = 1;
    
  
    // set the line width to the squiggle's line width
    CGContextSetLineWidth(context, [[someSquiggle lineWidth] floatValue]);
   
    CGPoint firstPoint;
    SquigglePoint* firstSquigglePoint = [[someSquiggle points] objectAtIndex:0];
    firstPoint.x = [firstSquigglePoint.xPoint floatValue];
    firstPoint.y = [firstSquigglePoint.yPoint floatValue];
    
    CGContextMoveToPoint(context, firstPoint.x, firstPoint.y);
  
    [someSquiggle.points enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        SquigglePoint* value = (SquigglePoint*)obj;
        CGPoint point;	// declare a new point
        point.x = [value.xPoint floatValue] * widthRatio;
        point.y = [value.yPoint floatValue] * heightRatio;
    
        // draw a line to the new point
        CGContextAddLineToPoint(context, point.x, point.y);
    }];
  
  CGContextStrokePath(context);
  UIGraphicsPushContext(context);
}


// called when the user lefts a finger from the screen
- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!self.respondsToTouches) return;
    [touches enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        UITouch* touch = (UITouch*)obj;
   
        NSValue *touchValue2 = [NSValue valueWithPointer:CFBridgingRetain(touch)];
        NSString *key2 = [NSString stringWithFormat:@"%@", touchValue2];
        CFBridgingRelease((__bridge CFTypeRef)(touch));
        
        // retrieve the squiggle for this touch using the key
        Squiggle *squiggle = [squiggles valueForKey:key2];
        // remove the squiggle from the dictionary and place it in an array // of finished squiggles
        [finishedSquiggles addObject:squiggle]; // add to finishedSquiggles
        [squiggles removeObjectForKey:key2]; // remove from squiggles
    }];
}
//// clear the painting if the user touched the "Clear" button
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex ==1 ) {
        [self resetView];
        [self.drawingViewDelegate erasedDrawing];
        [self.drawingViewDelegate cancelledDrawing];
    }
}

// determines if this view can become the first responder
- (BOOL)canBecomeFirstResponder { 
  return YES;
}

-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.subtype == UIEventSubtypeMotionShake) {
        NSLog(@"started!");
        [shakePlayer play];
    }
}

-(void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    [shakePlayer stop];
}

//// called when a motion event, such as a shake, ends
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
  // if a shake event ended
    NSLog(@"ended!");
    if (!self.respondsToTouches) return;

  if (event.subtype == UIEventSubtypeMotionShake){
    // create an alert prompting the user about clearing the painting
    NSString *message = @"Are you sure you want erase the screen?";
      [shakePlayer stop];

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erase Screen?" message:message delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Erase", nil];
    [alert show];
  }
  [super motionEnded:motion withEvent:event];
}

// called whenever the user places a finger on the screen
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!self.respondsToTouches) return;  
  NSArray *array = [ touches allObjects];	// get all the new touches
  for (UITouch *touch in array ) {
    Squiggle *squiggle = [gameManager createNewSquiggle];
    [self.drawingViewDelegate createdNewSquiggle:squiggle];
    [squiggle setLineColor:self.color];
    [squiggle setLineWidth:[NSNumber numberWithFloat:self.lineWidth]];
      
    CGPoint currentPoint = [touch locationInView:self];
      [squiggle addCGPoint:currentPoint];
    // the key for each touch is the value of the pointer
    
    // add the new touch to the dictionary under a unique key
    NSValue *touchValue = [NSValue valueWithPointer:CFBridgingRetain(touch)];
    NSString *key = [NSString stringWithFormat:@"%@", touchValue];
    CFBridgingRelease((__bridge CFTypeRef)(touch));


    [squiggles setValue:squiggle forKey:key];
  }
}


// called whenever the user drags a finger on the screen
- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!self.respondsToTouches) return;
  NSArray *array = [touches allObjects];	// get all the moved touches
  // loop through all the touches
  for (UITouch *touch in array) {
    // get the unique key for this touch
    
    NSValue *touchValue = [NSValue valueWithPointer:CFBridgingRetain(touch)];
    NSString *key2 = [NSString stringWithFormat:@"%@", touchValue];
    // fetch the squiggle this touch should be added to using the key
    Squiggle *squiggle = [squiggles valueForKey:key2];
    
    // get the current and previous touch locations
    CGPoint current = [touch locationInView:self];
    CGPoint previous = [touch previousLocationInView:self];
    CFBridgingRelease((__bridge CFTypeRef)(touch));
  
    [squiggle addCGPoint:current];	// add the new point to the squiggle
    
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