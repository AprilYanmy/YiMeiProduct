//
//  DANewShopShowCell.m
//  BeautyProduct
//
//  Created by iMac-1 on 2018/8/30.
//  Copyright © 2018年 iOS_阿玮. All rights reserved.
//

#import "DANewShopShowCell.h"

@interface DANewShopShowCell ()

@property (weak, nonatomic) IBOutlet UIImageView *img_proShow;
@property (weak, nonatomic) IBOutlet UILabel *lab_title;
@property (weak, nonatomic) IBOutlet UILabel *lab_price;
@property (weak, nonatomic) IBOutlet UILabel *lab_oldPrice;
@property (weak, nonatomic) IBOutlet UILabel *lab_address;
@property (weak, nonatomic) IBOutlet UILabel *lab_sale;


@end

@implementation DANewShopShowCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(DANewHomeModel *)model{
    
    _model = model;
    [self.img_proShow sd_setImageWithURL:[NSURL URLWithString:model.img]];
    self.lab_title.text = model.name;
    self.lab_sale.text = model.sale_num;
    self.lab_address.text = model.hospital;
    self.lab_price.text = [NSString stringWithFormat:@"￥%@",model.price_show];
    self.lab_oldPrice.text = [NSString stringWithFormat:@"￥%@",model.price_old];
    
}

@end
