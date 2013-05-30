//
// Created by Alex Wait on 5/29/13.
// Copyright (c) 2013 Emberex. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "UIView+AnimateHidden.h"


@implementation UIView (AnimateHidden)

- (void)setHiddenAnimated:(BOOL)hide {
    [self setHiddenAnimated:hide withDuration:4.5];
}

-(void)setHiddenAnimated:(BOOL)hide withDuration:(NSInteger)duration {
    [UIView animateWithDuration:duration
                          delay:0.0
                        options:UIViewAnimationCurveEaseOut
                     animations:^{
                         [UIView setAnimationCurve:UIViewAnimationCurveLinear];
                         if (hide)
                             self.alpha = 0;
                         else {
                             self.hidden = NO;
                             self.alpha = 1;
                         }
                     }
                     completion:^(BOOL b) {
                         if (hide)
                             self.hidden = YES;
                     }
    ];
}


@end