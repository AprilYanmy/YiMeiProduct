//
//  AWBaseTableViewCell.m
//  ConstellationProduct
//
//  Created by iMac-1 on 2018/8/6.
//  Copyright © 2018年 iOS_阿玮. All rights reserved.
//

#import "AWBaseTableViewCell.h"

@implementation AWBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIViewController *)getCurrentVCWithCurrentView
{
    for (UIView *next = self ; next ; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
