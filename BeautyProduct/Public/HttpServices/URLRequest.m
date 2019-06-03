//
//  URLRequest.m
//  MakeTea
//
//  Created by cy on 16/11/30.
//  Copyright © 2016年 cy. All rights reserved.
//

#import "URLRequest.h"

#define APP_BASE_URL @"https://capital.fydnc.com/capital"//线上环境

#define APP_NewPeizi_Home_URL @"https://set.ifangbianmian.com/beauty"//医美api接口

#define APP_NewML_URL @"https://set.ifangbianmian.com/suanming"

@implementation URLRequest

///首页 ---TEST
+(NSString *)url_homeTest{
    NSString *url=[NSString stringWithFormat:@"%@/i/banner/getBannerTestReturnOK",APP_BASE_URL];
    return url;
}

///首页
+(NSString *)url_home{
    NSString *url=[NSString stringWithFormat:@"%@/i/homepageAPI/homepage",APP_BASE_URL];
    return url;
}


///首页aw_shen001he判断
+(NSString *)url_homeComecaode{
    NSString *url=[NSString stringWithFormat:@"%@/i/homepageAPI/appDetail",APP_BASE_URL];
    return url;
}

///首页信用卡
+(NSString *)url_getCreditList{
    NSString *url=[NSString stringWithFormat:@"%@/i/banner/getCreditList",APP_BASE_URL];
    return url;
}

///信用卡列表
+(NSString *)url_creditHomepage{
    NSString *url=[NSString stringWithFormat:@"%@/i/credit/homepage",APP_BASE_URL];
    return url;
}


///攻略列表
+(NSString *)url_gonglue{
    NSString *url=[NSString stringWithFormat:@"%@/i/raider/speedRaidersList",APP_BASE_URL];
    return url;
}

///获取验证码
+(NSString *)url_getVerCode{
    NSString *url=[NSString stringWithFormat:@"%@/i/message/getVerCode",APP_BASE_URL];
    return url;
}


///注册
+(NSString *)url_register{
    NSString *url=[NSString stringWithFormat:@"%@/i/user/register",APP_BASE_URL];
    return url;
}

///登录
+(NSString *)url_login{
    NSString *url=[NSString stringWithFormat:@"%@/i/user/login",APP_BASE_URL];
    return url;
}

///重置密码
+(NSString *)url_resetPwd{
    NSString *url=[NSString stringWithFormat:@"%@/i/user/resetPwd",APP_BASE_URL];
    return url;
}

///设置密码
+(NSString *)url_setPwd{
    NSString *url=[NSString stringWithFormat:@"%@/i/user/setPwd",APP_BASE_URL];
    return url;
}

///打印密码修改日志
+(NSString *)url_pwdLogo{
    NSString *url=[NSString stringWithFormat:@"%@/i/user/pwdLogo",APP_BASE_URL];
    return url;
}

///获取用户信息
+(NSString *)url_getUserInfo{
    NSString *url=[NSString stringWithFormat:@"%@/i/user/getUserInfo",APP_BASE_URL];
    return url;
}

///保存用户信息
+(NSString *)url_saveUserInfo{
    NSString *url=[NSString stringWithFormat:@"%@/i/user/saveUserInfo",APP_BASE_URL];
    return url;
}


+(NSString *)url_perfectUser{
    NSString *url=[NSString stringWithFormat:@"%@/i/user/perfectUser",APP_BASE_URL];
    return url;
}

///广告
+(NSString *)url_getBannerList{
    NSString *url=[NSString stringWithFormat:@"%@/i/banner/getBannerList",APP_BASE_URL];
    return url;
}

/**插入咨询广告*/
+(NSString *)url_getAdList{
    NSString *url=[NSString stringWithFormat:@"%@/i/ad/getAdList",APP_BASE_URL];
    return url;
}

///滚动广告
+(NSString *)url_getRollMessage{
    NSString *url=[NSString stringWithFormat:@"%@/i/banner/getRollMessage",APP_BASE_URL];
    return url;
}

///商品展示列表
+(NSString *)url_aw_showProductList{
    NSString *url=[NSString stringWithFormat:@"%@/i/loan/getLoanList",APP_BASE_URL];
    return url;
}

///活动列表
+(NSString *)url_huodongList{
    NSString *url=[NSString stringWithFormat:@"%@/i/activity/hotEventList",APP_BASE_URL];
    return url;
}

///新活动列表
+(NSString *)url_newHuodongList{
    NSString *url=[NSString stringWithFormat:@"%@/i/activity/getActivity",APP_BASE_URL];
    return url;
}

///上传图片
+(NSString *)url_uploadAppFile{
    NSString *url=[NSString stringWithFormat:@"%@/i/file/uploadAppFile",APP_BASE_URL];
    return url;
}


///消息列表
+(NSString *)url_getNewsList{
    NSString *url=[NSString stringWithFormat:@"%@/i/message/getNewsList",APP_BASE_URL];
    return url;
}

///完善资料
+(NSString *)url_registerOrUpdate{
    NSString *url=[NSString stringWithFormat:@"%@/i/user/registerOrUpdate",APP_BASE_URL];
    return url;
}

///图片地址
+(NSString *)url_imgUrl:(NSString *)imgeStr{
    NSString *url=[NSString stringWithFormat:@"%@/file/downloadUrl?onLine=true&id=%@",APP_BASE_URL,imgeStr];
    return url;
}

///html
+(NSString *)url_html:(NSString *)htmlStr{
    NSString *url=[NSString stringWithFormat:@"%@/i/html5/%@",APP_BASE_URL,htmlStr];
    return url;
}

///活动html
+(NSString *)url_htmlHuodong{
    NSString *url=[NSString stringWithFormat:@"%@/i/material/productActivityDetail",APP_BASE_URL];
    return url;
}


///新活动详情
+(NSString *)url_newHuodongDesc{
    NSString *url=[NSString stringWithFormat:@"%@/i/html5/newActivityDetail",APP_BASE_URL];
    return url;
}


//获取首页图片
+(NSString *)url_button{
    NSString *url=[NSString stringWithFormat:@"%@/i/life/getTypeList",APP_BASE_URL];
    return url;
}

//广告
+(NSString *)getAdList{
    NSString *url=[NSString stringWithFormat:@"%@/i/ad/getAdList",APP_BASE_URL];
    return url;
}

//新版消息中心
+(NSString *)aw___getMessageList{
    NSString *url = [NSString stringWithFormat:@"%@/i/push/getPushList",APP_BASE_URL];
    return url;
}

//意见反馈
+(NSString *)setUserFeedback{
    NSString *url=[NSString stringWithFormat:@"http://xz.qjlm.com/e/enews/index.php"];
    return url;
}

//咨询板块
+(NSString *)czw_getHomeDiaryList{
    NSString *url=[NSString stringWithFormat:@"%@/daily/daily_list.php",APP_NewPeizi_Home_URL];
    return url;
}

//首页咨询板块
+(NSString *)czw_getHomeNewsList{
    NSString *url = [NSString stringWithFormat:@"%@/product/product_list.php",APP_NewPeizi_Home_URL];
    return url;
}

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
+(NSString *)czw___getHostDataSourceList{
    NSString *url = [NSString stringWithFormat:@"%@/hospital/hospital_list.php",APP_NewPeizi_Home_URL];
    return url;
}

/**
 机构列表数据
 appcode         产品代码
 hospital_id     医院id
 */
+(NSString *)czw___getHostDataSourceDetail{
    NSString *url = [NSString stringWithFormat:@"%@/hospital/hospital_detail.php",APP_NewPeizi_Home_URL];
    return url;
}

//首页详情页接口
+(NSString *)czw___getHomeNewsDetail{
    NSString *url = [NSString stringWithFormat:@"%@/product/product_detail.php",APP_NewPeizi_Home_URL];
    return url;
}

/**   联系客服 */
+(NSString *)getToolsServices{
    NSString *url = [NSString stringWithFormat:@"%@/tools/menu.php",APP_NewML_URL];
    return url;
}

//排行版列表
+(NSString *)aw___url_getHomeRankList{
    
    NSString *url = [NSString stringWithFormat:@"%@/quotes/index.php",APP_NewPeizi_Home_URL];
    return url;
}

/** 历史列表
    appcode  ICO     代码
    ico_name bitcoin 币种名称
 */
+(NSString *)aw___url_getHomeHostilyListIco_name:(NSString *)ico_name{
    
    NSString *url = [NSString stringWithFormat:@"%@/market/index.php?appcode=ICO&ico_name=%@&appcode=%@",APP_NewPeizi_Home_URL,ico_name,AppCode];
    return url;
}

@end
