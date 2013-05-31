//
// Created by Alex Wait on 5/30/13.
// Copyright (c) 2013 Emberex. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@protocol DrawingViewControllerDelegate <NSObject>
-(void)savedSquiggles:(NSOrderedSet *)squigglesSaved;
@end