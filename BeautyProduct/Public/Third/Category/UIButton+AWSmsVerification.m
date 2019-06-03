//
//  UIButton+AWSmsVerification.m
//  GroupBuy
//
//  Created by Peoit_Czw on 2017/3/21.
//  Copyright © 2017年 招. All rights reserved.
//

#import "UIButton+AWSmsVerification.h"

@implementation UIButton (AWSmsVerification)
/**
 *  获取短信验证码倒计时
 *
 *  @param duration 倒计时时间
 */

- (void)startTimeWithDuration:(NSInteger)duration withTitleColor:(UIColor *)color
{
    __block NSInteger timeout = duration;
    
    //NSString *originalTitle = [self titleForState:UIControlStateNormal];
    UIColor *originalTitleColor = [self titleColorForState:UIControlStateNormal];
    UIFont *originalFont = self.titleLabel.font;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer_t = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer_t,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(timer_t, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(timer_t);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮为最初的状态
                [self setTitle:@"重新获取" forState:UIControlStateNormal];
                [self setTitleColor:originalTitleColor forState:UIControlStateNormal];
                self.titleLabel.font = originalFont;
                self.userInteractionEnabled = YES;
                
            });
        }else{
            NSInteger seconds = timeout % duration;
            if(seconds == 0){
                seconds = duration;
            }
            NSString *strTime = [NSString stringWithFormat:@"%.2ld", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{//根据自己需求设置倒计时显示
                [self setTitle:[NSString stringWithFormat:@"重新获取(%@)",strTime] forState:UIControlStateNormal];
                [self setTitleColor: color forState:UIControlStateNormal];
                //self.backgroundColor = [UIColor lightGrayColor];
                self.titleLabel.font = [UIFont boldSystemFontOfSize:13.0f];
                self.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(timer_t);
}

/**
 *  商家端获取短信验证码倒计时
 *
 *  @param duration 倒计时时间
 */

- (void)businessStartTimeWithDuration:(NSInteger)duration withTitleColor:(UIColor *)color
{
    __block NSInteger timeout = duration;
    
    //NSString *originalTitle = [self titleForState:UIControlStateNormal];
    UIColor *originalTitleColor = [self titleColorForState:UIControlStateNormal];
    UIFont *originalFont = self.titleLabel.font;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer_t = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer_t,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(timer_t, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(timer_t);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮为最初的状态
                self.layer.borderWidth = 1;
                self.backgroundColor = [UIColor clearColor];
                self.layer.borderColor = [UIColor redColor].CGColor;
                [self setTitle:@"重新获取" forState:UIControlStateNormal];
                [self setTitleColor:originalTitleColor forState:UIControlStateNormal];
                self.titleLabel.font = originalFont;
                self.userInteractionEnabled = YES;
                
            });
        }else{
            NSInteger seconds = timeout % duration;
            if(seconds == 0){
                seconds = duration;
            }
            NSString *strTime = [NSString stringWithFormat:@"%.2ld", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{//根据自己需求设置倒计时显示
                self.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:.3f];
                self.layer.borderWidth = 0;
                [self setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal];
                [self setTitleColor: color forState:UIControlStateNormal];
                //self.backgroundColor = [UIColor lightGrayColor];
                self.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
                self.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(timer_t);
}

@end
