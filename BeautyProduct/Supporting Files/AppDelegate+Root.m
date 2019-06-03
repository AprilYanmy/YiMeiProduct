//
//  AppDelegate+Root.m
//  AWDivinationProduct
//
//  Created by iMac-1 on 2018/5/17.
//  Copyright © 2018年 iOS_阿玮. All rights reserved.
//

#import "AppDelegate+Root.h"

#import "ZLTabbarController.h"
#import <UMCommon/UMCommon.h>
#import "DAMasterVC.h"

@implementation AppDelegate (Root)

- (void)creactRootVC
{
        
    //开发者需要显式的调用此函数，日志系统才能工作
    [UMConfigure initWithAppkey:UMengKey_TongJi channel:@"App Store"];
    [UMConfigure setLogEnabled:YES];//打开调试模式
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    self.window = [[UIWindow alloc]initWithFrame:Screen_bounds];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.window.rootViewController = [ZLTabbarController new];
    
    [self.window makeKeyAndVisible];
    
    
}

@end
