//
//  ViewController.m
//  HHHttpRequest
//
//  Created by Hu Heng on 2017/5/15.
//  Copyright © 2017年 Hu Heng. All rights reserved.
//

#import "ViewController.h"
#import "DemoApiService.h"

@interface ViewController ()<DemoApiServiceDelegate>

@property (nonatomic, strong) DemoApiService *apiService;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // it's test. no work!
    [self.apiService beginGetDemoDataRequestWithUserID:@"9527"];
    
}

#pragma mark - DemoApiServiceDelegate

- (void)demoPrintfSucceed
{
    NSLog(@"request success");
}

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (DemoApiService *)apiService
{
    if (!_apiService) {
        _apiService = [[DemoApiService alloc] init];
        _apiService.delegate = self;
    }
    return _apiService;
}

@end
