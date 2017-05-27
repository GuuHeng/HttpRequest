//
//  HttpRequestMsg.m
//  HHHttpRequest
//
//  Created by HuHeng on 2017/4/24.
//  Copyright © 2017年 Hu Heng. All rights reserved.
//

#import "HttpRequestMsg.h"
#import "HttpRequestControl.h"
#import "HttpCache.h"
#import <CommonCrypto/CommonDigest.h>

@interface HttpRequestMsg ()

@property (nonatomic, assign) BOOL isDataFromCache;

@end

@implementation HttpRequestMsg

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self setup];
        
    }
    return self;
}

- (void) setup
{
    self.baseUrlPath = @"www.demo.com";
    self.requestMethod = RequestMethodPOST;
    self.responseFormat = ResponseFormatTypeJSON;
}

- (instancetype)initWithDelegate:(id<HttpResponseDelegate>)delegate
                         urlPath:(NSString *)urlPath
                       paramDict:(NSDictionary *)param
                         cmdCode:(MsgCMDCode)code
{
    self = [super init];
    if (self) {
        
        [self setup];
        self.delegate = delegate;
        self.urlPath = urlPath;
        self.paramDict = param;
        self.cmdCode = code;
        
    }
    return self;
}

- (void)cancelRequest
{
    _delegate = nil;
    [[HttpRequestControl sharedInstance] cancelRequestMsg:self];
}

- (void)saveDataToCache:(NSData *)data
{
    if (!self.isDataFromCache) {
        if (data != nil) {
            
            [data writeToFile:[self cacheFilePath] atomically:YES];
            
            HttpCache *cache = [[HttpCache alloc] init];
            cache.version = 0;
            cache.creationDate = [NSDate date];
            cache.appVersionString = [self appVersionString];
            [NSKeyedArchiver archiveRootObject:cache toFile:[self cacheFilePath]];
        }
    }
}

- (NSString *)appVersionString
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}


- (NSString *)md5StringFromString:(NSString *)string
{
    NSParameterAssert(string != nil && [string length] > 0);
    
    const char *value = [string UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}


- (NSString *)cacheFileName
{
    NSString *urlPath = [self urlPath];
    NSString *baseUrlPath = [self baseUrlPath];
    
    NSString *msgInfo = [NSString stringWithFormat:@"Method:%ld Host:%@ Url:%@",
                         (long)[self requestMethod], baseUrlPath, urlPath];
    NSString *cacheFileName = [self md5StringFromString:msgInfo];
    return cacheFileName;
}

- (NSString *)cacheFilePath
{
    NSString *path = [self cacheBasePath];
    NSString *cacheFileName = @"";
    path = [path stringByAppendingPathComponent:cacheFileName];
    return path;
}

- (NSString *)cacheBasePath
{
    NSString *library = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    NSString *path = [library stringByAppendingPathComponent:@"LazyCache"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    if (![fileManager fileExistsAtPath:path isDirectory:&isDir]) {
        [self createBaseDirectoryAtPath:path];
    } else {
        if (!isDir) {
            NSError *error = nil;
            [fileManager removeItemAtPath:path error:&error];
            [self createBaseDirectoryAtPath:path];
        }
    }
    return path;
}

- (void)createBaseDirectoryAtPath:(NSString *)path
{
    NSError *error = nil;
    [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
}

@end
