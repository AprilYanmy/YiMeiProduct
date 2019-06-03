//
//  URLRequest.h
//  MakeTea
//
//  Created by cy on 16/11/30.
//  Copyright © 2016年 cy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLRequest : NSObject

///首页 ---TEST
+(NSString *)url_homeTest;

///首页
+(NSString *)url_home;

///首页aw_shen001he判断
+(NSString *)url_homeComecaode;

///首页xinyong-----kcar--d--123
+(NSString *)url_getCreditList;

///获取验证码
+(NSString *)url_getVerCode;

///注册
+(NSString *)url_register;

///登录
+(NSString *)url_login;

///重置密码
+(NSString *)url_resetPwd;

///设置密码
+(NSString *)url_setPwd;

///打印密码修改日志
+(NSString *)url_pwdLogo;

///获取用户信息
+(NSString *)url_getUserInfo;

///保存用户信息
+(NSString *)url_saveUserInfo;

//完善用户信息
+(NSString *)url_perfectUser;

///广告
+(NSString *)url_getBannerList;

/**插入咨询广告*/
+(NSString *)url_getAdList;

///滚动广告
+(NSString *)url_getRollMessage;

///上传图片
+(NSString *)url_uploadAppFile;

///消息列表
+(NSString *)url_getNewsList;

/** 商品展示列表*/
+(NSString *)url_aw_showProductList;

///活动列表
+(NSString *)url_huodongList;

///新活动列表
+(NSString *)url_newHuodongList;

///完善资料
+(NSString *)url_registerOrUpdate;

///图片地址
+(NSString *)url_imgUrl:(NSString *)imgeStr;

///html
+(NSString *)url_html:(NSString *)htmlStr;

///活动html
+(NSString *)url_htmlHuodong;

///新活动详情
+(NSString *)url_newHuodongDesc;

//获取首页图片
+(NSString *)url_button;

/** 新版消息中心 */
+(NSString *)aw___getMessageList;

/** 新版广告 */
+(NSString *)getAdList;

/**
 联系客服
 appcode 产品代码
 type     引用位置 ： 1.注册页客服 2.个人中心客服
 
 */
+(NSString *)getToolsServices;


/**
 咨询板块  ---- 6大板块  29~34
 */
+(NSString *)czw_getHomeDiaryList;


/**
 首页板块
 */
+(NSString *)czw_getHomeNewsList;

/**
 机构列表数据
 appcode  产品代码
 page     页数 ++ 默认为1
 city_py  城市拼音
 注：目前只有5个城市
 1.    chongqing  重庆
 2.    shanghai   上海
 3.    beijing    北京
 4.    hangzhou   杭州
 5.    wuhan      武汉）
 
 */
+(NSString *)czw___getHostDataSourceList;

/**
 机构列表数据
 appcode         产品代码
 hospital_id     医院id
 */
+(NSString *)czw___getHostDataSourceDetail;

/**
 首页详情页接口
 appcode     产品代码
 product_id  商品id
 */
+(NSString *)czw___getHomeNewsDetail;

//排行版列表
+(NSString *)aw___url_getHomeRankList;

/** 历史列表
 appcode  ICO     代码
 ico_name bitcoin 币种名称
 */
+(NSString *)aw___url_getHomeHostilyListIco_name:(NSString *)ico_name;

@end
