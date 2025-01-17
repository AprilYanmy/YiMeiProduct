//
//  UIButton+WebCache.m
//
//  Created by iMac-1 on 2017/8/11.
//  Copyright © 2017年 Peoit_Czw. All rights reserved.
//

#import "UIButton+WebCache.h"

@implementation UIButton (WebCache)

- (void)aw_setButtonImageWithUrl:(NSString *)urlStr{

    NSURL * url = [NSURL URLWithString:urlStr];
    
    // 根据图片的url下载图片数据
    dispatch_queue_t xrQueue = dispatch_queue_create("loadImage", NULL); // 创建GCD线程队列
    
    dispatch_async(xrQueue, ^{

        // 异步下载图片
        UIImage * img = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];

        // 主线程刷新UI
        
        dispatch_async(dispatch_get_main_queue(), ^{

            [self setImage:img forState:UIControlStateNormal];
            
        });

    });
    
}

@end
