//
//  KFBlankSlateGeneralHandler+Chain.h
//  KFBlankSlateExample
//
//  Created by carefree on 2019/8/19.
//  Copyright © 2019 qingshan. All rights reserved.
//

#import <KFBlankSlate/KFBlankSlate.h>

NS_ASSUME_NONNULL_BEGIN

@interface KFBlankSlateGeneralHandler (Chain)

@property (nonatomic, weak) UIButton    *reloadButton;

- (KFBlankSlateGeneralHandler * (^)(KFDataLoadState))on;

- (KFBlankSlateGeneralHandler * (^)(void))onAll;

- (KFBlankSlateGeneralHandler * (^)(void))onIdle;

- (KFBlankSlateGeneralHandler * (^)(void))onLoading;

- (KFBlankSlateGeneralHandler * (^)(void))onEmpty;

- (KFBlankSlateGeneralHandler * (^)(void))onFailed;

- (KFBlankSlateGeneralHandler * (^)(void))onFinished;

- (KFBlankSlateGeneralHandler * (^)(NSString * _Nullable))title;

- (KFBlankSlateGeneralHandler * (^)(NSAttributedString * _Nullable))attributedTitle;

- (KFBlankSlateGeneralHandler * (^)(NSString * _Nullable))description;

- (KFBlankSlateGeneralHandler * (^)(NSAttributedString * _Nullable))attributedDescription;

- (KFBlankSlateGeneralHandler * (^)(UIImage * _Nullable))image;

- (KFBlankSlateGeneralHandler * (^)(UIColor * _Nullable))imageTintColor;

- (KFBlankSlateGeneralHandler * (^)(CAAnimation * _Nullable))imageAnimation;

- (KFBlankSlateGeneralHandler * (^)(NSString * _Nullable, UIControlState))buttonTitle;

- (KFBlankSlateGeneralHandler * (^)(NSAttributedString * _Nullable, UIControlState))attributedButtonTitle;

- (KFBlankSlateGeneralHandler * (^)(UIImage * _Nullable, UIControlState))buttonImage;

- (KFBlankSlateGeneralHandler * (^)(UIImage * _Nullable, UIControlState))buttonBackgroundImage;

- (KFBlankSlateGeneralHandler * (^)(UIView * _Nullable))customView;

- (KFBlankSlateGeneralHandler * (^)(UIColor * _Nullable))_backgroundColor;

- (KFBlankSlateGeneralHandler * (^)(CGFloat))_verticalOffset;

- (KFBlankSlateGeneralHandler * (^)(CGFloat))_spaceHeight;

- (KFBlankSlateGeneralHandler * (^)(BOOL))_fadeIn;

- (KFBlankSlateGeneralHandler * (^)(BOOL))_forcedToDisplay;

- (KFBlankSlateGeneralHandler * (^)(BOOL))_display;

- (KFBlankSlateGeneralHandler * (^)(BOOL))_touchable;

- (KFBlankSlateGeneralHandler * (^)(BOOL))_scrollable;

- (KFBlankSlateGeneralHandler * (^)(BOOL))_animate;

- (KFBlankSlateGeneralHandler * (^)(id _Nullable, SEL))reload;

@end

NS_ASSUME_NONNULL_END
