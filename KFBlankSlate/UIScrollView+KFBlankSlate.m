//
//  UIScrollView+KFBlankSlate.m
//  KFBlankSlateExample
//
//  Created by carefree on 2018/8/16.
//  Copyright © 2018年 Carefree. All rights reserved.
//

#import "UIScrollView+KFBlankSlate.h"
#import "KFBlankSlateHandler.h"
#import <objc/runtime.h>

@implementation UIScrollView (KFBlankSlate)

#pragma mark - handler
- (void)setKf_handler:(KFBlankSlateHandler *)kf_handler {
    if (kf_handler != self.kf_handler) {
        [self willChangeValueForKey:NSStringFromSelector(@selector(kf_handler))]; // KVO
        
        objc_setAssociatedObject(self, @selector(kf_handler), kf_handler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        kf_handler.scrollView = self;
        
        [self didChangeValueForKey:NSStringFromSelector(@selector(kf_handler))]; // KVO
    }
}

- (KFBlankSlateHandler *)kf_handler {
    return objc_getAssociatedObject(self, @selector(kf_handler));
}

@end
