//
//  KFBlankSlateHandler.h
//  KFBlankSlateExample
//
//  Created by carefree on 2018/8/16.
//  Copyright © 2018年 Carefree. All rights reserved.
//  handler基类，请通过子类来实现定制化的配置
//

#import <Foundation/Foundation.h>
#if __has_include(<DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>)
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#else
#import "UIScrollView+EmptyDataSet.h"
#endif

/** 数据加载的状态 */
typedef NS_OPTIONS(NSUInteger, KFDataLoadState) {
    KFDataLoadStateIdle     = 1 << 0, //闲置
    KFDataLoadStateLoading  = 1 << 1, //加载中
    KFDataLoadStateEmpty    = 1 << 2, //数据空
    KFDataLoadStateFailed   = 1 << 3, //加载失败
    KFDataLoadStateFinished = 1 << 4, //加载完成
};

FOUNDATION_EXTERN NSInteger const KFDataLoadStateAll;

@interface KFBlankSlateHandler : NSObject<DZNEmptyDataSetDelegate, DZNEmptyDataSetSource>

@property (nonatomic, weak) UIScrollView        *scrollView;
@property (nonatomic, assign) KFDataLoadState   state;

/** 初始配置 */
- (void)configure NS_REQUIRES_SUPER;

@end
