//
//  DANewDiaryCell.m
//  BeautyProduct
//
//  Created by iMac-1 on 2018/9/3.
//  Copyright © 2018年 iOS_阿玮. All rights reserved.
//

#import "DANewDiaryCell.h"

@interface DANewDiaryCell ()

@property (weak, nonatomic) IBOutlet UILabel *lab_title;
@property (weak, nonatomic) IBOutlet UILabel *lab_time;
@property (weak, nonatomic) IBOutlet UIImageView *img_leftPic;
@property (weak, nonatomic) IBOutlet UIImageView *img_rightPic;
@property (weak, nonatomic) IBOutlet UILabel *lab_diaryInfo;
@property (weak, nonatomic) IBOutlet UILabel *lab_lookCount;

@end;

@implementation DANewDiaryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.img_rightPic.clipsToBounds = self.img_leftPic.clipsToBounds = YES;
    self.img_rightPic.layer.cornerRadius = self.img_leftPic.layer.cornerRadius = 5;
    
}

- (void)setModel:(DANewDiaryListModel *)model{
    
    _model = model;
    
    if (model) {
        
        self.lab_title.text = model.title;
        self.lab_time.text = model.showTime;
        [self.img_leftPic sd_setImageWithURL:[NSURL URLWithString:model.left_titlepic]
                            placeholderImage:[UIImage imageNamed:@"detail_noPic"]];
        [self.img_rightPic sd_setImageWithURL:[NSURL URLWithString:model.right_titlepic]
                             placeholderImage:[UIImage imageNamed:@"detail_noPic"]];
        self.lab_diaryInfo.text = model.smalltext;
        self.lab_lookCount.text = model.onclick;
        
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
