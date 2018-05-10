# HttpRequest

轻量级网络请求：
    发送请求msg;
    取消单个请求或所有请求；
    上传图片文件；
    
note: 

      1. 沿用 AFNetworking 单例 创建AFHTTPSessionManager
      2. 通过 代理 进行请求回调
      3. 通过 代理 进行请求类和控制器的回调
     
note:

``` 
    1. 导入‘AFNetworking’
    2. 继承 HHApiService 
    3. 根据需要在继承类中创建单个或多个请求Msg（避免commond模式引起的类爆炸）```
 
 
 
    
