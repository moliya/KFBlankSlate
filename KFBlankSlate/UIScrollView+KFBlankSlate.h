//
//  UIScrollView+KFBlankSlate.h
//  KFBlankSlateExample
//
//  Created by carefree on 2018/8/16.
//  Copyright © 2018年 Carefree. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KFBlankSlateHandler;

@interface UIScrollView (KFBlankSlate)

/** 空白状态配置项 **/
@property (nonatomic, strong) KFBlankSlateHandler   *kf_handler;

@end
