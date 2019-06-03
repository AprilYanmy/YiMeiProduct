//
//  DANewTabButton.h
//  BeautyProduct
//
//  Created by iMac-1 on 2018/8/30.
//  Copyright © 2018年 iOS_阿玮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DANewTabButton : UIButton

/**
 创建自定义导航底部按钮

 @param norImageName 默认图片
 @param selImageName 选中图片
 @param x            其实 x 坐标
 @return self
 */
+ (instancetype)creatCustomTaBarNor:(NSString *)norImageName
                            withSel:(NSString *)selImageName
                         withFrameX:(NSInteger)x;

@property (nonatomic,assign) NSInteger showIndex;

@property (nonatomic,assign) BOOL isShowSelect;

@property (nonatomic,strong) UIImageView *norImageView;
@property (nonatomic,strong) UIImageView *selImageView;

@end
