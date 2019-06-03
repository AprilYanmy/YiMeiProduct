//
//  MTWebViewVC.h
//  MakeTea
//
//  Created by cy on 2016/12/22.
//  Copyright © 2016年 cy. All rights reserved.
//

#import "AWBaseVC.h"

@interface MTWebViewVC : AWBaseVC
@property(nonatomic,strong)NSString *titleName;
@property(nonatomic,strong)NSString *url;
@property(nonatomic,assign)NSInteger type;//1:返回的是最上页  3 == 股票行情页
@property(nonatomic,assign)NSInteger typeStr;//1:url为html5，str
@end
