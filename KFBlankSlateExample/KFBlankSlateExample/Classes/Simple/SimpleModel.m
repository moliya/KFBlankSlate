//
//  SimpleModel.m
//  KFBlankSlateExample
//
//  Created by carefree on 2018/8/17.
//  Copyright © 2018年 Carefree. All rights reserved.
//

#import "SimpleModel.h"

@implementation SimpleModel

- (NSMutableArray *)images {
    if (_images) {
        return _images;
    }
    
    _images = [NSMutableArray array];
    
    return _images;
}

@end
