//
//  DataRequest.m
//  MakeTea
//
//  Created by cy on 16/11/30.
//  Copyright © 2016年 cy. All rights reserved.
//

#import "DataRequest.h"
#import "MyTool.h"

@implementation DataRequest

//对字典排序
+ (NSArray *)sortDictioanaryByKey:(NSDictionary *)dict{
    NSArray *keys = [dict allKeys];
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    return sortedArray;
}


///加密方式
+ (NSString *)regroupTheDictionary:(NSDictionary *)dict{
    //加密后的字符串和参数的拼接
    NSString *resultString;
    //添加头部
    NSMutableDictionary *addHeaderDict=[NSMutableDictionary dictionaryWithDictionary:dict];
    [addHeaderDict setObject:ApiVersion forKey:@"apiVersion"];
    [addHeaderDict setObject:Channel forKey:@"channel"];
    [addHeaderDict setObject:Version forKey:@"version"];
    [addHeaderDict setObject:AppName forKey:@"appName"];
    [addHeaderDict setObject:AppCode forKey:@"appCode"];
    
    NSArray *sortUsingArray=[self sortDictioanaryByKey:addHeaderDict];
    //参数拼接
    NSMutableString *tempMString=[NSMutableString stringWithFormat:@"{"];
    NSMutableString *encryptString=[NSMutableString string];
    for (NSString *key in sortUsingArray) {
        NSString *value=[addHeaderDict objectForKey:key];
        //不用于加密的字符串，参数串
        [tempMString appendFormat:@"\"%@\":\"%@\",",key,value];
        //加密用的字符串
        [encryptString appendFormat:@"%@:%@@",key,value];
    }
    //需要加密的字符串
    NSString *encryUsingString=[encryptString substringToIndex:encryptString.length-1];
    //拼接成的字符串，添加头部前字符串
    NSString *allParmString=[NSString stringWithFormat:@"%@",[tempMString substringToIndex:tempMString.length-1]];
    
    NSString *encryedString=[MyTool TripleDES:encryUsingString encryptOrDecrypt:kCCEncrypt];
    resultString=[NSString stringWithFormat:@"%@,\"key\":\"%@\"}",allParmString,encryedString];
    //    NSLog(@"最后请求字符串%@",resultString);
    
    return resultString;
}


+ (void)Post:(NSString*)url parametes:(id)parameters success:(void (^)(id responObject))success failure:(void (^)(id responObject))failure error:(void (^)(id error))errorStr
{
   
    NSString *parStr = [self regroupTheDictionary:parameters];
    
    NSMutableDictionary *ps= [[NSMutableDictionary alloc] init];
    [ps setObject:parStr forKey:@"IOSParam"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 10;
    manager.responseSerializer.acceptableContentTypes = nil;//[NSSet setWithObject:@"text/ plain"];
    manager.securityPolicy = [AFSecurityPolicy defaultPolicy];
    manager.securityPolicy.allowInvalidCertificates = YES;//忽略https证书
    manager.securityPolicy.validatesDomainName = NO;//是否验证域名  
//    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"ChayuCA" ofType:@"cer"];
//    NSData * certData =[NSData dataWithContentsOfFile:cerPath];
//    NSSet * certSet = [[NSSet alloc] initWithObjects:certData, nil];
//    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
//    // 是否允许,NO-- 不允许无效的证书
//    [securityPolicy setAllowInvalidCertificates:YES];
//    // 设置证书
//    [securityPolicy setPinnedCertificates:certSet];
//    manager.securityPolicy= securityPolicy;
    
//    manager.securityPolicy = [AFSecurityPolicy defaultPolicy];
//    manager.securityPolicy.allowInvalidCertificates = YES;//忽略https证书
//    manager.securityPolicy.validatesDomainName = NO;//是否验证域名
    
    [manager POST:url parameters:ps progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
        NSString *msg = [responseObject objectForKey:@"message"];
        NSInteger state = [[responseObject objectForKey:@"code"] integerValue];
        NSInteger successCode = [[responseObject objectForKey:@"success"] integerValue];
        
        if (state==1||successCode==1) {
            success(responseObject);
        }else{
            [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
            [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
            [SVProgressHUD showInfoWithStatus:msg];
    
            failure(responseObject);
        }

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
        [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
        [SVProgressHUD showErrorWithStatus:@"请求失败..."];
        errorStr(error);
    }];
    
}


+ (void)filesPost:(NSString*)url parametes:(id)parameters files:(id)files success:(void (^)(id responObject))success failure:(void (^)(id responObject))failure error:(void (^)(id error))errorStr
{
    //    WINDOW.userInteractionEnabled = NO;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 10;
//    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"ChayuCA" ofType:@"cer"];
//    NSData * certData =[NSData dataWithContentsOfFile:cerPath];
//    NSSet * certSet = [[NSSet alloc] initWithObjects:certData, nil];
//    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
//    // 是否允许,NO-- 不允许无效的证书
//    [securityPolicy setAllowInvalidCertificates:YES];
//    // 设置证书
//    [securityPolicy setPinnedCertificates:certSet];
//    manager.securityPolicy= securityPolicy;
    
    //    manager.securityPolicy = [AFSecurityPolicy defaultPolicy];
    //    manager.securityPolicy.allowInvalidCertificates = YES;//忽略https证书
    //    manager.securityPolicy.validatesDomainName = NO;//是否验证域名
    
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSString *name = [NSString stringWithFormat:@"%@",[parameters objectForKey:@"id"]];
         [formData appendPartWithFileData:files name:name fileName:[NSString stringWithFormat:@"%@.jpg",name] mimeType:@"image/jpg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
        NSString *msg = [responseObject objectForKey:@"message"];
        NSInteger state = [[responseObject objectForKey:@"code"] integerValue];
        NSInteger successCode = [[responseObject objectForKey:@"success"] integerValue];
        
        if (state==1||successCode==1) {
            success(responseObject);
        }else{
            [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
            [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
            [SVProgressHUD showInfoWithStatus:msg];
            
            failure(responseObject);
        }

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
        [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
        [SVProgressHUD showErrorWithStatus:@"请求失败..."];
        errorStr(error);
    }];
    
}
@end
