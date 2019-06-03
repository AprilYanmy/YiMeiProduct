//
//  DANewHomeModel.h
//  BeautyProduct
//
//  Created by iMac-1 on 2018/9/4.
//  Copyright © 2018年 iOS_阿玮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DANewHomeModel : NSObject

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
@property (nonatomic,copy) NSString *price;

/**
 商品 ------- 展示价格
 */
@property (nonatomic,copy) NSString *price_show;

/**
 商品 ------- 原价格
 */
@property (nonatomic,copy) NSString *price_old;

/**
 商品 ------- 商品医院地址
 */
@property (nonatomic,copy) NSString *hospital;

/**
 商品 ------- 商品销量
 */
@property (nonatomic,copy) NSString *sale_num;

@end
