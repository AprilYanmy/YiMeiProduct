//
//  DAMineEmailVC.h
//  Divination
//
//  Created by iMac-1 on 2018/3/30.
//  Copyright © 2018年 iOS_阿玮. All rights reserved.
//

#import "AWBaseVC.h"

typedef void(^BlockString)(NSString *content,NSInteger type);

@interface DAStarAWMineEmailVC : AWBaseVC

/**
 0:绑定邮箱  1:昵称
 */
@property (nonatomic,assign) NSInteger type;

@property (nonatomic,copy) BlockString contentBack;

@end

