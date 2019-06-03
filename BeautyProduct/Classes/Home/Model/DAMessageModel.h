//
//  DAMessageModel.h
//  Divination
//
//  Created by iMac-1 on 2018/7/5.
//  Copyright © 2018年 iOS_阿玮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAMessageModel : NSObject

/**
 文章内容 -------  id
 */
@property (nonatomic,copy) NSString *result_id;

/**
 文章网址 -------  展示的第三方网址
 */
@property (nonatomic,copy) NSString *url;


/**
 文章标题 ------- 标题内容
 */
@property (nonatomic,copy) NSString *title;

/**
 文章详情页 ------- 详情内容展示
 */
@property (nonatomic,copy) NSString *content;

@end
