//
//  AFNRequestManager.h
//  Czw_Afn
//
//  Created by iOS_czw on 2017/1/10.
//  Copyright © 2017年 iOS_czw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFNRequestManager : NSObject

//定义枚举类型
typedef enum {
    AWPost_request = 0,//post请求
    AWGet_request = 1,//get请求
    AWPut_request = 2,//put请求
    AWDelete_request = 3, //delete请求
    AWUpload_onlyPhoto //上传用户头像
} AWRequestType;

/**
 *  发起网络请求
 *
 *  @param method      请求方法
 *  @param url         请求url
 *  @param requestData 请求data数据
 *  @param completion 完成的回调
 *
 */
+(void)__request:(AWRequestType)method urlstr:(NSString *)url requestData:(id)requestData completion:(void(^)(id responseObject, NSError *error))completion;

#pragma mark -- 单张图片上传图片

/**
 单张图片上传图片
 @param upload_Url 上传图片地址
 @param photoName 图片的名字
 @param pic_data 将图片转换成二进制
  @param requestData post 上传的参数
 @param block 返回上传的结果
 */
+(void)upload__UserPhotoWithUrl:(NSString *)upload_Url withUploadPhoto:(NSString *)photoName andPicData:(NSData *)pic_data requestData:(id)requestData withBlock:(void(^)(id sucuess,NSError *error))block;


#pragma mark -- 多张上传图片
/**
 多张图片上传

 @param upload_Url 上传图片的Url
 @param requestData 上传图片的参数
 @param photoName 上传类型的名称
 @param pic_array 上传多张的 NSData 数组
 @param block 返回上传的结果
 */
+(void)upload_More_photoWithUrl:(NSString *)upload_Url requestData:(id)requestData withUploadPhoto:(NSString *)photoName andPicData:(NSMutableArray *)pic_array WithBlock:(void(^)(id sucuess,NSError *error))block;

@end
