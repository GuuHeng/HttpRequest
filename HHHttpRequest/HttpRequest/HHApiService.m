//
//  HHApiService.m
//  HHHttpRequest
//
//  Created by Hu Heng on 2017/5/15.
//  Copyright © 2017年 Hu Heng. All rights reserved.
//

#import "HHApiService.h"

@implementation HHApiService

- (instancetype)init
{
    self = [super init];
    if (self) {
        _control = [HttpRequestControl sharedInstance];
    }
    return self;
}

@end
