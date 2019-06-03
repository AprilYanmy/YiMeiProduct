//
//  DAUpdataAlertVC.h
//  Divination
//
//  Created by iMac-1 on 2018/4/11.
//  Copyright © 2018年 iOS_阿玮. All rights reserved.
//

#import "AWBaseVC.h"

@interface DAUpdataAlertVC : AWBaseVC
//type == 0 关闭  1提交
@property (nonatomic,copy) void(^backBlock)(NSInteger type);
@end
