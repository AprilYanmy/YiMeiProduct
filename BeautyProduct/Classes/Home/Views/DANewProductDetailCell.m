//
//  DANewProductDetailCell.m
//  BeautyProduct
//
//  Created by iMac-1 on 2018/9/4.
//  Copyright © 2018年 iOS_阿玮. All rights reserved.
//

#import "DANewProductDetailCell.h"

@interface DANewProductDetailCell ()

@property (weak, nonatomic) IBOutlet UIImageView *img_showDetail;

@end

@implementation DANewProductDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setImgUrl:(NSString *)imgUrl{
    
    _imgUrl = imgUrl;
    [self.img_showDetail sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
    
}

@end
