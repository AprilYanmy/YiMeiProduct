//
//  DANewHostChooseView.m
//  BeautyProduct
//
//  Created by iMac-1 on 2018/9/4.
//  Copyright © 2018年 iOS_阿玮. All rights reserved.
//

#import "DANewHostChooseView.h"

@interface DANewHostChooseView () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *showTableView;

@property (nonatomic,copy) void(^completion1)(NSString *chooseStr);
@property (nonatomic,copy) void(^completion)(NSString *chooseStr,NSInteger type);

@end

@implementation DANewHostChooseView

+ (instancetype)creatViewTitleArrs:(NSArray *)arr
               chooseBlock:(void(^)(NSString *chooseStr))completion{
    
    DANewHostChooseView *chooseView = [[DANewHostChooseView alloc] initWithFrame:CGRectMake(0, TopH+41, SCREEN_WIDTH, SCREEN_HEIGHT-41-TopH)
                                                                        withArrs:arr];
    chooseView.completion1 = completion;
    
    //如果已经展示了 移除当前展示内容
    UIWindow *windows = [UIApplication sharedApplication].keyWindow;
    [windows addSubview:chooseView];
    return chooseView;
    
}

+ (instancetype)creatViewChooseBlock:(void(^)(NSString *chooseStr,NSInteger type))completion{
    
    DANewHostChooseView *chooseView = [[DANewHostChooseView alloc] initWithFrame:CGRectMake(0, TopH+41, SCREEN_WIDTH, 0)];
    
    chooseView.completion = completion;
    chooseView.alpha = 0;
    //如果已经展示了 移除当前展示内容
    UIWindow *windows = [UIApplication sharedApplication].keyWindow;
    [windows addSubview:chooseView];
    
    return chooseView;
    
}

- (instancetype)initWithFrame:(CGRect)frame withArrs:(NSArray *)titleArrs{
    
    self = [self initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6f];
        _titleArrs = titleArrs;
        [self creatUI];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6f];
//        _titleArrs = titleArrs;
        [self creatUI];
    }
    
    return self;
}

- (void)creatUI{
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    [self addSubview:lineView];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0.5, SCREEN_WIDTH, 0)
                                                          style:0];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.rowHeight = 35;
    tableView.dataSource = self;
    tableView.delegate = self;
    [self addSubview:tableView];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.233];
    [UIView setAnimationCurve:(UIViewAnimationCurveLinear)];
    tableView.frame = CGRectMake(0, 0.5, SCREEN_WIDTH, 35*5);
    [UIView commitAnimations];
    
    self.showTableView = tableView;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _titleArrs.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault)
                                      reuseIdentifier:@"UITableViewCell"];
        cell.textLabel.frame = CGRectMake(0, 0, SCREEN_WIDTH, 35);
//        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = FontS(15);
        cell.textLabel.textColor = [UIColor colorWithHexString:@"666666"];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 34, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
        [cell.contentView addSubview:line];
    }
    cell.textLabel.text = _titleArrs[indexPath.row];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.completion) {
        self.completion(_titleArrs[indexPath.row],_showOpenType);
        [self closeView];
    }
    
}

- (void)openView:(NSInteger)type{
    
    _showOpenType = type;
    self.alpha = 1;
    self.frame = CGRectMake(0, self.y, self.width, SCREEN_HEIGHT-41-TopH);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.233];
    [UIView setAnimationCurve:(UIViewAnimationCurveLinear)];
    self.showTableView.frame = CGRectMake(0, 0.5, SCREEN_WIDTH, 35*5);
    [UIView commitAnimations];
 
    self.isOpenView = YES;
    
}

- (void)closeView{
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.233];
    [UIView setAnimationCurve:(UIViewAnimationCurveLinear)];
    self.showTableView.frame = CGRectMake(0, 0.5, SCREEN_WIDTH, 0*5);
    [UIView commitAnimations];
    self.alpha = 0.5;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.344 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.frame = CGRectMake(0, self.y, self.width, 0);
        self.alpha = 0;
    });
    
//    self.isOpenView = NO;
    
//    self.showOpenType = 0;
    
}

- (void)setTitleArrs:(NSArray *)titleArrs{
    
    _titleArrs = titleArrs;
    
    [self.showTableView reloadData];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self closeView];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
