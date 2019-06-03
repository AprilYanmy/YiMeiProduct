//
//  DateTimePickerView.h
//  CXB
//
//  Created by Tanyfi on 17/6/15.
//  Copyright © 2017年 Tanyfi. All rights reserved.
//


#import <UIKit/UIKit.h>

@class DateTimePickerView;

typedef enum : NSUInteger {
    DatePickerViewDateTimeMode,//年月日,时分
    DatePickerViewDateMode,//年月日
    DatePickerViewTimeMode//时分
} DatePickerViewMode;

@protocol DateTimePickerViewDelegate <NSObject>
@optional
/**
 * 确定按钮
 */
-(void)aw____dateTimePickerView:(DateTimePickerView *)pirckerView didClickFinishDateTimePickerView:(NSString*)date;
/**
 * 取消按钮
 */
-(void)didClickCancelDateTimePickerView;

@end


@interface DateTimePickerView : UIView


/**
 创建时间选择视图
 */
+ (instancetype)creatView;

/**
 * 设置当前时间
 */
@property(nonatomic, strong)NSDate*currentDate;
/**
 * 设置中心标题文字
 */
@property(nonatomic, strong)UILabel *titleL;

/**
 * 设置分割符号,默认符号 - 
 */
@property(nonatomic, copy)NSString *symbolsStr;


@property(nonatomic, strong)id<DateTimePickerViewDelegate>delegate;
/**
 * 模式
 */
@property (nonatomic, assign) DatePickerViewMode pickerViewMode;


/**
 * 掩藏
 */
- (void)hideDateTimePickerView;
/**
 * 显示
 */
- (void)showDateTimePickerView;


@end

