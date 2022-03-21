//
//  KFBlankSlateGeneralHandler+Chain.m
//  KFBlankSlateExample
//
//  Created by carefree on 2019/8/19.
//  Copyright © 2019 qingshan. All rights reserved.
//

#import "KFBlankSlateGeneralHandler+Chain.h"
#import <objc/runtime.h>

@interface KFBlankSlateGeneralHandler ()

@property (nonatomic, assign) KFDataLoadState   currentConfigState;

@end

@implementation KFBlankSlateGeneralHandler (Chain)

- (KFDataLoadState)currentConfigState {
    NSNumber *state = objc_getAssociatedObject(self, @selector(currentConfigState));
    if (!state) {
        return KFDataLoadStateAll;
    }
    return state.integerValue;
}

- (void)setCurrentConfigState:(KFDataLoadState)currentConfigState {
    objc_setAssociatedObject(self, @selector(currentConfigState), @(currentConfigState), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIButton *)reloadButton {
    return objc_getAssociatedObject(self, @selector(reloadButton));
}

- (void)setReloadButton:(UIButton *)reloadButton {
    objc_setAssociatedObject(self, @selector(reloadButton), reloadButton, OBJC_ASSOCIATION_ASSIGN);
}


#pragma mark - Public
- (KFBlankSlateGeneralHandler * _Nonnull (^)(KFDataLoadState))on {
    return ^id(KFDataLoadState state) {
        self.currentConfigState = state;
        return self;
    };
}

- (KFBlankSlateGeneralHandler * _Nonnull (^)(void))onAll {
    return ^id {
        self.currentConfigState = KFDataLoadStateAll;
        return self;
    };
}

- (KFBlankSlateGeneralHandler * _Nonnull (^)(void))onIdle {
    return ^id {
        self.currentConfigState = KFDataLoadStateIdle;
        return self;
    };
}

- (KFBlankSlateGeneralHandler * _Nonnull (^)(void))onLoading {
    return ^id {
        self.currentConfigState = KFDataLoadStateLoading;
        return self;
    };
}

- (KFBlankSlateGeneralHandler * _Nonnull (^)(void))onEmpty {
    return ^id {
        self.currentConfigState = KFDataLoadStateEmpty;
        return self;
    };
}

- (KFBlankSlateGeneralHandler * _Nonnull (^)(void))onFailed {
    return ^id {
        self.currentConfigState = KFDataLoadStateFailed;
        return self;
    };
}

- (KFBlankSlateGeneralHandler * _Nonnull (^)(void))onFinished {
    return ^id {
        self.currentConfigState = KFDataLoadStateFinished;
        return self;
    };
}

- (KFBlankSlateGeneralHandler * _Nonnull (^)(NSString * _Nullable))title {
    return ^id(NSString *title) {
        [self setTitle:title forState:self.currentConfigState];
        return self;
    };
}

- (KFBlankSlateGeneralHandler * _Nonnull (^)(NSAttributedString * _Nullable))attributedTitle {
    return ^id(NSAttributedString *attributedTitle) {
        [self setAttributedTitle:attributedTitle forState:self.currentConfigState];
        return self;
    };
}

- (KFBlankSlateGeneralHandler * _Nonnull (^)(NSString * _Nullable))description {
    return ^id(NSString *description) {
        [self setDescription:description forState:self.currentConfigState];
        return self;
    };
}

- (KFBlankSlateGeneralHandler * _Nonnull (^)(NSAttributedString * _Nullable))attributedDescription {
    return ^id(NSAttributedString *attributedDescription) {
        [self setAttributedDescription:attributedDescription forState:self.currentConfigState];
        return self;
    };
}

- (KFBlankSlateGeneralHandler * _Nonnull (^)(UIImage * _Nullable))image {
    return ^id(UIImage *image) {
        [self setImage:image forState:self.currentConfigState];
        return self;
    };
}

- (KFBlankSlateGeneralHandler * _Nonnull (^)(UIColor * _Nullable))imageTintColor {
    return ^id(UIColor *imageTintColor) {
        [self setImageTintColor:imageTintColor forState:self.currentConfigState];
        return self;
    };
}

- (KFBlankSlateGeneralHandler * _Nonnull (^)(CAAnimation * _Nullable))imageAnimation {
    return ^id(CAAnimation *imageAnimation) {
        [self setImageAnimation:imageAnimation forState:self.currentConfigState];
        return self;
    };
}

- (KFBlankSlateGeneralHandler * _Nonnull (^)(NSString * _Nullable, UIControlState))buttonTitle {
    return ^id(NSString *buttonTitle, UIControlState state) {
        [self setButtonTitle:buttonTitle controlState:state forState:self.currentConfigState];
        return self;
    };
}

- (KFBlankSlateGeneralHandler * _Nonnull (^)(NSAttributedString * _Nullable, UIControlState))attributedButtonTitle {
    return ^id(NSAttributedString *attributedButtonTitle, UIControlState state) {
        [self setAttributedButtonTitle:attributedButtonTitle controlState:state forState:self.currentConfigState];
        return self;
    };
}

- (KFBlankSlateGeneralHandler * _Nonnull (^)(UIImage * _Nullable, UIControlState))buttonImage {
    return ^id(UIImage *buttonImage, UIControlState state) {
        [self setButtonImage:buttonImage controlState:state forState:self.currentConfigState];
        return self;
    };
}

- (KFBlankSlateGeneralHandler * _Nonnull (^)(UIImage * _Nullable, UIControlState))buttonBackgroundImage {
    return ^id(UIImage *buttonBackgroundImage, UIControlState state) {
        [self setButtonBackgroundImage:buttonBackgroundImage controlState:state forState:self.currentConfigState];
        return self;
    };
}

- (KFBlankSlateGeneralHandler * _Nonnull (^)(UIView * _Nullable))customView {
    return ^id(UIView *customView) {
        [self setCustomView:customView forState:self.currentConfigState];
        return self;
    };
}

- (KFBlankSlateGeneralHandler * _Nonnull (^)(UIColor * _Nullable))_backgroundColor {
    return ^id(UIColor *backgroundColor) {
        [self setBackgroundColor:backgroundColor forState:self.currentConfigState];
        return self;
    };
}

- (KFBlankSlateGeneralHandler * _Nonnull (^)(CGFloat))_verticalOffset {
    return ^id(CGFloat verticalOffset) {
        [self setVerticalOffset:verticalOffset forState:self.currentConfigState];
        return self;
    };
}

- (KFBlankSlateGeneralHandler * _Nonnull (^)(CGFloat))_spaceHeight {
    return ^id(CGFloat spaceHeight) {
        [self setSpaceHeight:spaceHeight forState:self.currentConfigState];
        return self;
    };
}

- (KFBlankSlateGeneralHandler * _Nonnull (^)(BOOL))_fadeIn {
    return ^id(BOOL fadeIn) {
        [self setFadeIn:fadeIn forState:self.currentConfigState];
        return self;
    };
}

- (KFBlankSlateGeneralHandler * _Nonnull (^)(BOOL))_forcedToDisplay {
    return ^id(BOOL forcedToDisplay) {
        [self setForcedToDisplay:forcedToDisplay forState:self.currentConfigState];
        return self;
    };
}

- (KFBlankSlateGeneralHandler * _Nonnull (^)(BOOL))_display {
    return ^id(BOOL display) {
        [self setDisplay:display forState:self.currentConfigState];
        return self;
    };
}

- (KFBlankSlateGeneralHandler * _Nonnull (^)(BOOL))_touchable {
    return ^id(BOOL touchable) {
        [self setTouchable:touchable forState:self.currentConfigState];
        return self;
    };
}

- (KFBlankSlateGeneralHandler * _Nonnull (^)(BOOL))_scrollable {
    return ^id(BOOL scrollable) {
        [self setScrollable:scrollable forState:self.currentConfigState];
        return self;
    };
}

- (KFBlankSlateGeneralHandler * _Nonnull (^)(BOOL))_animate {
    return ^id(BOOL animate) {
        [self setAnimate:animate forState:self.currentConfigState];
        return self;
    };
}

- (KFBlankSlateGeneralHandler * _Nonnull (^)(id _Nullable, SEL _Nonnull))reload {
    return ^id(id target, SEL action) {
        [self.reloadButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        return self;
    };
}

@end
