//
//  AWVersionManager.m
//  Divination
//
//  Created by iMac-1 on 2018/4/11.
//  Copyright © 2018年 iOS_阿玮. All rights reserved.
//

#import "AWVersionManager.h"
#import "DAUpdataAlertVC.h"

@implementation AWVersionManager

/**
 *  @param appStoreID          应用在AppStore里面的ID (在iTunes Connect中获取)
 *                             Apple ID (为您的 App 自动生成的 ID)
 *                             1014895889
 *
 *  @param currentController   要显示的controller
 *  @param isShowReleaseNotes  是否显示版本更新日志
 */
+ (void)czw_updateVersionWithAppStoreID:(NSString *)appStoreID
                showInCurrentController:(UIViewController *)currentController
                     isShowReleaseNotes:(BOOL)isShowReleaseNotes{
    //确定请求路径
    NSURL *xlsn0wURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/cn/lookup?id=%@", appStoreID]];
    
    //创建请求对象 请求对象内部默认已经包含了请求头和请求方法（GET）
    NSURLRequest *xlsn0wURLRequest = [NSURLRequest requestWithURL:xlsn0wURL];
    
    /*
     第一个参数：会话对象的配置信息defaultSessionConfiguration 表示默认配置
     第二个参数：谁成为代理，此处为控制器本身即self
     第三个参数：队列，该队列决定代理方法在哪个线程中调用，可以传主队列|非主队列
     [NSOperationQueue mainQueue]   主队列：   代理方法在主线程中调用
     [[NSOperationQueue alloc]init] 非主队列： 代理方法在子线程中调用
     */
    NSURLSession *xlsn0wURLSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                                                   delegate:nil
                                                              delegateQueue:[NSOperationQueue mainQueue]];
    
    //根据会话对象创建一个Task(发送请求）
    NSURLSessionDataTask *xlsn0wURLSessionDataTask = [xlsn0wURLSession dataTaskWithRequest:xlsn0wURLRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //获取当前工程项目版本号
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSLog(@"infoDictionary %@", infoDictionary);
        
        NSString *currentVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        
        if (data == nil) {
            NSLog(@"您没有连接网络");
            [SVProgressHUD showErrorWithStatus:@"您没有连接网络!"];
            return;
        }
        
        NSDictionary *JSONDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        if (error) {
            NSLog(@"error %@", error);
            return;
        }
        
        NSLog(@"%@", JSONDictionary);
        
        //KEYresultCount = 1//表示搜到一个符合你要求的APP
        //results =（）//这是个只有一个元素的数组，里面都是app信息，那一个元素就是一个字典。里面有各种key。其中有 trackName （名称）trackViewUrl = （下载地址）version （可显示的版本号）等
        NSArray *resultsArray = JSONDictionary[@"results"];
        
        if (resultsArray.count < 1) {
            NSLog(@"此APPID为未上架的APP或者查询不到");
//            [SVProgressHUD showErrorWithStatus:@"此APPID为未上架的APP或者查询不到"];
            return;
        }
        
        NSDictionary *appStoreDictionary = [resultsArray firstObject];
        
        NSString *appStoreVersion = appStoreDictionary[@"version"];//App Store版本号
        NSString *releaseNotes = [appStoreDictionary objectForKey:@"releaseNotes"];//更新日志
        NSString *trackViewUrl = [appStoreDictionary objectForKey:@"trackViewUrl"];
        
        //打印版本号
        NSLog(@"当前版本号:%@\n商店版本号:%@", currentVersion, appStoreVersion);
        //设置版本号
        currentVersion = [currentVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
        if (currentVersion.length==2) {
            currentVersion  = [currentVersion stringByAppendingString:@"0"];
        }else if (currentVersion.length==1){
            currentVersion  = [currentVersion stringByAppendingString:@"00"];
        }
        appStoreVersion = [appStoreVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
        if (appStoreVersion.length==2) {
            appStoreVersion  = [appStoreVersion stringByAppendingString:@"0"];
        }else if (appStoreVersion.length==1){
            appStoreVersion  = [appStoreVersion stringByAppendingString:@"00"];
        }
        
        BOOL isNewVersion = [AWVersionManager czw_compareVersionsFormAppStoreVersion:appStoreVersion currentAppVersion:currentVersion];
        
        //App Store有新版本 则更新版本
        if(isNewVersion == YES) {
            
            NSString *message = [NSString string];
            
            if (isShowReleaseNotes == YES) {//显示App Store里面 应用版本更新日志
                message = releaseNotes;
            } else {//显示固定更新提示
                message = [NSString stringWithFormat:@"检测到新版本(%@), 是否更新?", appStoreDictionary[@"version"]];
            }
            DAUpdataAlertVC *vc = [[DAUpdataAlertVC alloc] initWithNibName:@"DAUpdataAlertVC" bundle:nil];
            [vc setBackBlock:^(NSInteger type){
                if (type == 1) {
                    //此处加入应用在App Store的地址，方便用户去跳转更新，一种实现方式如下
                    //NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@?ls=1&mt=8", appStoreID]];
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:trackViewUrl]];
                }
            }];
            vc.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.8f];
            vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
            [currentController presentViewController:vc animated:NO completion:nil];

            
        } else {
            NSLog(@"您当前版本已经最新");
        }
    }];
    
    //执行任务
    [xlsn0wURLSessionDataTask resume];
}

//比较版本的方法，在这里我用的是Version来比较的
+ (BOOL)czw_compareVersionsFormAppStoreVersion:(NSString*)AppStoreVersion currentAppVersion:(NSString*)currentAppVersion {
    
    BOOL littleSunResult = false;
    
    NSMutableArray* a = (NSMutableArray*) [AppStoreVersion componentsSeparatedByString: @"."];
    NSMutableArray* b = (NSMutableArray*) [currentAppVersion componentsSeparatedByString: @"."];
    
    while (a.count < b.count) { [a addObject: @"0"]; }
    while (b.count < a.count) { [b addObject: @"0"]; }
    
    for (int j = 0; j<a.count; j++) {
        if ([[a objectAtIndex:j] integerValue] > [[b objectAtIndex:j] integerValue]) {
            littleSunResult = true;
            break;
        }else if([[a objectAtIndex:j] integerValue] < [[b objectAtIndex:j] integerValue]){
            littleSunResult = false;
            break;
        }else{
            littleSunResult = false;
        }
    }
    return littleSunResult;//true就是有新版本，false就是没有新版本
}

@end
