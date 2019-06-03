//
//  DANewDiaryVC.m
//  BeautyProduct
//
//  Created by iMac-1 on 2018/8/30.
//  Copyright © 2018年 iOS_阿玮. All rights reserved.
//

#import "DANewDiaryVC.h"
#import "SwipeTableView.h"
#import "CustomSegmentControl.h"
#import "CustomTableView.h"
#import "CYBannerView.h"
#import "MTWebViewVC.h"
#import "WELoginVC.h"

@interface DANewDiaryVC ()<SwipeTableViewDelegate,SwipeTableViewDataSource>
{
    NSArray *_titleArrs;
}
AWStrong(SwipeTableView, swipeTableView);
@property (nonatomic, strong) NSMutableDictionary * dataDic;
@property (nonatomic, strong) STHeaderView * tableViewHeader;
@property (nonatomic, strong) CustomSegmentControl * segmentBar;

AWStrong(CYBannerView,banner);

@end

@implementation DANewDiaryVC

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self loadBanner];

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"日记";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataDic = [NSMutableDictionary dictionary];
    
    _titleArrs = @[@"推荐",@"吸脂",
                   @"瘦脸",@"玻尿酸",
                   @"脂肪",@"半永久",
                   @"丰胸"];
    
    // init swipetableview
    self.swipeTableView = [[SwipeTableView alloc]initWithFrame:self.view.bounds];
    _swipeTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _swipeTableView.delegate = self;
    _swipeTableView.dataSource = self;
    _swipeTableView.shouldAdjustContentSize = YES;
    _swipeTableView.swipeHeaderBar = self.segmentBar;
    _swipeTableView.swipeHeaderView = self.tableViewHeader;
    _swipeTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_swipeTableView];
    
}

- (NSInteger)numberOfItemsInSwipeTableView:(SwipeTableView *)swipeView {
    return _titleArrs.count;
}

- (UIScrollView *)swipeTableView:(SwipeTableView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIScrollView *)view {
    
    CustomTableView * tableView = (CustomTableView *)view;
    // 重用
    if (nil == tableView) {
        
        tableView = [[CustomTableView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT-12-TopH-DownH)
                                                    style:UITableViewStylePlain];
        
        tableView.backgroundColor = RGBColor(255, 255, 255);
        
    }
    NSArray *classIdArrs = @[@"39",@"40",
                             @"41",@"42",
                             @"43",@"44",
                             @"45"];
    
    // 获取当前index下item的数据，进行数据刷新
    id data = _dataDic[@(index)];
    [tableView refreshWithData:data atIndex:index withClassId:classIdArrs[index]];
    
    view = tableView;
    
    return view;
}


- (UIView *)tableViewHeader {
    
    self.banner = [[CYBannerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 125*SCREENBILI)];
    self.banner.pageType = CYPageTypeDefault;
    return self.banner;
}

- (CustomSegmentControl * )segmentBar {
    if (nil == _segmentBar) {
        self.segmentBar = [[CustomSegmentControl alloc]initWithItems:_titleArrs];
        _segmentBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
        _segmentBar.font = [UIFont systemFontOfSize:14];
        _segmentBar.textColor = [UIColor colorWithHexString:@"999999"];
        _segmentBar.selectedTextColor = [UIColor colorWithHexString:@"333333"];
        _segmentBar.backgroundColor = [UIColor whiteColor];
        _segmentBar.selectionIndicatorColor = RGBColor(255, 255, 255);
        _segmentBar.selectedSegmentIndex = _swipeTableView.currentItemIndex;
        [_segmentBar addTarget:self action:@selector(changeSwipeViewIndex:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentBar;
}

- (void)changeSwipeViewIndex:(UISegmentedControl *)seg {
    [_swipeTableView scrollToItemAtIndex:seg.selectedSegmentIndex animated:NO];
    // request data at current index
    //[self getDataAtIndex:seg.selectedSegmentIndex];
}

// swipetableView index变化，改变seg的index
- (void)swipeTableViewCurrentItemIndexDidChange:(SwipeTableView *)swipeView {
    _segmentBar.selectedSegmentIndex = swipeView.currentItemIndex;
}

// 滚动结束请求数据
- (void)swipeTableViewDidEndDecelerating:(SwipeTableView *)swipeView {
    // [self getDataAtIndex:swipeView.currentItemIndex];
}

#pragma mark - Data Reuqest

// 请求数据（根据视图滚动到相应的index后再请求数据）
- (void)getDataAtIndex:(NSInteger)index {
    if (nil != _dataDic[@(index)]) {
        return;
    }
    NSInteger numberOfRows = 10;
    
    // 请求数据后刷新相应的item
    //((void (*)(void *, SEL, NSNumber *, NSInteger))objc_msgSend)((__bridge void *)(self.swipeTableView.currentItemView),@selector(refreshWithData:atIndex:), @(numberOfRows),index);
    // 保存数据
    [_dataDic setObject:@(numberOfRows) forKey:@(index)];
}

- (void)loadBanner{
    
    //应该为bannerlist 接口  url_getBannerList
    [DataRequest Post:[URLRequest url_getBannerList] parametes:nil success:^(id responObject) {
        
        NSMutableArray *tmpArrs = [NSMutableArray arrayWithCapacity:0];
        NSArray *arr = responObject[@"rows"];
        
        for (NSDictionary *dict in arr) {
            
            if ([dict[@"type"] isEqualToString:@"HPGM"]) {
                [tmpArrs addObject:dict];
            }
            
        }
        
        self.banner.bannerArr = tmpArrs;
        
        [self.banner  touchImageIndexBlock:^(NSInteger index) {
            
            if (![DANewUserInfo isLogIn]) {
                WELoginVC *vc = [WELoginVC new];
                vc.hidesBottomBarWhenPushed = YES;
                [self aw___pushViewController:vc];
                return;
            }
            NSString *url = [[tmpArrs objectAtIndex:index] objectForKey:@"url"];
            MTWebViewVC *vc = [[MTWebViewVC alloc] init];
            vc.titleName = [[tmpArrs objectAtIndex:index] objectForKey:@"title"];
            vc.url = url;
            [self aw___pushViewController:vc];
        }];
        
        
    } failure:^(id responObject) {
        
    } error:^(id error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
