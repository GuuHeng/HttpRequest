//
//  HttpRequestControl.h
//  HHHttpRequest
//
//  Created by HuHeng on 2017/4/24.
//  Copyright © 2017年 Hu Heng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpRequestMsg.h"

#define RequestTimeOut 20

@interface HttpRequestControl : NSObject

+ (instancetype)sharedInstance;

/**
 发送一个请求

 @param msg 封装好的请求参数的msg
 */
- (void)sendRequestMsg:(HttpRequestMsg *)msg;

/**
 取消一个请求

 @param msg 需要取消的msg
 */
- (void)cancelRequestMsg:(HttpRequestMsg *)msg;

/**
 取消所有请求
 */
- (void)cancelAllRequestMsg;

@end
