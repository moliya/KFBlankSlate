//
//  MainViewController.h
//  KFBlankSlateExample
//
//  Created by Carefree on 2018/8/18.
//  Copyright © 2018年 Carefree. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, KFDisplayMode) {
    KFDisplayModeLoading,
    KFDisplayModeEmpty,
    KFDisplayModeFail,
    KFDisplayModeSuccess
};

@interface MainViewController : UITableViewController

@end
