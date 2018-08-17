//
//  KFBlankSlateGeneralHandler.h
//  KFBlankSlateExample
//
//  Created by carefree on 2018/8/16.
//  Copyright © 2018年 Carefree. All rights reserved.
//

#import "KFBlankSlateHandler.h"

@interface KFBlankSlateGeneralHandler : KFBlankSlateHandler

@property (nonatomic, assign, getter=isFadeIn) BOOL             fadeIn;
@property (nonatomic, assign, getter=isDisplay) BOOL            display;
@property (nonatomic, assign, getter=isForcedToDisplay) BOOL    forcedToDisplay;
@property (nonatomic, assign, getter=isTouchable) BOOL          touchable;
@property (nonatomic, assign, getter=isScrollable) BOOL         scrollable;
@property (nonatomic, assign, getter=isAnimate) BOOL            animate;

@property (nonatomic, copy) UIView *(^loadingConfigure)(void);
@property (nonatomic, copy) UIView *(^emptyConfigure)(void);
@property (nonatomic, copy) UIView *(^failedConfigure)(void);
@property (nonatomic, copy) UIView *(^loadedConfigure)(void);
@property (nonatomic, copy) UIView *(^tapViewHandler)(UIView *view);

@property (nonatomic, strong) UIFont    *textFont;
@property (nonatomic, strong) UIColor   *textColor;
@property (nonatomic, assign) CGFloat   verticalOffset;

@end
