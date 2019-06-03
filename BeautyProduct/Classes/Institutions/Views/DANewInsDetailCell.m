//
//  DANewInsDetailCell.m
//  BeautyProduct
//
//  Created by iMac-1 on 2018/9/5.
//  Copyright © 2018年 iOS_阿玮. All rights reserved.
//

#import "DANewInsDetailCell.h"

@interface DANewInsDetailCell ()

@property (weak, nonatomic) IBOutlet UIImageView *img_detaiIcon;
@property (weak, nonatomic) IBOutlet UILabel *lab_priceShow;
@property (weak, nonatomic) IBOutlet UILabel *lab_priceOld;
@property (weak, nonatomic) IBOutlet UILabel *lab_sales;
@property (weak, nonatomic) IBOutlet UILabel *lab_name;

@end

@implementation DANewInsDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(Hot_sales *)model{
    
    _model = model;
    [self.img_detaiIcon sd_setImageWithURL:[NSURL URLWithString:model.img]];
    self.lab_name.text = model.name;
    self.lab_sales.text = [NSString stringWithFormat:@"已出售:%@份",model.sale_num];
    self.lab_priceOld.text = [NSString stringWithFormat:@"￥%@",model.price_old];
    self.lab_priceShow.text = [NSString stringWithFormat:@"￥%@",model.price_show];
    
}

@end
