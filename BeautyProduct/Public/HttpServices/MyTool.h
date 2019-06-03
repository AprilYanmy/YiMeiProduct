//
//  MyTool.h
//  MakeTea
//
//  Created by zqc on 2016/12/4.
//  Copyright © 2016年 cy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>
#import "GTMBase64.h"

#define NewScore @"NewScore"
#define OldTime @"OldTime"

@interface MyTool : NSObject
+ (NSString*)TripleDES:(NSString*)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt;

///保存信息
+ (void)setAddObject:(id)Object key:(NSString *)Key;

///清除信息
+ (void)setRemoveObject:(NSString *)Key;

///获取信息
+(NSString *)setObtainObject:(NSString *)Key;

///获取存储字典
+(NSDictionary *)setObtainDictionary:(NSString *)Key;

+ (CGRect)relativeFrameForScreenWithView:(UIView *)v;

//身份证号
+ (BOOL) validateIdentityCard: (NSString *)value;

//银行卡号判断
+ (BOOL) IsBankCard:(NSString *)cardNumber;

@end
