//
//  BaseTextField.h
//  茶语
//
//  Created by cy on 16/10/28.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
//IB_DESIGNABLE
@interface BaseTextField : UITextField

@property(nonatomic,assign)IBInspectable CGFloat cornerRadius;
@property (nonatomic,assign)IBInspectable CGFloat borderWidth;

@property (nonatomic,strong)IBInspectable UIColor *borderColor;
@property (nonatomic,strong)IBInspectable UIImage *leftImage;
@end
