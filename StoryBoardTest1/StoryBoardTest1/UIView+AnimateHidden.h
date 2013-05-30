//
// Created by Alex Wait on 5/29/13.
// Copyright (c) 2013 Emberex. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@interface UIView (AnimateHidden)
-(void)setHiddenAnimated:(BOOL)hide;
-(void)setHiddenAnimated:(BOOL)hide withDuration:(NSInteger)duration;
@end