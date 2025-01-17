//
//  ZHPickView.m
//  ZHpickView
//
//  Created by liudianling on 14-11-18.
//  Copyright (c) 2014年 赵恒志. All rights reserved.
//
#define ZHToobarHeight 40
#define ZHBackViewHeight 250
#import "ZHPickView.h"

@interface ZHPickView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,copy)NSString *plistName;
@property(nonatomic,strong)NSArray *plistArray;
@property(nonatomic,assign)BOOL isLevelArray;
@property(nonatomic,assign)BOOL isLevelString;
@property(nonatomic,assign)BOOL isLevelDic;
@property(nonatomic,strong)NSMutableDictionary *levelTwoDic;
//自己添加第三层dic
@property(nonatomic,strong)NSMutableDictionary *levelThreeDic;
@property(nonatomic,strong)UIToolbar *toolbar;
@property(nonatomic,strong)UIPickerView *pickerView;
@property(nonatomic,strong)UIDatePicker *datePicker;
@property(nonatomic,assign)NSDate *defaulDate;
@property(nonatomic,assign)BOOL isHaveNavControler;
@property(nonatomic,copy)NSString *resultString;
@property(nonatomic,strong)NSMutableArray *componentArray;
@property(nonatomic,strong)NSMutableArray *dicKeyArray;
@property(nonatomic,strong)UIView *backView;
@property(nonatomic,copy)NSMutableArray *state;
@property(nonatomic,copy)NSMutableArray *city;
@property(nonatomic,copy)NSMutableArray *area;
@end

@implementation ZHPickView

-(NSArray *)plistArray{
    if (_plistArray==nil) {
        _plistArray=[[NSArray alloc] init];
    }
    return _plistArray;
}

-(NSArray *)componentArray{

    if (_componentArray==nil) {
        _componentArray=[[NSMutableArray alloc] init];
    }
    return _componentArray;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _levelTwoDic=[NSMutableDictionary dictionaryWithCapacity:0];
        _levelThreeDic=[NSMutableDictionary dictionaryWithCapacity:0];
    }
    return self;
}


-(instancetype)initPickviewWithPlistName:(NSString *)plistName isHaveNavControler:(BOOL)isHaveNavControler{
    
    self=[super init];
    if (self) {
        _plistName=plistName;
        self.plistArray=[self getPlistArrayByplistName:plistName];
        [self setBackGroundView:isHaveNavControler];
        [self setUpPickView];
        [self setUpToolBar];
        [self setFrameWith:isHaveNavControler];
        
    }
    return self;
}
-(instancetype)initPickviewWithArray:(NSArray *)array isHaveNavControler:(BOOL)isHaveNavControler{
    self=[super init];
    if (self) {
        self.plistArray=array;
        [self setArrayClass:array];
        [self setBackGroundView:isHaveNavControler];
        [self setUpPickView];
        [self setUpToolBar];
        [self setFrameWith:isHaveNavControler];
    }
    return self;
}

-(instancetype)initDatePickWithDate:(NSDate *)defaulDate datePickerMode:(UIDatePickerMode)datePickerMode isHaveNavControler:(BOOL)isHaveNavControler{
    
    self=[super init];
    if (self) {
        _defaulDate=defaulDate;
        [self setUpDatePickerWithdatePickerMode:(UIDatePickerMode)datePickerMode];
        [self setFrameWith:isHaveNavControler];
    }
    return self;
}


-(NSArray *)getPlistArrayByplistName:(NSString *)plistName{
    
    NSString *path= [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    NSArray * array=[[NSArray alloc] initWithContentsOfFile:path];
    [self setArrayClass:array];
    return array;
}

-(void)setArrayClass:(NSArray *)array{
    _dicKeyArray=[[NSMutableArray alloc] init];
    for (id levelTwo in array) {
        
        if ([levelTwo isKindOfClass:[NSArray class]]) {
            _isLevelArray=YES;
            _isLevelString=NO;
            _isLevelDic=NO;
        }else if ([levelTwo isKindOfClass:[NSString class]]){
            _isLevelString=YES;
            _isLevelArray=NO;
            _isLevelDic=NO;
            
        }else if ([levelTwo isKindOfClass:[NSDictionary class]])
        {
            _isLevelDic=YES;
            _isLevelString=NO;
            _isLevelArray=NO;
            //_levelTwoDic=[levelTwo objectForKey:@"cities"];
            _levelTwoDic=levelTwo;
             //[_dicKeyArray addObject:[_levelTwoDic allKeys] ];
//            /*修改的数据源*/
//            NSArray *cityArray=[levelTwo objectForKey:@"cities"];
//            NSString *cityName=[levelTwo objectForKey:@"state"];
//            [_levelTwoDic setValue:cityArray forKey:cityName];
//           // NSLog(@"%@",cityArray);
//            for (NSDictionary *levelThree in cityArray) {
//              
//                NSArray *areaArray=[levelThree objectForKey:@"city"];
//                NSString *areaName=[levelThree objectForKey:@"areas"];
//                [_levelThreeDic setValue:areaArray forKey:areaName];
//               
//            }
             [_dicKeyArray addObject:[_levelTwoDic allKeys] ];
        //   NSLog(@"%@",_dicKeyArray)
        }
    }
}

-(void)setFrameWith:(BOOL)isHaveNavControler{
    
    CGFloat toolViewH = ZHBackViewHeight+ZHToobarHeight;
    CGFloat toolViewY ;
    CGFloat viewH;
    if (isHaveNavControler) {
        toolViewY= [UIScreen mainScreen].bounds.size.height-toolViewH-50;
        viewH = SCREEN_HEIGHT-50;
    }else {
        toolViewY= [UIScreen mainScreen].bounds.size.height-toolViewH;
        viewH = SCREEN_HEIGHT;
    }
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, viewH);
    self.backgroundColor = RGBA(51, 51, 51, 0.2);
    
}

- (void)setBackGroundView:(BOOL)isHaveNavControler{
    CGFloat toolViewX = 0;
    CGFloat toolViewH = ZHBackViewHeight+ZHToobarHeight;
    CGFloat toolViewY ;
    
    if (isHaveNavControler) {
        toolViewY= [UIScreen mainScreen].bounds.size.height-toolViewH;
    }else {
        toolViewY= [UIScreen mainScreen].bounds.size.height-toolViewH+50;
    }
    
    UIView *view = [[UIView alloc] init];
    
    _backView = view;
    view.frame = CGRectMake(toolViewX, toolViewY, SCREEN_WIDTH, toolViewH);
    [self addSubview:view];
}

-(void)setUpPickView{
    
    UIPickerView *pickView=[[UIPickerView alloc] init];
    pickView.backgroundColor=[UIColor whiteColor];
    _pickerView=pickView;
    pickView.delegate=self;
    pickView.dataSource=self;
    pickView.frame=CGRectMake(0, ZHToobarHeight, SCREEN_WIDTH, ZHBackViewHeight-ZHToobarHeight);
    [self.backView addSubview:pickView];
}

-(void)setUpDatePickerWithdatePickerMode:(UIDatePickerMode)datePickerMode{
    UIDatePicker *datePicker=[[UIDatePicker alloc] init];
    datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    datePicker.datePickerMode = datePickerMode;
    datePicker.backgroundColor=[UIColor lightGrayColor];
    if (_defaulDate) {
        [datePicker setDate:_defaulDate];
    }
    _datePicker=datePicker;
    datePicker.frame=CGRectMake(0, ZHToobarHeight, SCREEN_WIDTH, ZHBackViewHeight-ZHToobarHeight);
    [self.backView addSubview:datePicker];
}

-(void)setUpToolBar{
    _toolbar = [self setToolbarStyle];
    [self setToolbarWithPickViewFrame];
    [self.backView addSubview:_toolbar];
}
-(UIToolbar *)setToolbarStyle{
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    UIBarButtonItem *lefttem = [[UIBarButtonItem alloc] initWithTitle:@"    取消" style:UIBarButtonItemStylePlain target:self action:@selector(remove)];
    [lefttem setTintColor:ColorMainBG];
    
    UIBarButtonItem *centerSpace=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"确定    " style:UIBarButtonItemStylePlain target:self action:@selector(toolDoneClick)];
    [right setTintColor:ColorMainBG];
    
    toolbar.items=@[lefttem,centerSpace,right];
    return toolbar;
}
-(void)setToolbarWithPickViewFrame{
    _toolbar.frame = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, ZHToobarHeight);
}

#pragma mark piackView 数据源方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    NSInteger component;
    if (_isLevelArray) {
        component=_plistArray.count;
    } else if (_isLevelString){
        component=1;
    }else {
        component=[_levelTwoDic allKeys].count*2;
    }
    return component;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSArray *rowArray=[[NSArray alloc] init];
    if (_isLevelArray) {
        rowArray=_plistArray[component];
    }else if (_isLevelString){
        rowArray=_plistArray;
    }else if (_isLevelDic){
        NSInteger pIndex = [pickerView selectedRowInComponent:0];
        NSDictionary *dic=_plistArray[pIndex];
        for (id dicValue in [dic allValues]) {
                if ([dicValue isKindOfClass:[NSArray class]]) {
                    if (component%2==1) {
                        rowArray=dicValue;
                    }else{
                        rowArray=_plistArray;
                    }
            }
        }
    }
    return rowArray.count;
}

#pragma mark UIPickerViewdelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *rowTitle=nil;
    if (_isLevelArray) {
        rowTitle=_plistArray[component][row];
    }else if (_isLevelString){
        rowTitle=_plistArray[row];
    }else if (_isLevelDic){
        NSInteger pIndex = [pickerView selectedRowInComponent:0];
        NSDictionary *dic=_plistArray[pIndex];
        if(component%2==0)
        {
            rowTitle=_dicKeyArray[row][component];
        }
        for (id aa in [dic allValues]) {
           if ([aa isKindOfClass:[NSArray class]]&&component%2==1){
                NSArray *bb=aa;
                if (bb.count>row) {
                    rowTitle=aa[row];
                }
                
            }
        }
    }
    return rowTitle;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (_isLevelDic&&component%2==0) {
        
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
    if (_isLevelString) {
        _resultString=_plistArray[row];
        
    }else if (_isLevelArray){
        _resultString=@"";
        if (![self.componentArray containsObject:@(component)]) {
            [self.componentArray addObject:@(component)];
        }
        for (int i=0; i<_plistArray.count;i++) {
            if ([self.componentArray containsObject:@(i)]) {
                NSInteger cIndex = [pickerView selectedRowInComponent:i];
                _resultString=[NSString stringWithFormat:@"%@ %@",_resultString,_plistArray[i][cIndex]];
            }else{
                _resultString=[NSString stringWithFormat:@"%@ %@",_resultString,_plistArray[i][0]];
                          }
        }
    }else if (_isLevelDic){
        if (component==0) {
          _state =_dicKeyArray[row][0];
        }else{
            NSInteger cIndex = [pickerView selectedRowInComponent:0];
            NSDictionary *dicValueDic=_plistArray[cIndex];
            NSArray *dicValueArray=[dicValueDic allValues][0];
            if (dicValueArray.count>row) {
                _city =dicValueArray[row];
            }
        }
    }
    
//    if ([self.delegate respondsToSelector:@selector(toobarDonBtnHaveClick:resultString:)]) {
//        [self.delegate toobarDonBtnHaveClick:self resultString:_resultString];
//    }

}

-(void)remove{
    
    [self removeFromSuperview];
}
-(void)show{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
}
-(void)toolDoneClick
{
    if (_pickerView) {
        
        if (_resultString) {
           
        }else{
            if (_isLevelString) {
                _resultString=[NSString stringWithFormat:@"%@",_plistArray[0]];
            }else if (_isLevelArray){
                _resultString=@"";
                for (int i=0; i<_plistArray.count;i++) {
                    _resultString=[NSString stringWithFormat:@"%@%@",_resultString,_plistArray[i][0]];
                }
            }else if (_isLevelDic){
                
                if (_state==nil) {
                     _state =_dicKeyArray[0][0];
                    NSDictionary *dicValueDic=_plistArray[0];
                    _city=[dicValueDic allValues][0][0];
                }
                if (_city==nil){
                    NSInteger cIndex = [_pickerView selectedRowInComponent:0];
                    NSDictionary *dicValueDic=_plistArray[cIndex];
                    _city=[dicValueDic allValues][0][0];
                    
                }
              _resultString=[NSString stringWithFormat:@"%@%@",_state,_city];
           }
        }
    }else if (_datePicker) {
      
        _resultString=[NSString stringWithFormat:@"%@",_datePicker.date];
    }
    if ([self.delegate respondsToSelector:@selector(toobarDonBtnHaveClick:resultString:)]) {
        [self.delegate toobarDonBtnHaveClick:self resultString:_resultString];
    }
    
    [self removeFromSuperview];
}
/**
 *  设置PickView的颜色
 */

-(void)setPickViewColer:(UIColor *)color{
    _pickerView.backgroundColor=color;
}

/**
 *  设置toobar的文字颜色
 */
-(void)setTintColor:(UIColor *)color{
    
    _toolbar.tintColor=color;
}
/**
 *  设置toobar的背景颜色
 */
-(void)setToolbarTintColor:(UIColor *)color{
    
    _toolbar.barTintColor=color;
}
-(void)dealloc{
    
    //NSLog(@"销毁了");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self remove];
}

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
