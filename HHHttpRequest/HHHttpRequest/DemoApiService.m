//
//  DemoApiService.m
//  HHHttpRequest
//
//  Created by Hu Heng on 2017/5/15.
//  Copyright © 2017年 Hu Heng. All rights reserved.
//

#import "DemoApiService.h"

@implementation DemoApiService

- (instancetype)init
{
    self = [super init];
    if (self) {
        _demoMsg = [[HttpRequestMsg alloc] init];
    }
    return self;
}

#pragma mark - 

- (void)beginGetDemoDataRequestWithUserID:(NSString *)userid
{
    NSDictionary *dict = @{@"userid": userid};
    
    self.demoMsg = [[HttpRequestMsg alloc] initWithDelegate:self urlPath:@"user/userinfo" paramDict:dict cmdCode:MCC_UserInfo];
    
    [self.control sendRequestMsg:self.demoMsg];
}

#pragma mark - 

- (void)receiveDidFinished:(HttpRequestMsg *)receiveMsg
{
    if ([receiveMsg.responseObject[@"success"] intValue] == 0) {
        
        if ([_delegate respondsToSelector:@selector(demoPrintfSucceed)]) {
            [_delegate demoPrintfSucceed];
        }
        
    }
}

- (void)receiveDidFailed:(HttpRequestMsg *)receiveMsg
{
    NSLog(@"receiveMsg error : %@", receiveMsg.error);
    // do something ...
}

@end
