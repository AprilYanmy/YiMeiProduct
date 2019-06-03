//
//  DANewDiaryListModel.m
//  BeautyProduct
//
//  Created by iMac-1 on 2018/9/3.
//  Copyright © 2018年 iOS_阿玮. All rights reserved.
//

#import "DANewDiaryListModel.h"

@implementation DANewDiaryListModel

- (void)setLastdotime:(NSString *)lastdotime{
    
    // iOS 生成的时间戳是10位
    self.showTime = [lastdotime getTimeFromTimestamp];
    NSLog(@"服务器返回的时间戳对应的时间是:%@",self.showTime);
    
}

- (void)setTitlepic:(NSString *)titlepic{
    
    _titlepic = titlepic;
    
    NSArray *titlePicArrs = [titlepic componentsSeparatedByString:@";"];
    
    if (titlePicArrs.count == 2) {
        self.left_titlepic = titlePicArrs[0];
        self.right_titlepic = titlePicArrs[1];
    }
    
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"result_id" : @"id"};
}

@end
