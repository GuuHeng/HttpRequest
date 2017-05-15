//
//  DemoApiService.h
//  HHHttpRequest
//
//  Created by Hu Heng on 2017/5/15.
//  Copyright © 2017年 Hu Heng. All rights reserved.
//

#import "HHApiService.h"

@protocol DemoApiServiceDelegate <NSObject>

- (void)demoPrintfSucceed;

@end

@interface DemoApiService : HHApiService

@property (nonatomic,weak) id<DemoApiServiceDelegate> delegate;

@property (nonatomic, strong) HttpRequestMsg *demoMsg;

- (void)beginGetDemoDataRequestWithUserID:(NSString *)userid;

@end
