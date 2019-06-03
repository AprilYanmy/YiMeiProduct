//
//  WQHomeAlertVC.h
//
//  Created by iMac-1 on 2017/11/28.
//  Copyright © 2017年 iOS_阿玮. All rights reserved.
//

#import "AWBaseVC.h"

@interface DAStarSMHomeAlertVC : AWBaseVC
//type == 0 关闭  1提交
@property (nonatomic,copy) void(^backBlock)(void);
@property(nonatomic,assign) int type; //0 首页 1提交资料返回 2绑定银行卡返回 3确认绑定银行卡 4退出
@property(nonatomic,assign) BOOL isQuit;
@end
