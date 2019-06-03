//
//  DANewDiaryListModel.h
//  BeautyProduct
//
//  Created by iMac-1 on 2018/9/3.
//  Copyright © 2018年 iOS_阿玮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DANewDiaryListModel : NSObject

/**
 日记id
 */
@property (nonatomic,copy) NSString *restult_id;

/**
 查看次数
 */
@property (nonatomic,copy) NSString *onclick;

/**
 时间--时间戳
 */
@property (nonatomic,copy) NSString *lastdotime;

/**
 显示时间
 */
@property (nonatomic,copy) NSString *showTime;

/**
 标题
 */
@property (nonatomic,copy) NSString *title;

/**
 左右显示的图片
 */
@property (nonatomic,copy) NSString *titlepic;

/**
 左显示的图片
 */
@property (nonatomic,copy) NSString *left_titlepic;

/**
 右显示的图片
 */
@property (nonatomic,copy) NSString *right_titlepic;

/**
 简介
 */
@property (nonatomic,copy) NSString *smalltext;

/**
 跳转链接
 */
@property (nonatomic,copy) NSString *titleurl;

@end
