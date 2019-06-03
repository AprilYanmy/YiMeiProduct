//
//  UIColor+ColorChange.h
//  XSProject
//
//  Created by Peoit_Czw on 2017/4/26.
//  Copyright © 2017年 Peoit_Czw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ColorChange)
/** 颜色转换：iOS中（以#开头）十六进制的颜色转换为UIColor(RGB)*/
+ (UIColor *) colorWithHexString: (NSString *)color;
@end
