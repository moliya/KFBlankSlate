//
//  GeneralModel.m
//  KFBlankSlateExample
//
//  Created by Carefree on 2018/8/18.
//  Copyright © 2018年 Carefree. All rights reserved.
//

#import "GeneralModel.h"

@implementation GeneralModel

- (NSMutableArray *)images {
    if (_images) {
        return _images;
    }
    
    _images = [NSMutableArray array];
    
    return _images;
}

@end
