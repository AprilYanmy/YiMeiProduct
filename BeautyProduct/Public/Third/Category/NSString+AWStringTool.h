//
//  NSString+AWStringTool.h
//  GroupBuy
//
//  Created by Peoit_Czw on 2017/3/13.
//  Copyright © 2017年 招. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AWStringTool)

/** 判断手机号正误  */
+ (BOOL)valiMobile:(NSString *)mobileNum;

/** 判断客服电话 */
+(BOOL)validateCustomSever;

/**
  时间戳 转成 时间
 */
- (NSString *)getTimeFromTimestamp;

/**
 判断是否是纯汉字

 */
- (BOOL)isChinese;

#pragma mark ---- 手机号加密处理
+(NSString *)aw___setNumberEncryption:(NSString *)tell;

/**
 获取当前阅读次数
 */
+(NSString*)getCurrentReadCount;

/**
 获取 app 名称
 */
+(NSString*)aw___getAppName;

/**
 获取首页先显示今日
 */
+(NSString*)getHomeDayTime;

/**
 获取当前时间
 */
+(NSString*)getCurrentTimes;
/**
 获取启动时间
 */
+(NSString*)getAppTimes;
/**
 获取首页先显示时间
 */
+(NSString*)getHomeTimes;

/**
 获取首页先显示时间
 */
+(NSString*)getHomeShowCellTimes;

/** MD5加密  */
- (NSString *)md5String;

/** 邮箱正则表达式 */
+ (BOOL) validateEmail:(NSString *)email;

/** 字符串去除表情符号 */
+ (NSString*)disable_EmojiString:(NSString *)text;

/**
 计算文字高度
 
 @param fontSize 字体大小
 @return 高度
 */
//-(CGFloat)changeStationFont:(CGFloat)fontSize;

/** -- 计算文字高度  指定宽度 */
-(CGFloat)changeStationFont:(CGFloat)fontSize andWidth:(float)width;

/**
 -- 计算UILabel的高度(带有行间距的情况)

 @param height 间隔的高度
 @param font 字体大小
 @param width 宽度限制
 @return 高度
 */
-(CGFloat)getSpaceLabelHeight:(CGFloat)height withFont:(CGFloat)font withWidth:(CGFloat)width;

/** -- 获取文字宽度  */
-(CGFloat)getStringWidthFont:(NSInteger)font;

/** NSData 转成字符串 */
+(NSString*)stringFromDate:(NSDate*)date;

/** NSString转NSDate */
+(NSDate*)dateFromString:(NSString*)string;

/** 判断输入 是否为数字 */
+ (BOOL)isPureInt:(NSString*)string;

/** 判断输入 是否为身份证 */
+ (BOOL)validateIdCard:(NSString *)card;

#pragma mark -- 车牌 验证
+ (BOOL)isCarNumber:(NSString *)plate;


/** 判断全汉字*/
+ (BOOL)__AWdeptNameInputShouldChinese:(NSString*)string;

/** 判断全数字*/
+ (BOOL)__AWdeptNumInputShouldNumber:(NSString *)string;

/** 判断全字母*/
+ (BOOL)__AWdeptPassInputShouldAlpha:(NSString*)string;

/** 判断仅输入字母或数字*/
+ (BOOL)__AWdeptIdInputShouldAlphaNum:(NSString*)string;

/** 获取设备型号然后手动转化为对应名称*/
+ (NSString *)getDeviceName;

/** 判断文字 是否为空(@"")*/
+ (BOOL)isInputNil:(NSString *)string;

/** 判断文字是否包含*/
+ (BOOL)aw___isRangeStr:(NSString *)string rangeStr:(NSString *)range;

/** 汉字转拼音  */
+ (NSString *)aw___transform:(NSString *)chinese;

/** 手机号加密处理  */
+(NSString *)setNumberEncryption:(NSString *)tell;

/** 获取当前App版本 */
+(NSString *)getAPPVerson;

/** 获取当前用户的经度 */
+(NSString *)getUserLongitude;

/** 获取当前用户的纬度 */
+(NSString *)getUserLatitude;

/** 查询银行卡号所属银行 */
+ (NSString *)getBankName:(NSString*) cardId;

@end
