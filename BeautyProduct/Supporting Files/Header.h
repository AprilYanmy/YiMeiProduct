//
//  Header.h
//
//  Created by Peoit_Czw on 2017/8/3.
//  Copyright © 2017年 Peoit_Czw. All rights reserved.
//

#ifndef Header_h
#define Header_h

#define IPhoneApp_ID @"1429358156"

#define Push_AppKey @"af0e5b2f9b3a7ba453074231"

//-------------------- user Defaults --------------------
#define USER_DEFAULT    [NSUserDefaults standardUserDefaults]

//-------------------- 友盟统计Key --------------------
#define UMengKey_TongJi @"5b8795ed8f4a9d617b00003b"

//-------------------- shared Application --------------------
#define LIAPP_DELEGATE ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define LIAPP_NAVIGATION_DELEGATE ((AppDelegate *)[UIApplication sharedApplication].delegate.navigationController)

//------------------- dvices info ------------------
#define IPHONE4                 ([[UIScreen mainScreen] bounds].size.height == 480.0)
#define IPHONE5                 ([[UIScreen mainScreen] bounds].size.height == 568.0)
#define IPHONE6                 ([[UIScreen mainScreen] bounds].size.height == 667.0)
#define IPHONE6Plus             ([[UIScreen mainScreen] bounds].size.height == 736.0)

#define IOSDEVICE [[[UIDevice currentDevice] systemVersion] floatValue]

//-------------------- appSize --------------------
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
//是否为iOS8及以上系统
#define iOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)
//是否为iOS9及以上系统
#define iOS9 ([[UIDevice currentDevice].systemVersion doubleValue] >= 9.0)
//window
#define WINDOW  [[UIApplication sharedApplication].delegate window]

#define IPHONE8X   ([[UIScreen mainScreen] bounds].size.height == 812.0)

#define TopH (IPHONE8X?88:64)

#define DownH (IPHONE8X?83:49)

//-----------------image cache------------
#define CACHE_DIR @"cacheImage"

//----------------- colors -----------------
#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define ColorEarth [UIColor colorWithRed:137.0f/255.0f green:62.0f/255.0f blue:32.0f/255.0f alpha:1]
#define ColorLine [UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1]
#define ColorMainBG [UIColor colorWithRed:73.0f/255.0f green:214.0f/255.0f blue:192.0f/255.0f alpha:1]

#define btnTitle_COLOR [UIColor getColorWithHexString:@"#333333"]// 按钮标题颜色
#define Common_topBackgroundColor RGB(114,208,126)
#define Common_downTabbarTitleColor RGB(7,196,147)

#define RGBColor(r,g,b)    RGBA(r,g,b,1)

/**
 *  主背景色调
 */
#define MAIN_BGCOLOR   [UIColor getColorWithHexString:@"f9f9f9"]
#define LIGHTCOLOR [UIColor getColorWithHexString:@"#999999"]

//------------------- font Family Name ------------
#define FONTWITHFZHT(F) [UIFont fontWithName:@"FZHTJW--GB1-0" size:F]
#define FONTWITHSTHT(F) [UIFont fontWithName:@"STHeitiSC" size:F]
#define FONTWITHSTHT_M(F) [UIFont fontWithName:@"STHeitiSC-Medium" size:F]
#define FONTWITHSTHT_L(F) [UIFont fontWithName:@"STHeitiSC-Light" size:F]
#define FONTWITHARIAL(F) [UIFont fontWithName:@"Arial" size:F]

// 细体
#define FONT_11				FontS(FONTSIZE11)
#define FONT_14				FontS(FONTSIZE14)
#define FONT_16				FontS(FONTSIZE16)
#define FONT_18				FontS(FONTSIZE18)
#define FONT_20				FontS(FONTSIZE20)

// 粗体字
#define FONT_B11				FontB(FONTSIZE11)
#define FONT_B14				FontB(FONTSIZE14)
#define FONT_B16				FontB(FONTSIZE16)
#define FONT_B18				FontB(FONTSIZE18)
#define FONT_B20				FontB(FONTSIZE20)

#define FontS(size)             [UIFont systemFontOfSize:size]
#define FontB(size)             [UIFont boldSystemFontOfSize:size]

//------------------- set Frame ------------
#define FRM(x,y,w,h) CGRectMake(x, y, w, h)
#define Plus (IPHONE6Plus?1.5:1)
#define SCREENBILI  (SCREEN_WIDTH/375.)
#define Screen_bounds ([UIScreen mainScreen].bounds)
// app版本号
#define APPVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#pragma mark 网络请求头部
#define ApiVersion @"1.0.0"
#define Channel @"ios"
#define Version @"1.0.0"
#define AppName @"130" //无用的code----
#define AppCode @"YMZX" //DXSDK  JSXQ
#define BaiduTongJiKey @"22529f1c88"
#define Poatform @"2" // 1：小丫  2：前海
#define NewHTML @"2" //1：老版   2：新版1.0

#define LXKFPhone @"18639412412"

#define KeFuPhone @"KeFuPhone"//保存的客服电话

#pragma mark 3des加密
#define DESKEY @"YAYA_FINANCIAL_BANK_APP@2015"

#define IPHONEX           ([[UIScreen mainScreen] bounds].size.height == 812.0)
#define SafeAreaTopHeight (SCREEN_HEIGHT == 812.0 ? 88 : 64)

// 系统类型 2 android 1 ios
#define OS_Type @"1"
// 操作系统版本
#define OS_Version [UIDevice currentDevice].systemVersion

#define SYSTEM_VERSION [NSString stringWithFormat:@"IOS%@",OS_Version]

#define DefUUID                [[UIDevice currentDevice].identifierForVendor UUIDString]

#define NETWORK_ERRORMESSAGE @"您可能未连接网络，或者网络状态不佳，请确认网络状态后重试。谢谢！"

#define Comecaode @"Comecaode"//是否aw_shen001he

#define HomeEmpty @"isGrab"//是否放空

#define HomeEmptyUrl @"company"//放空后地址

#define MasterTabar @"MasterTabar"//大师板块

#define BlessingTabar @"BlessingTabar"//祈福转运

#define Star_ChooseName @"Star_ChooseName"//选择星座名字

#define Star_ChooseCode @"Star_ChooseCode"//选择星座代码

#import "BaseImageView.h"

#import "UIColor+ColorChange.h"

#import "NSString+AWStringTool.h"

#import "YYModel.h"

#import "DANewUserInfo.h"

#import "UILabel+LXAdd.h"

#import "AWBaseTableViewCell.h"

#define WS(weakSelf) __weak __typeof(&*self)weakSelf = self

#define CG_HEIGHT(v) v.frame.size.height
#define CG_WIDTH(v)  v.frame.size.width
#define CG_PX(v)     v.frame.origin.x
#define CG_PY(v)     v.frame.origin.y

#define AWStrong(class,name)    @property (nonatomic,strong) class *name
#define AWCopy(class,name)    @property (nonatomic,copy) class *name
#define AWAssign(class,name)    @property (nonatomic,assign) class name

#ifdef DEBUG
#define NSLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define NSLog(...)
#endif

#endif /* Header_h */
