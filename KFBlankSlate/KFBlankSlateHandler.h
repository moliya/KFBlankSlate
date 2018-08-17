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
typedef NS_ENUM(NSUInteger, KFDataLoadState) {
    KFDataLoadStateReady, //闲置
    KFDataLoadStateLoading, //加载中
    KFDataLoadStateEmpty, //数据空
    KFDataLoadStateFailed, //加载失败
    KFDataLoadStateLoaded //加载完成
};

@interface KFBlankSlateHandler : NSObject<DZNEmptyDataSetDelegate, DZNEmptyDataSetSource>

@property (nonatomic, weak) UIScrollView        *scrollView;
@property (nonatomic, assign) KFDataLoadState   state;

// 初始配置
- (void)configure NS_REQUIRES_SUPER;

@end
