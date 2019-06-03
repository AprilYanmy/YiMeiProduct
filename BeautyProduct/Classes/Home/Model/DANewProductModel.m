//
//  DANewProductModel.m
//  BeautyProduct
//
//  Created by iMac-1 on 2018/9/4.
//  Copyright © 2018年 iOS_阿玮. All rights reserved.
//

#import "DANewProductModel.h"

@implementation DANewProductModel

- (void)setNewprice:(NSString *)newprice{
    
    _newprice = newprice;
    
    if (newprice) {
        
        if ([NSString aw___isRangeStr:newprice rangeStr:@"-"]) {
            
            NSArray *priceArrs = [newprice componentsSeparatedByString:@"-"];
            if (priceArrs.count != 2) {
                return;
            }
            _newprice = priceArrs[0];
            
        }else{
            
            _newprice = newprice;
            
        }
        
    }
    
}

- (void)setOldprice:(NSString *)oldprice{
    
    _oldprice = oldprice;
    
    if (oldprice) {
        
        if ([NSString aw___isRangeStr:oldprice rangeStr:@"-"]) {
            
            NSArray *priceArrs = [oldprice componentsSeparatedByString:@"-"];
            if (priceArrs.count != 2) {
                return;
            }
            
            _oldprice = priceArrs[0];
            
        }else{
            
            _oldprice = oldprice;
            
        }
        
    }
    
}

- (void)setDetail_imgs:(NSArray *)detail_imgs{
    
    _detail_imgs = detail_imgs;
    
    if (detail_imgs.count != 0) {
        
        NSMutableArray *tmpUrlHeightArrs = [NSMutableArray arrayWithCapacity:0];
        
        for (NSString *url in detail_imgs) {
            
            NSURL *imageUrl = [NSURL URLWithString:url];
            
            NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
            
            UIImage *image = [UIImage imageWithData:imageData];
            
            NSLog(@"w = %f,h = %f",image.size.width,image.size.height);
            
            float tmpHeight = SCREEN_WIDTH*image.size.height/image.size.width;
            
            [tmpUrlHeightArrs addObject:[NSString stringWithFormat:@"%.2f",tmpHeight]];
            
        }
        
        self.detail_heigthArrs = tmpUrlHeightArrs;
        
    }
    
    
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"result_id" : @"id",
             @"hospitalModel": @"hospital"};
}


@end

@implementation Hospital

- (void)setName:(NSString *)name{
    
    _name = name;
    if (name) {
        
        int index = (name.length%5 == 0)||(name.length%5 == 1) ? 3:name.length%5;
    
        self.starImgName = [NSString stringWithFormat:@"home_star%d",index];
        
    }
    
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"hospital_id" : @"id"};
}

@end
