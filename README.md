# KFBlankSlate

[![Version](https://img.shields.io/cocoapods/v/KFBlankSlate.svg?style=flat)](http://cocoapods.org/pods/KFBlankSlate)
[![Platform](https://img.shields.io/cocoapods/p/KFBlankSlate.svg?style=flat)](http://cocoapods.org/pods/KFBlankSlate)
[![Language](https://img.shields.io/badge/language-ObjC-orange.svg)]()
[![Build Status](https://travis-ci.org/moliya/KFBlankSlate.svg?branch=master)](https://travis-ci.org/moliya/KFBlankSlate)
[![License](https://img.shields.io/cocoapods/l/KFBlankSlate.svg?style=flat)](https://raw.githubusercontent.com/moliya/KFBlankSlate/master/LICENSE)

***

<div class="half">
    <img src="https://raw.githubusercontent.com/moliya/KFBlankSlate/master/KFBlankSlateExample/KFBlankSlateExample/Screenshots/Untitled1.gif" width="42%"/> <img src="https://raw.githubusercontent.com/moliya/KFBlankSlate/master/KFBlankSlateExample/KFBlankSlateExample/Screenshots/Untitled2.gif" width="42%"/>
</div>

<div class="half">
    <img src="https://raw.githubusercontent.com/moliya/KFBlankSlate/master/KFBlankSlateExample/KFBlankSlateExample/Screenshots/Untitled3.gif" width="42%"/> <img src="https://raw.githubusercontent.com/moliya/KFBlankSlate/master/KFBlankSlateExample/KFBlankSlateExample/Screenshots/Untitled4.gif" width="42%"/>
</div>

## What 

KFBlankSlate is useful wrapper based on [DZNEmptyDataSet][DZNEmptyDataSet].

## Features
* Support four display states(Idle, Loading, Empty, Failed).
* Highly customizable, each display state can be configured.
* Support subclass for custom configuration.
* Easily Switch each state.
* Less code, more efficient.

## Demo
You can find demos in the `KFBlankSlateExample->KFBlankSlateExample.xcworkspace` project.

![Example project](https://raw.githubusercontent.com/moliya/KFBlankSlate/master/KFBlankSlateExample/KFBlankSlateExample/Screenshots/ScreenShots1.png)

## Requirements
iOS 8 and later.

## Installation

### CocoaPods
KFBlankSlate is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'KFBlankSlate'
```

## Usage
### KFBlankSlateGeneralHandler
Use KFBlankSlateGeneralHandler to show the custom view for empty/loading/error in UITableView/UICollectionView.

#### Basic usage
```Objective-C
KFBlankSlateGeneralHandler *handler = [[KFBlankSlateGeneralHandler alloc] init];
[handler setTitle:@"No data" forState:KFDataLoadStateEmpty];
[handler setDescription:@"This list is empty!" forState:KFDataLoadStateEmpty];
[handler setImage:[UIImage imageNamed:@"empty"] forState:KFDataLoadStateEmpty];
self.tableView.kf_handler = handler;
self.tableView.kf_handler.state = KFDataLoadStateEmpty;

```

#### State
KFBlankSlate  Provide four load states to display different situations.

```Objective-C
typedef NS_OPTIONS(NSUInteger, KFDataLoadState) {
    KFDataLoadStateIdle     = 1 << 0, //闲置
    KFDataLoadStateLoading  = 1 << 1, //加载中
    KFDataLoadStateEmpty    = 1 << 2, //数据空
    KFDataLoadStateFailed   = 1 << 3, //加载失败
};
```

#### Customization
Each state can be configured.

```Objective-C
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
/** 设置state状态下的图片动画 */
- (void)setImageAnimation:(CAAnimation *)animation forState:(KFDataLoadState)state;

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

/** 设置state状态下的fadeIn属性 */
- (void)setFadeIn:(BOOL)fadeIn forState:(KFDataLoadState)state;

/** 设置state状态下的forcedToDisplay属性 */
- (void)setForcedToDisplay:(BOOL)forcedToDisplay forState:(KFDataLoadState)state;

/** 设置state状态下的display属性 */
- (void)setDisplay:(BOOL)display forState:(KFDataLoadState)state;

/** 设置state状态下的touchable属性 */
- (void)setTouchable:(BOOL)touchable forState:(KFDataLoadState)state;

/** 设置state状态下的scrollable属性 */
- (void)setScrollable:(BOOL)scrollable forState:(KFDataLoadState)state;

/** 设置state状态下的animate属性 */
- (void)setAnimate:(BOOL)animate forState:(KFDataLoadState)state;

/** 设置state状态下的tapViewHandler回调 */
- (void)setTapViewHandler:(void (^)(UIView *view))tapViewHandler forState:(KFDataLoadState)state;

/** 设置state状态下的tapButtonHandler回调 */
- (void)setTapButtonHandler:(void (^)(UIButton *button))tapButtonHandler forState:(KFDataLoadState)state;
```

You can also set these properties for all states.

```Objective-C
/** 是否使用淡入动画（将会应用于全部状态） */
@property (nonatomic, assign) BOOL  fadeIn;
/** 是否显示（将会应用于全部状态） */
@property (nonatomic, assign) BOOL  display;
/** 是否在数据不为空的情况下仍然显示（将会应用于全部状态） */
@property (nonatomic, assign) BOOL  forcedToDisplay;
/** 是否可点击（将会应用于全部状态） */
@property (nonatomic, assign) BOOL  touchable;
/** 是否可滑动（将会应用于全部状态） */
@property (nonatomic, assign) BOOL  scrollable;
/** 是否可动画（将会应用于全部状态） */
@property (nonatomic, assign) BOOL  animate;
/** 点击按钮的事件回调（将会应用于全部状态） */
@property (nonatomic, copy) void (^tapButtonHandler)(UIButton *button);
/** 点击空白视图的事件回调（将会应用于全部状态） */
@property (nonatomic, copy) void (^tapViewHandler)(UIView *view);

/** 标题字体（将会应用于全部状态） */
@property (nonatomic, strong) UIFont    *titleFont;
/** 标题颜色（将会应用于全部状态） */
@property (nonatomic, strong) UIColor   *titleColor;
/** 描述字体（将会应用于全部状态） */
@property (nonatomic, strong) UIFont    *descriptionFont;
/** 描述颜色（将会应用于全部状态） */
@property (nonatomic, strong) UIColor   *descriptionColor;
/** 按钮标题字体（将会应用于全部状态） */
@property (nonatomic, strong) UIFont    *buttonTitleFont;
/** 按钮标题颜色（将会应用于全部状态） */
@property (nonatomic, strong) UIColor   *buttonTitleColor;
/** 背景颜色（将会应用于全部状态） */
@property (nonatomic, strong) UIColor   *backgroundColor;
/** 垂直偏移量（将会应用于全部状态） */
@property (nonatomic, assign) CGFloat   verticalOffset;
/** 视图的间距（将会应用于全部状态） */
@property (nonatomic, assign) CGFloat   spaceHeight;
```

#### Other

If you wish to custom entirely, a KFBlankSlateHandler subclass can help you.

## License

All source code is licensed under the [MIT License](https://raw.githubusercontent.com/moliya/KFBlankSlate/master/LICENSE).


<!-- external links -->

[DZNEmptyDataSet]:https://github.com/dzenbot/DZNEmptyDataSet
