//
//  DANewHostChooseView.h
//  BeautyProduct
//
//  Created by iMac-1 on 2018/9/4.
//  Copyright © 2018年 iOS_阿玮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DANewHostChooseView : UIView

/**
 创建选择的列表
 + (void)creatViewTitleArrs:(NSArray *)arr
 chooseBlock:(void(^)(NSString *chooseStr))completion;
 @param arr 选择的数组内容
 @param completion 回调参数
 */

+ (instancetype)creatViewTitleArrs:(NSArray *)arr
                       chooseBlock:(void(^)(NSString *chooseStr))completion;

+ (instancetype)creatViewChooseBlock:(void(^)(NSString *chooseStr,NSInteger type))completion;

@property (nonatomic,copy) NSArray *titleArrs;

@property (nonatomic,assign) BOOL isOpenView;

@property (nonatomic,assign) NSInteger showOpenType;



/**
 打开当前界面
 */
- (void)openView:(NSInteger)type;

/**
 关闭当前界面
 */
- (void)closeView;

@end
