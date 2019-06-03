//
//  UIButton+AWSmsVerification.h
//  GroupBuy
//
//  Created by Peoit_Czw on 2017/3/21.
//  Copyright © 2017年 招. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (AWSmsVerification)

/**
 *  获取短信验证码倒计时
 *
 *  @param duration 倒计时时间
 */
- (void)startTimeWithDuration:(NSInteger)duration withTitleColor:(UIColor *)color;


/**
 *  商家端获取短信验证码倒计时
 *
 *  @param duration 倒计时时间
 */

- (void)businessStartTimeWithDuration:(NSInteger)duration withTitleColor:(UIColor *)color;

@end
