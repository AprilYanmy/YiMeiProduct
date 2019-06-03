//
//  DAUserInfo.h
//  Divination
//
//  Created by iMac-1 on 2018/4/3.
//  Copyright © 2018年 iOS_阿玮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DANewUserInfo : NSObject

@property (nonatomic, copy) NSString *userID;    //用户ID
@property (nonatomic, copy) NSString *nickName; //姓名
@property (nonatomic, copy) NSString *maritalStatus; //婚姻状况
@property (nonatomic, copy) NSString *true_name;     //真实姓名
@property (nonatomic, copy) NSString *sex; //性别
@property (nonatomic, copy) NSString *birthday; //生日
@property (nonatomic, copy) NSString *tell; //电话
@property (nonatomic, copy) NSString *workInfo; //工作状况
@property (nonatomic, copy) NSString *email; //邮箱地址
@property (nonatomic, copy) NSString *user_headerUrl; //头像地址


//用户模型单例
+ (instancetype)sharedInstance;
//存储用户信息
+ (BOOL)synchronize;
//是否登录
+ (BOOL)isLogIn;
//退出App
+ (BOOL)logout;

@end
