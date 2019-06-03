//
//  CustomTableView.m
//  SwipeTableView
//
//  Created by Roy lee on 16/4/1.
//  Copyright © 2016年 Roy lee. All rights reserved.
//

#import "CustomTableView.h"
#import "UIView+STFrame.h"
#import "SwipeTableView.h"
#import "DANewDiaryCell.h"
#import "MTWebViewVC.h"
#import "WELoginVC.h"

@interface CustomTableView ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger _pageNum;
    NSInteger _lastIndex;
    BOOL _isNoMoreData;
}
@property (nonatomic, assign) NSInteger itemIndex;
@property (nonatomic, assign) NSInteger numberOfRows;
@property (nonatomic,strong) NSMutableArray<DANewDiaryListModel *> *dataSourceArrs;

@end

@implementation CustomTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.dataSourceArrs = [NSMutableArray arrayWithCapacity:0];
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self registerNib:[UINib nibWithNibName:@"DANewDiaryCell" bundle:nil] forCellReuseIdentifier:@"DANewDiaryCell"];
        self.tableFooterView = [UIView new];
        self.rowHeight = 292;
         _pageNum = 1;
        _lastIndex = self.itemIndex = -1;
        
    }
    return self;
}

- (void)refreshWithData:(id)numberOfRows atIndex:(NSInteger)index withClassId:(NSString *)classid{
    
    _numberOfRows = [numberOfRows integerValue];
    _itemIndex = index;
    
    WS(weakSelf);
    
    self->_pageNum = 1;
    
    
    if (_lastIndex != [classid integerValue]) {
        
        self.itemIndex = [classid integerValue];
        
        [weakSelf loadTableListData:classid];
        
        _lastIndex = [classid integerValue];
        
    }
    
    
    self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        if (self->_isNoMoreData) {
            return ;
        }
        self->_pageNum ++;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.233 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf loadTableListData:classid];
        });

    }];
    

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArrs.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DANewDiaryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DANewDiaryCell"];

    // 自定义表格部分。如果只使用默认形式则只需要如下指定UITableViewCell格式，默认表格行的三个属性为textLabel、detailTextLabel、image
    // 分别对应UITableViewCell显示的标题、纤细的内容以及左边图标，如果使用自定义表格则指定相应的类进行初始化。
    if (self.dataSourceArrs.count != 0) {
        cell.model = self.dataSourceArrs[indexPath.row];
    }
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (![DANewUserInfo isLogIn]) {
        WELoginVC *vc = [WELoginVC new];
        vc.hidesBottomBarWhenPushed = YES;
        [[self getCurrentVCWithCurrentView].navigationController pushViewController:vc animated:YES];
        return;
    }
    DANewDiaryListModel *model = self.dataSourceArrs[indexPath.row];
    MTWebViewVC *vc = [MTWebViewVC new];
    vc.titleName = model.title;
    vc.url = model.titleurl;
    vc.hidesBottomBarWhenPushed = YES;
    [[self getCurrentVCWithCurrentView].navigationController pushViewController:vc animated:YES];
    
}

#pragma mark ——————————————————————————————————————————  咨询内容板块
- (void)loadTableListData:(NSString *)type{
    
    NSMutableDictionary *ditc = [NSMutableDictionary dictionary];
    [ditc setObject:type forKey:@"classid"];
    [ditc setObject:@"10" forKey:@"rows"];
    [ditc setObject:[NSString stringWithFormat:@"%ld",_pageNum] forKey:@"pages"];
    
    if (_pageNum == 1) {
        [self.dataSourceArrs removeAllObjects];
    }

    
    WS(weakSelf);
    [AFNRequestManager __request:(AWPost_request) urlstr:[URLRequest czw_getHomeDiaryList] requestData:ditc completion:^(id responseObject, NSError *error) {
        
        if (!error) {
            
            NSArray *dataArrs = responseObject[@"chouqian"];
            NSString *totalStr = responseObject[@"total"];
            
            for (NSDictionary *dict in dataArrs) {
                DANewDiaryListModel *model = [DANewDiaryListModel yy_modelWithDictionary:dict];
                [self.dataSourceArrs addObject:model];
            }
            [self reloadData];
            
//            self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-200);
            
            if (dataArrs.count == 0) {
                self->_isNoMoreData = YES;
                [SVProgressHUD showInfoWithStatus:@"暂无更多数据"];
            }
            
            if (self.dataSourceArrs.count >= [totalStr integerValue] || dataArrs.count == 0) {
                
                [weakSelf.mj_footer endRefreshing];
                
            }else{
                
                [weakSelf.mj_footer endRefreshing];
                [weakSelf.mj_header endRefreshing];
                
            }
            
//            [weakSelf requsetNewsAdListByType:type];
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:@"当前网络异常"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.88 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.mj_footer endRefreshing];
                [weakSelf.mj_header endRefreshing];
            });
        }
        [self reloadData];
        
    }];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSLog(@" ===== %.2f",scrollView.contentOffset.y);
    
    if (self.dataSourceArrs.count < 10) {
        if (scrollView.contentOffset.y > 292*(self.dataSourceArrs.count-1)-166-40) {
            [scrollView setContentOffset:CGPointMake(0, 292*(self.dataSourceArrs.count-1)-166-40) animated:NO];
        }
    }
    
//#if !defined(ST_PULLTOREFRESH_HEADER_HEIGHT)
//    STRefreshHeader * header = self.header;
//    CGFloat orginY = - (header.st_height + self.swipeTableView.swipeHeaderView.st_height + self.swipeTableView.swipeHeaderBar.st_height);
//    if (header.st_y != orginY) {
//        header.st_y = orginY;
//    }
//#endif
}


/**
 展示新的广告插入元素
 */
- (void)requsetNewsAdListByType:(NSString *)type{
    
    WS(weakSelf);
    [DataRequest Post:[URLRequest url_getAdList] parametes:nil success:^(id responObject) {
        
        NSArray *arr = responObject[@"rows"];
        
        for (NSDictionary *dict in arr) {
            
            NSString *typeStr = dict[@"type"];
            
            if([typeStr integerValue] == 4){
                
                if ([dict[@"class_code"] integerValue] == [type integerValue]) {
                    
//                    DAHomeListModel *model = [DAHomeListModel new];
//                    model.title = dict[@"title"];
//                    model.titleurl = dict[@"url"];
//                    model.content = dict[@"description"];
//                    model.showTime = [NSString getAppTimes];
//                    model.titlepic = dict[@"logo"];
//                    model.onclick = [NSString getCurrentReadCount];
//
//                    if (weakSelf.dataSourceArrs.count > [dict[@"ad_sort"] integerValue]) {
//                        [weakSelf.dataSourceArrs insertObject:model atIndex:[dict[@"ad_sort"] integerValue]];
//                    }
                    
                }
                
            }
            
            // 去除数组中model重复
            for (NSInteger i = 0; i < self.dataSourceArrs.count; i++) {
                for (NSInteger j = i+1;j < self.dataSourceArrs.count; j++) {
//                    DAHomeListModel *tempModel = self.dataSourceArrs[i];
//                    DAHomeListModel *model = self.dataSourceArrs[j];
//                    if ([tempModel.title isEqualToString:model.title]) {
//                        [self.dataSourceArrs removeObject:model];
//                    }
                }
            }
            
            [weakSelf reloadData];
            
        }
        
        
    } failure:^(id responObject) {
        
    } error:^(id error) {
        
    }];
    
}

- (UIViewController *)getCurrentVCWithCurrentView
{
    for (UIView *next = self ; next ; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
