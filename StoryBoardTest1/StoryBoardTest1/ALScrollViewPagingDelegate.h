//
// Created by Alex Wait on 6/3/13.
// Copyright (c) 2013 Emberex. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@protocol ALScrollViewPagingDelegate <NSObject>

-(void)changedPage:(NSInteger)newPage;

@end