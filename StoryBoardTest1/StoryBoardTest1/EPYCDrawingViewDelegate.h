//
//  EPYCDrawingViewDelegate.h
//  EPYCPersonal
//
//  Created by Alex Wait on 5/5/13.
//  Copyright (c) 2013 Emberex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Squiggle.h"

@protocol EPYCDrawingViewDelegate <NSObject>

-(void)createdNewSquiggle:(Squiggle*)squiggle;
-(void)cancelledDrawing;

@end
