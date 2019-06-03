//
//  AWBaseVC.h
//  AWDivinationProduct
//
//  Created by iMac-1 on 2018/5/16.
//  Copyright © 2018年 iOS_阿玮. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChooseStarBlock)(NSString *code);

@interface AWBaseVC : UIViewController

AWCopy(NSString, detailNews);

/**
 隐藏系统导航
 */
- (void)aw___hideSystemNav;
/**
 显示系统导航
 */
- (void)aw___showSystemNav;


#pragma mark ————————————————————————————————状态栏颜色
- (void)aw___statusBarStyle:(BOOL)isWhiteColor;

#pragma mark ————————————————————————————————导航顶部

/**
 顶部导航右侧按钮设置 --- 图标
 */
- (void)aw___setRightBtnImagName:(NSString *)img;

/**
 顶部导航右侧按钮设置 --- 文字
 */
- (void)aw___setRightBtnStrName:(NSString *)str;

#pragma mark ————————————————————————————————点击方法
- (void)rightBtnClick:(UIButton *)sender;

#pragma mark ————————————————————————————————视图跳转方法
- (void)aw___pushViewController:(UIViewController *)controller;

/**
 顶部导航左侧返回按钮 --- 点击事件
 */
- (void)leftBtnClick:(UIButton *)sender;

/**
 顶部导航左侧按钮设置 --- 图标
 */
- (void)aw___setLeftBtnImagName:(NSString *)img;

@end
