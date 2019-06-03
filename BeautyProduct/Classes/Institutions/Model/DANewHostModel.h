//
//  DANewHostModel.h
//  BeautyProduct
//
//  Created by iMac-1 on 2018/9/4.
//  Copyright © 2018年 iOS_阿玮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DANewHostModel : NSObject

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
 整形医院特色
 */
@property (nonatomic,copy) NSString *advantage;

@end
