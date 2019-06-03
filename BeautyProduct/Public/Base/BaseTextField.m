//
//  BaseTextField.m
//  茶语
//
//  Created by cy on 16/10/28.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "BaseTextField.h"

@implementation BaseTextField

- (void)setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
    self.layer.borderColor = _borderColor.CGColor;
    [self setNeedsDisplay];
}

-  (void)setBorderWidth:(CGFloat)borderWidth
{
    _borderWidth = borderWidth;
    self.layer.borderWidth = _borderWidth;
    [self setNeedsDisplay];
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    self.layer.masksToBounds = _cornerRadius>0;
    self.layer.cornerRadius = _cornerRadius;
    [self setNeedsDisplay];
}


- (void)setLeftImage:(UIImage *)leftImage
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (self.frame.size.height-21)/2, 21, 21)];
    imgView.image = leftImage;
    self.leftView = imgView;
    [self setNeedsDisplay];
}

@end
