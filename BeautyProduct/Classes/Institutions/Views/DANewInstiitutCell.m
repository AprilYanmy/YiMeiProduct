//
//  DANewInstiitutCell.m
//  BeautyProduct
//
//  Created by iMac-1 on 2018/9/4.
//  Copyright © 2018年 iOS_阿玮. All rights reserved.
//

#import "DANewInstiitutCell.h"

@interface DANewInstiitutCell ()

@property (weak, nonatomic) IBOutlet UILabel *lab_name;
@property (weak, nonatomic) IBOutlet UILabel *lab_address;
@property (weak, nonatomic) IBOutlet UILabel *lab_product;


@end

@implementation DANewInstiitutCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setHostModel:(DANewHostModel *)hostModel{
    
    _hostModel = hostModel;
    self.lab_name.text = hostModel.name;
    self.lab_address.text = hostModel.address;
    self.lab_product.text = hostModel.advantage;
    
}

@end
