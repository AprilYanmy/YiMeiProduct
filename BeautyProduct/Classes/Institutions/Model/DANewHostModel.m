//
//  DANewHostModel.m
//  BeautyProduct
//
//  Created by iMac-1 on 2018/9/4.
//  Copyright © 2018年 iOS_阿玮. All rights reserved.
//

#import "DANewHostModel.h"

@implementation DANewHostModel

- (void)setAdvantage:(NSString *)advantage{
    
    _advantage = advantage;
    
    if (_advantage.length == 0) {
        _advantage = @"其它";
    }
    
    
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"result_id": @"id"};
}

@end
