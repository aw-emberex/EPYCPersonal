//
//  ALScrollViewPaging.h
//  ScrollViewPaging
//
//  Created by Andrea Lufino on 15/02/13.
//  Copyright (c) 2013 Andrea Lufino. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ALScrollViewPagingDelegate;

@interface ALScrollViewPaging : UIScrollView <UIScrollViewDelegate> {
    BOOL pageControlBeingUsed;
    NSArray *_pages;
    UIPageControl *pageControl;
}

@property(nonatomic) int currentPage;
@property(nonatomic) BOOL hasPageControl;
@property(nonatomic, strong) UIColor *pageControlCurrentPageColor;
@property(nonatomic, strong) UIColor *pageControlOtherPagesColor;
@property(nonatomic, strong) UIPageControl *externalPageControl;

@property(nonatomic, strong) id<ALScrollViewPagingDelegate> eventDelegate;

- (id)initWithFrame:(CGRect)frame withPageControl:(UIPageControl *)pageControl;

- (id)initWithFrame:(CGRect)frame andPages:(NSArray *)pages;

- (void)addPages:(NSArray *)pages;

@end
