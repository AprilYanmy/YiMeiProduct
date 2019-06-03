//
//  DANewProductModel.h
//  BeautyProduct
//
//  Created by iMac-1 on 2018/9/4.
//  Copyright © 2018年 iOS_阿玮. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Hospital;

@interface DANewProductModel : NSObject

/**
 商品 -------  id
 */
@property (nonatomic,copy) NSString *result_id;

/**
 商品 -------  展示的名称
 */
@property (nonatomic,copy) NSString *name;

/**
 商品 ------- 商品缩略图
 */
@property (nonatomic,copy) NSString *img;

/**
 商品 ------- json价格
 */
@property (nonatomic,copy) NSString *newprice;

/**
 商品 ------- json价格
 */
@property (nonatomic,copy) NSString *oldprice;

/**
 商品 ------- 展示价格
 */
@property (nonatomic,copy) NSString *price_show;

/**
 商品 ------- 原价格
 */
@property (nonatomic,copy) NSString *price_old;

/**
 商品 ------- 商品销量
 */
@property (nonatomic,copy) NSString *sale_num;

/**
 商品 ------- 商品规格参数
 */
@property (nonatomic,copy) NSString *program;

/**
 医院 ------- model
 */
@property (nonatomic,strong) Hospital *hospitalModel;

/**
 医院 ------- 商品详情图网址 数组
 */
@property (nonatomic,copy) NSArray *detail_imgs;

/**
 医院 ------- 商品显示高度 数组
 */
@property (nonatomic,strong) NSMutableArray *detail_heigthArrs;


@end

@interface Hospital : NSObject

/**
 医院 -------  id
 */
@property (nonatomic,copy) NSString *hospital_id;

/**
 商品 ------- 医院logo
 */
@property (nonatomic,copy) NSString *img;

/**
 商品 ------- 医院名称
 */
@property (nonatomic,copy) NSString *name;

/**
 商品 ------- 商品医院地址
 */
@property (nonatomic,copy) NSString *address;

/**
 医院 ------- 医院的星级图片
 */
@property (nonatomic,copy) NSString *starImgName;

@end
