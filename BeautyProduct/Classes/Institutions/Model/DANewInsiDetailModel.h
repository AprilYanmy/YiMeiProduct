//
//  DANewInsiDetailModel.h
//  BeautyProduct
//
//  Created by iMac-1 on 2018/9/5.
//  Copyright © 2018年 iOS_阿玮. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Hot_sales;

@interface DANewInsiDetailModel : NSObject

/**
 整形医院id
 */
@property (nonatomic,copy) NSString *result_id;

/**
 整形医院名称
 */
@property (nonatomic,copy) NSString *name;

/**
 整形医院地址
 */
@property (nonatomic,copy) NSString *address;

/**
 整形医院性质
 */
@property (nonatomic,copy) NSString *qualification;

/**
 整形医院等级
 */
@property (nonatomic,copy) NSString *level;

/**
 整形医院面积
 */
@property (nonatomic,copy) NSString *surface;

/**
 整形医院Banner图片地址
 */
@property (nonatomic,copy) NSArray *imgs;

/**
 医院 ------- model
 */
@property (nonatomic,copy) NSArray<Hot_sales *> *hotsalesModel;

@end

@interface Hot_sales : NSObject

/**
 整形商品id
 */
@property (nonatomic,copy) NSString *result_id;

/**
 整形医院性质
 */
@property (nonatomic,copy) NSString *name;

/**
 整形医院等级
 */
@property (nonatomic,copy) NSString *img;

/**
 整形医院面积
 */
@property (nonatomic,copy) NSString *price;

/**
 整形医院Banner图片地址
 */
@property (nonatomic,copy) NSString *hospital;

/**
 整形医院旧价格
 */
@property (nonatomic,copy) NSString *price_old;

/**
 整形医院展示价格
 */
@property (nonatomic,copy) NSString *price_show;

/**
 整形医院Banner图片地址
 */
@property (nonatomic,copy) NSString *sale_num;

@end
