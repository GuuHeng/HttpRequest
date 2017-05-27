//
//  HttpCache.h
//  SimpleDemo
//
//  Created by HuHeng on 2017/5/27.
//  Copyright © 2017年 Bric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpCache : NSObject<NSSecureCoding>

@property (nonatomic, assign) long long version;
@property (nonatomic, strong) NSString *appVersionString;
@property (nonatomic, assign) NSStringEncoding stringEncoding;
@property (nonatomic, strong) NSDate *creationDate;

@end
