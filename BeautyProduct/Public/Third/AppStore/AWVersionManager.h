//
//  AWVersionManager.h
//  Divination
//
//  Created by iMac-1 on 2018/4/11.
//  Copyright © 2018年 iOS_阿玮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AWVersionManager : NSObject
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
                     isShowReleaseNotes:(BOOL)isShowReleaseNotes;
@end
