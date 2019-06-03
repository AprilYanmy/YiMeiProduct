//
//  AFNRequestManager.m
//  Czw_Afn
//
//  Created by iOS_czw on 2017/1/10.
//  Copyright © 2017年 iOS_czw. All rights reserved.
//

#import "AFNRequestManager.h"

#import "AFNetworking.h"

static AFHTTPSessionManager *manager = nil;

@implementation AFNRequestManager

/** AFHTTPSessionManager单例 */
+ (AFHTTPSessionManager *)defaultManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        //HTTPS SSL的验证，在此处调用上面的代码，给这个证书验证；
        //[manager setSecurityPolicy:[NetWorkingManger customSecurityPolicy]];
        // 设置接受解析的内容类型
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"text/plain",@"text/javascript",@"application/json", nil];
        
    });
    return manager;
}

//https 证书
+ (AFSecurityPolicy *)customSecurityPolicy
{
    //先导入证书，找到证书的路径
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"letsrace_test" ofType:@"cer"];
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    //AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    //allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    //如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    NSSet *set = [[NSSet alloc] initWithObjects:certData, nil];
    securityPolicy.pinnedCertificates = set;
    
    return securityPolicy;
}

/**
 *  发起网络请求
 *
 *  @param method      请求方法
 *  @param url         请求url
 *  @param requestData 请求data数据
 *  @param completion 完成的回调
 *
*/
+(void)__request:(AWRequestType)method urlstr:(NSString *)url requestData:(id)requestData completion:(void(^)(id responseObject, NSError *error))completion{

    NSLog(@"请求参数%@",requestData);
    if ([url isEqualToString:@""])
    {
        NSError *error = [NSError errorWithDomain:@"-----400" code:400 userInfo:nil];
        completion(nil,error);
        return ;
    }
    
    AFHTTPSessionManager *manager = [AFNRequestManager defaultManager];
    
    if (method == AWPost_request) {
        
        //发出post请求
        if (requestData ==nil)
        {
            NSLog(@"请求参数为空");
            NSError *error = [NSError errorWithDomain:@"-----909" code:900 userInfo:nil];
            
            completion(nil,error);
            return ;
        }
        
        [manager POST:url parameters:requestData progress:^(NSProgress * _Nonnull uploadProgress) {
            
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
            
            NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            NSLog(@" === %@",jsonString);
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            if (completion) completion(dic,nil);
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"---%@",error);
            if (completion) completion(nil,error);
        }];
    }
    
    if (method == AWGet_request) {
    
        [manager GET:url parameters:requestData progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
            
            NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            NSLog(@" === %@",jsonString);
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            if (completion) completion(dic,nil);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"---%@",error);
            if (completion) completion(nil,error);
        }];
        
    }
    
    if (method == AWPut_request) {
        [manager PUT:url parameters:requestData success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
            
            NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            NSLog(@" === %@",jsonString);
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            if (completion) completion(dic,nil);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"---%@",error);
            if (completion) completion(nil,error);
        }];
    }
    
    if (method == AWDelete_request) {
        [manager DELETE:url parameters:requestData success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
            
            NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            NSLog(@" === %@",jsonString);
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            if (completion) completion(dic,nil);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"---%@",error);
            if (completion) completion(nil,error);

        }];
    }
    
    
}

#pragma mark -- 上传用户头像图片
+(void)upload__UserPhotoWithUrl:(NSString *)upload_Url withUploadPhoto:(NSString *)photoName andPicData:(NSData *)pic_data requestData:(id)requestData withBlock:(void(^)(id sucuess,NSError *error))block{
    
    AFHTTPSessionManager *manager = [AFNRequestManager defaultManager];
    
    [manager POST:upload_Url parameters:requestData constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFileData:pic_data name:photoName fileName:@"image.png" mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *showDic = responseObject;
        block([showDic objectForKey:@"success"],nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(nil,error);
    }];
    
}

#pragma mark -- 多张上传图片
+(void)upload_More_photoWithUrl:(NSString *)upload_Url requestData:(id)requestData withUploadPhoto:(NSString *)photoName andPicData:(NSMutableArray *)pic_array WithBlock:(void(^)(id sucuess,NSError *error))block{
    
    AFHTTPSessionManager *manager = [AFNRequestManager defaultManager];
    
    [manager POST:upload_Url parameters:requestData constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (NSData *imageData in pic_array) {
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
            
            [formData appendPartWithFileData:imageData name:photoName fileName:fileName mimeType:@"image/png"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@" === %@",jsonString);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            block([responseObject objectForKey:@"success"],nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(nil,error);
    }];
    
}

/**
 压缩图片
 @param myimage 要压缩的图片
 @return 返回 NSData 数据
 */
-(NSData *)imageData:(UIImage *)myimage{
    
    NSData *data = UIImageJPEGRepresentation(myimage, 1.0);
    
    if (data.length>100*1024) {
        
        if (data.length>1024*1024) {//1M以及以上
            
            data=UIImageJPEGRepresentation(myimage, 0.1);
            
        }else if (data.length>512*1024) {//0.5M-1M
            
            data=UIImageJPEGRepresentation(myimage, 0.5);
            
        }else if (data.length>200*1024) {//0.25M-0.5M
            
            data=UIImageJPEGRepresentation(myimage, 0.9);
        }
    }
    return data;
}


@end
