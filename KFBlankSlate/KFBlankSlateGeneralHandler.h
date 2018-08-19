//
//  KFBlankSlateGeneralHandler.h
//  KFBlankSlateExample
//
//  Created by carefree on 2018/8/16.
//  Copyright © 2018年 Carefree. All rights reserved.
//

#import "KFBlankSlateHandler.h"

@interface KFBlankSlateGeneralHandler : KFBlankSlateHandler

/** 是否使用淡入动画 */
@property (nonatomic, assign, getter=isFadeIn) BOOL             fadeIn;
/** 是否显示 */
@property (nonatomic, assign, getter=isDisplay) BOOL            display;
/** 是否在数据不为空的情况下仍然显示 */
@property (nonatomic, assign, getter=isForcedToDisplay) BOOL    forcedToDisplay;
/** 是否可点击 */
@property (nonatomic, assign, getter=isTouchable) BOOL          touchable;
/** 是否可滑动 */
@property (nonatomic, assign, getter=isScrollable) BOOL         scrollable;
/** 点击按钮的事件回调 */
@property (nonatomic, copy) void(^tapButtonHandler)(UIButton *button);
/** 点击空白视图的事件回调 */
@property (nonatomic, copy) void(^tapViewHandler)(UIView *view);

/** 设置state状态下的文字标题 */
- (void)setTitle:(NSString *)title forState:(KFDataLoadState)state;
/** 设置state状态下的富文本标题 */
- (void)setAttributedTitle:(NSAttributedString *)title forState:(KFDataLoadState)state;

/** 设置state状态下的文字描述 */
- (void)setDescription:(NSString *)description forState:(KFDataLoadState)state;
/** 设置state状态下的富文本描述 */
- (void)setAttributedDescription:(NSAttributedString *)description forState:(KFDataLoadState)state;

/** 设置state状态下的图片 */
- (void)setImage:(UIImage *)image forState:(KFDataLoadState)state;
/** 设置state状态下的图片着色 */
- (void)setImageTintColor:(UIColor *)color forState:(KFDataLoadState)state;

/** 设置state状态下按钮的文字标题 */
- (void)setButtonTitle:(NSString *)title controlState:(UIControlState)cState forState:(KFDataLoadState)state;
/** 设置state状态下按钮的富文本标题 */
- (void)setAttributedButtonTitle:(NSAttributedString *)title controlState:(UIControlState)cState forState:(KFDataLoadState)state;

/** 设置state状态下按钮的图片 */
- (void)setButtonImage:(UIImage *)image controlState:(UIControlState)cState forState:(KFDataLoadState)state;
/** 设置state状态下按钮的背景图片 */
- (void)setButtonBackgroundImage:(UIImage *)image controlState:(UIControlState)cState forState:(KFDataLoadState)state;

/** 设置state状态下的背景颜色 */
- (void)setBackgroundColor:(UIColor *)color forState:(KFDataLoadState)state;

/** 设置state状态下的自定义视图 */
- (void)setCustomView:(UIView *)view forState:(KFDataLoadState)state;

/** 设置state状态下的垂直偏移量 */
- (void)setVerticalOffset:(CGFloat)offset forState:(KFDataLoadState)state;

/** 设置state状态下各视图的间距 */
- (void)setSpaceHeight:(CGFloat)space forState:(KFDataLoadState)state;

@end
