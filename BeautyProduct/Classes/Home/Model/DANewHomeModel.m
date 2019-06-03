//
//  DANewHomeModel.m
//  BeautyProduct
//
//  Created by iMac-1 on 2018/9/4.
//  Copyright © 2018年 iOS_阿玮. All rights reserved.
//

#import "DANewHomeModel.h"

@implementation DANewHomeModel

- (void)setPrice:(NSString *)price{
    
    _price = price;
    
    if (price) {
       
        NSArray *priceArrs = [price componentsSeparatedByString:@","];
        if (priceArrs.count != 3) {
            return;
        }
        self.price_show = priceArrs[1];
        self.price_old = priceArrs[2];
        
    }
    
    
}


+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"result_id" : @"id"};
}

@end
