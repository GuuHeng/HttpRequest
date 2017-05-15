//
//  HttpRequestMsg.h
//  HHHttpRequest
//
//  Created by HuHeng on 2017/4/24.
//  Copyright © 2017年 Hu Heng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MsgConstant.h"
#import "AFNetworking.h"

/**
 请求方法类型

 - POST: post
 - GET: get
 */
typedef NS_ENUM(NSInteger, RequestMethod) {
    RequestMethodPOST = 0,
    RequestMethodGET,
    RequestMethodPOST_UPLOAD
};

/**
 返回数据格式

 - JSON: Json格式
 - STREAM: 不符合Json格式
 */
typedef NS_ENUM(NSInteger, ResponseFormatType) {
    ResponseFormatTypeJSON = 0,
    ResponseFormatTypeSTREAM
};

/**
 解析错误invalid json;网络请求错误

 - ResponseErrorTypeInvalidJSONFormat: 无效json
 - ResponseErrorTypeInvalidStatusCode: 请求错误
 */
typedef NS_ENUM(NSInteger, ResponseErrorType) {
    ResponseErrorTypeInvalidJSONFormat = 0,
    ResponseErrorTypeInvalidStatusCode
};

@protocol AFMultipartFormData;

typedef void (^AFConstructingBlock)(id<AFMultipartFormData> formData);

@protocol HttpResponseDelegate;

@interface HttpRequestMsg : NSObject

@property (nonatomic, strong) NSURLSessionTask *requestTask;

/**
 请求标识 区别请求；方便以后取消请求等扩展需求
 */
@property (nonatomic, assign) MsgCMDCode cmdCode;

/**
 请求方式 default: POST
 */
@property (nonatomic, assign) RequestMethod requestMethod;

/**
 ***返回数据格式 default: JSON
 ***不是JSON格式，需要修改该属性
 */
@property (nonatomic, assign) ResponseFormatType responseFormat;

/**
 HttpResponseDelegate
 */
@property (nonatomic, weak) id<HttpResponseDelegate>delegate;


/////////////////////////////////////////////////////////////////////////
/**
 请求服务器地址
 */
@property (nonatomic, copy) NSString *baseUrlPath;

/**
 请求路径
 */
@property (nonatomic, copy) NSString *urlPath;

/**
 请求参数
 */
@property (nonatomic, strong) NSDictionary *paramDict;

/**
 上传数据
 */
@property (nonatomic, copy) AFConstructingBlock constructingBodyBlock;


/////////////////////////////////////////////////////////////////////////
/**
 进度
 */
@property (nonatomic, strong) NSProgress *progress;

/**
 返回数据  1、responseFormat:JSON（responseObject = NSDictionary） 2、responseFormat:STREAM（responseObject = NSData）
 */
@property (nonatomic, strong) id responseObject;


/////////////////////////////////////////////////////////////////////////
/**
 错误
 */
@property (nonatomic, strong) NSError *error;

/**
 错误类型
 */
@property (nonatomic, assign) ResponseErrorType errorType;



- (instancetype)initWithDelegate:(id<HttpResponseDelegate>)delegate
                         urlPath:(NSString *)urlPath
                       paramDict:(NSDictionary *)param
                         cmdCode:(MsgCMDCode)code;

- (void)cancelRequest;

@end

@protocol HttpResponseDelegate <NSObject>

@optional

/**
 请求完成（有请求返回）后的回调方法

 @param receiveMsg HttpRequestMsg对象
 */
- (void)receiveDidFinished:(HttpRequestMsg *)receiveMsg;

/**
 请求失败（超时，网络未连接等错误）后的回调方法

 @param receiveMsg HttpRequestMsg对象
 */
- (void)receiveDidFailed:(HttpRequestMsg *)receiveMsg;

@end

