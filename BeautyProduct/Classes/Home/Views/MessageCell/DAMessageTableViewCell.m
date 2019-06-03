//
//  DAMessageTableViewCell.m
//  Divination
//
//  Created by iMac-1 on 2018/7/5.
//  Copyright © 2018年 iOS_阿玮. All rights reserved.
//

#import "DAMessageTableViewCell.h"

@interface DAMessageTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *lab_title;
@property (weak, nonatomic) IBOutlet UILabel *lab_content;

@end

@implementation DAMessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
}

- (void)setModel:(DAMessageModel *)model{
    
    _model = model;
    _lab_content.text = model.content;
    _lab_title.text = model.title;
    
}

@end
