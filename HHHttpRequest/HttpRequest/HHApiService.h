//
//  HHApiService.h
//  HHHttpRequest
//
//  Created by Hu Heng on 2017/5/15.
//  Copyright © 2017年 Hu Heng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpRequestControl.h"
#import "HttpRequestMsg.h"

@interface HHApiService : NSObject<HttpResponseDelegate>

@property (nonatomic, strong, readonly) HttpRequestControl *control;

@end
