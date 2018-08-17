//
//  KFBlankSlateGeneralHandler.m
//  KFBlankSlateExample
//
//  Created by carefree on 2018/8/16.
//  Copyright © 2018年 Carefree. All rights reserved.
//

#import "KFBlankSlateGeneralHandler.h"

@implementation KFBlankSlateGeneralHandler

#pragma mark - Lifecycle
- (void)configure {
    [super configure];
    
    //设置默认值
    self.display = YES;
    self.forcedToDisplay = NO;
    self.touchable = YES;
    self.scrollable = YES;
    self.animate = NO;
    self.textFont = [UIFont systemFontOfSize:14];
    self.textColor = [UIColor lightTextColor];
    self.verticalOffset = 0;
}

#pragma mark - DZNEmptyDataSetSource
- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView {
    UIView *customView;
    
    switch (self.state) {
        case KFDataLoadStateReady:
            //闲置状态，不做处理
            break;
        case KFDataLoadStateEmpty:
            //数据为空
            if (self.emptyConfigure) {
                customView = self.emptyConfigure();
            } else {
                UILabel *label = [[UILabel alloc] init];
                label.text = @"列表数据为空";
                label.font = self.textFont;
                label.textColor = self.textColor;
                label.textAlignment = NSTextAlignmentCenter;
                
                customView = label;
            }
            break;
        case KFDataLoadStateLoading:
            //加载中
            if (self.loadingConfigure) {
                customView = self.loadingConfigure();
            } else {
                UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
                [activityView startAnimating];
                
                customView = activityView;
            }
            break;
        case KFDataLoadStateFailed:
            //加载失败
            if (self.failedConfigure) {
                customView = self.failedConfigure();
            } else {
                UILabel *label = [[UILabel alloc] init];
                label.text = @"数据加载失败";
                label.font = self.textFont;
                label.textColor = self.textColor;
                label.textAlignment = NSTextAlignmentCenter;
                
                customView = label;
            }
            break;
        case KFDataLoadStateLoaded:
            //加载完成
            if (self.loadedConfigure) {
                customView = self.loadedConfigure();
            }
            break;
        default:
            break;
    }
    
    return customView;
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return self.verticalOffset;
}

#pragma mark - DZNEmptyDataSetDelegate
- (BOOL)emptyDataSetShouldFadeIn:(UIScrollView *)scrollView {
    return self.isFadeIn;
}

- (BOOL)emptyDataSetShouldBeForcedToDisplay:(UIScrollView *)scrollView {
    return self.isForcedToDisplay;
}

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return self.isDisplay;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView {
    return self.isTouchable;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return self.isScrollable;
}

- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView {
    return self.isAnimate;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    if (self.tapViewHandler) {
        self.tapViewHandler(view);
    }
}

@end
