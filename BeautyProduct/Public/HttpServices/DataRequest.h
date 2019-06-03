//
//  DataRequest.h
//  MakeTea
//
//  Created by cy on 16/11/30.
//  Copyright © 2016年 cy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface DataRequest : NSObject
+ (void)Post:(NSString*)url parametes:(id)parameters success:(void (^)(id responObject))success failure:(void (^)(id responObject))failure error:(void (^)(id error))errorStr;
+ (void)filesPost:(NSString*)url parametes:(id)parameters files:(id)files success:(void (^)(id responObject))success failure:(void (^)(id responObject))failure error:(void (^)(id error))errorStr;
@end
