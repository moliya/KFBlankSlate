//
//  KFBlankSlateGeneralHandler.m
//  KFBlankSlateExample
//
//  Created by carefree on 2018/8/16.
//  Copyright © 2018年 Carefree. All rights reserved.
//

#import "KFBlankSlateGeneralHandler.h"

static NSInteger KFDataLoadStateAll = KFDataLoadStateIdle | KFDataLoadStateLoading | KFDataLoadStateEmpty | KFDataLoadStateFailed;

@interface KFBlankSlateGeneralHandler()

@property (nonatomic, strong) NSMutableDictionary   *titles;
@property (nonatomic, strong) NSMutableDictionary   *descriptions;
@property (nonatomic, strong) NSMutableDictionary   *images;
@property (nonatomic, strong) NSMutableDictionary   *imageTintColors;
@property (nonatomic, strong) NSMutableDictionary   *buttonTitles;
@property (nonatomic, strong) NSMutableDictionary   *buttonImages;
@property (nonatomic, strong) NSMutableDictionary   *buttonBackgroundImages;
@property (nonatomic, strong) NSMutableDictionary   *backgroundColors;
@property (nonatomic, strong) NSMutableDictionary   *customViews;
@property (nonatomic, strong) NSMutableDictionary   *verticalOffsets;
@property (nonatomic, strong) NSMutableDictionary   *spaceHeights;

@end

@implementation KFBlankSlateGeneralHandler

#pragma mark - Lifecycle
- (void)configure {
    [super configure];
    
    //设置默认值
    self.display = YES;
    self.forcedToDisplay = NO;
    self.touchable = YES;
    self.scrollable = YES;
    
    self.titles = [NSMutableDictionary dictionary];
    self.descriptions = [NSMutableDictionary dictionary];
    self.images = [NSMutableDictionary dictionary];
    self.imageTintColors = [NSMutableDictionary dictionary];
    self.buttonTitles = [NSMutableDictionary dictionary];
    self.buttonImages = [NSMutableDictionary dictionary];
    self.buttonBackgroundImages = [NSMutableDictionary dictionary];
    self.backgroundColors = [NSMutableDictionary dictionary];
    self.customViews = [NSMutableDictionary dictionary];
    self.verticalOffsets = [NSMutableDictionary dictionary];
    self.spaceHeights = [NSMutableDictionary dictionary];
}

#pragma mark - Setter
- (void)setTitle:(NSString *)title forState:(KFDataLoadState)state {
    if (!title) {
        [self setObject:nil inDictionary:self.titles forState:state];
        return;
    }
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:title];
    [self setObject:string inDictionary:self.titles forState:state];
}

- (void)setAttributedTitle:(NSAttributedString *)title forState:(KFDataLoadState)state {
    [self setObject:title inDictionary:self.titles forState:state];
}

- (void)setDescription:(NSString *)description forState:(KFDataLoadState)state {
    if (!description) {
        [self setObject:nil inDictionary:self.descriptions forState:state];
    }
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:description];
    [self setObject:string inDictionary:self.descriptions forState:state];
}

- (void)setAttributedDescription:(NSAttributedString *)description forState:(KFDataLoadState)state {
    [self setObject:description inDictionary:self.descriptions forState:state];
}

- (void)setImage:(UIImage *)image forState:(KFDataLoadState)state {
    [self setObject:image inDictionary:self.images forState:state];
}

- (void)setImageTintColor:(UIColor *)color forState:(KFDataLoadState)state {
    [self setObject:color inDictionary:self.imageTintColors forState:state];
}

- (void)setButtonTitle:(NSString *)title controlState:(UIControlState)cState forState:(KFDataLoadState)state {
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:title];
    [self setObject:string forControlState:cState inDictionary:self.buttonTitles forState:state];
}

- (void)setAttributedButtonTitle:(NSAttributedString *)title controlState:(UIControlState)cState forState:(KFDataLoadState)state {
    [self setObject:title forControlState:cState inDictionary:self.buttonTitles forState:state];
}

- (void)setButtonImage:(UIImage *)image controlState:(UIControlState)cState forState:(KFDataLoadState)state {
    [self setObject:image forControlState:cState inDictionary:self.buttonImages forState:state];
}

- (void)setButtonBackgroundImage:(UIImage *)image controlState:(UIControlState)cState forState:(KFDataLoadState)state {
    [self setObject:image forControlState:cState inDictionary:self.buttonBackgroundImages forState:state];
}

- (void)setBackgroundColor:(UIColor *)color forState:(KFDataLoadState)state {
    [self setObject:color inDictionary:self.backgroundColors forState:state];
}

- (void)setCustomView:(UIView *)view forState:(KFDataLoadState)state {
    [self setObject:view inDictionary:self.customViews forState:state];
}

- (void)setVerticalOffset:(CGFloat)offset forState:(KFDataLoadState)state {
    [self setObject:@(offset) inDictionary:self.verticalOffsets forState:state];
}

- (void)setSpaceHeight:(CGFloat)space forState:(KFDataLoadState)state {
    [self setObject:@(space) inDictionary:self.spaceHeights forState:state];
}

#pragma mark - DZNEmptyDataSetSource
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    return [self availableObjectInDictionary:self.titles];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    return [self availableObjectInDictionary:self.descriptions];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [self availableObjectInDictionary:self.images];
}

- (UIColor *)imageTintColorForEmptyDataSet:(UIScrollView *)scrollView {
    return [self availableObjectInDictionary:self.imageTintColors];
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    NSDictionary *dict = [self availableObjectInDictionary:self.buttonTitles];
    return dict ? dict[@(state)] : nil;
}

- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    NSDictionary *dict = [self availableObjectInDictionary:self.buttonImages];
    return dict ? dict[@(state)] : nil;
}

- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    NSDictionary *dict = [self availableObjectInDictionary:self.buttonBackgroundImages];
    return dict ? dict[@(state)] : nil;
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return [self availableObjectInDictionary:self.backgroundColors];
}

- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView {
    return [self availableObjectInDictionary:self.customViews];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    NSNumber *value = [self availableObjectInDictionary:self.verticalOffsets];
    return value ? [value floatValue] : 0;
}

- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
    NSNumber *value = [self availableObjectInDictionary:self.spaceHeights];
    return value ? [value floatValue] : 0;
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

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    if (self.tapViewHandler) {
        self.tapViewHandler(view);
    }
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    if (self.tapButtonHandler) {
        self.tapButtonHandler(button);
    }
}

#pragma mark - Private
- (void)setObject:(id)object inDictionary:(NSMutableDictionary *)dictionary forState:(KFDataLoadState)state {
    if (state & KFDataLoadStateIdle) {
        dictionary[@(KFDataLoadStateIdle)] = object;
    }
    if (state & KFDataLoadStateLoading) {
        dictionary[@(KFDataLoadStateLoading)] = object;
    }
    if (state & KFDataLoadStateEmpty) {
        dictionary[@(KFDataLoadStateEmpty)] = object;
    }
    if (state & KFDataLoadStateFailed) {
        dictionary[@(KFDataLoadStateFailed)] = object;
    }
}

- (void)setObject:(id)object forControlState:(UIControlState)cState inDictionary:(NSMutableDictionary *)dictionary forState:(KFDataLoadState)state {
    if (state & KFDataLoadStateIdle) {
        NSMutableDictionary *newDict = [NSMutableDictionary dictionary];
        NSDictionary *oldDict = [self availableObjectInDictionary:dictionary forState:KFDataLoadStateIdle];
        if (oldDict) {
            [newDict addEntriesFromDictionary:oldDict];
        }
        newDict[@(cState)] = object;
        dictionary[@(KFDataLoadStateIdle)] = newDict;
    }
    if (state & KFDataLoadStateLoading) {
        NSMutableDictionary *newDict = [NSMutableDictionary dictionary];
        NSDictionary *oldDict = [self availableObjectInDictionary:dictionary forState:KFDataLoadStateLoading];
        if (oldDict) {
            [newDict addEntriesFromDictionary:oldDict];
        }
        newDict[@(cState)] = object;
        dictionary[@(KFDataLoadStateLoading)] = newDict;
    }
    if (state & KFDataLoadStateEmpty) {
        NSMutableDictionary *newDict = [NSMutableDictionary dictionary];
        NSDictionary *oldDict = [self availableObjectInDictionary:dictionary forState:KFDataLoadStateEmpty];
        if (oldDict) {
            [newDict addEntriesFromDictionary:oldDict];
        }
        newDict[@(cState)] = object;
        dictionary[@(KFDataLoadStateEmpty)] = newDict;
    }
    if (state & KFDataLoadStateFailed) {
        NSMutableDictionary *newDict = [NSMutableDictionary dictionary];
        NSDictionary *oldDict = [self availableObjectInDictionary:dictionary forState:KFDataLoadStateFailed];
        if (oldDict) {
            [newDict addEntriesFromDictionary:oldDict];
        }
        newDict[@(cState)] = object;
        dictionary[@(KFDataLoadStateFailed)] = newDict;
    }
}

- (id)availableObjectInDictionary:(NSDictionary *)dictionary forState:(KFDataLoadState)state {
    for (NSNumber *key in [dictionary allKeys]) {
        NSUInteger option = [key unsignedIntegerValue];
        if (option & state) {
            return dictionary[key];
        }
    }
    return nil;
}

- (id)availableObjectInDictionary:(NSDictionary *)dictionary {
    return [self availableObjectInDictionary:dictionary forState:self.state];
}

@end
