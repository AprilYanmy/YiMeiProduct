//
//  DANewInsiDetailModel.m
//  BeautyProduct
//
//  Created by iMac-1 on 2018/9/5.
//  Copyright © 2018年 iOS_阿玮. All rights reserved.
//

#import "DANewInsiDetailModel.h"

@implementation DANewInsiDetailModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"result_id": @"id",
              @"hotsalesModel": @"hot_sales"};
             
}

- (void)setLevel:(NSString *)level{
    
    _level = level;
    
    if ([NSString isInputNil:level]) {
        _level = @"暂无等级";
    }
    
}

- (void)setHotsalesModel:(NSArray<Hot_sales *> *)hotsalesModel{
    
    NSMutableArray *tmpArrs = [NSMutableArray arrayWithCapacity:0];
    
    for (NSDictionary *json in hotsalesModel) {
        
        Hot_sales *model = [Hot_sales yy_modelWithDictionary:json];
        [tmpArrs addObject:model];
        
    }
    _hotsalesModel = [NSArray arrayWithArray:tmpArrs];
    
}

- (void)setImgs:(NSArray *)imgs{
    
    _imgs = imgs;
    
    if (imgs.count > 6) {
        
        NSMutableArray *tmpNewArrs = [NSMutableArray arrayWithCapacity:0];
        
        int i = 0;
        
        for (NSString *str in imgs) {
            
            if (i < 6) {
                 [tmpNewArrs addObject:str];
            }
            
            i++;
        }
        
        _imgs = [NSArray arrayWithArray:tmpNewArrs];
        
    }
    
}

@end

@implementation Hot_sales

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
    
    return @{@"result_id": @"id"};
    
}

@end
