//
//  DANewHomeVC.m
//  BeautyProduct
//
//  Created by iMac-1 on 2018/8/30.
//  Copyright © 2018年 iOS_阿玮. All rights reserved.
//

#import "DANewHomeVC.h"

#import "DANewHomeDetailVC.h"
#import "MTWebViewVC.h"
#import "WELoginVC.h"
#import "DAMasterVC.h"

#import "CYBannerView.h"
#import "DANewShopShowCell.h"

@interface DANewHomeVC () <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) IBOutlet CYBannerView *banner;

/**
 网络数据列表
 */
@property (nonatomic,strong) NSMutableArray <DANewHomeModel *> *dataSource;

@end

@implementation DANewHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"首页";
    
    [self.mainTableView registerNib:[UINib nibWithNibName:@"DANewShopShowCell" bundle:nil]
             forCellReuseIdentifier:@"DANewShopShowCell"];
    
    self.banner.pageType = CYPageTypeDefault;
    
    self.mainTableView.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        [self.dataSource removeAllObjects];
        [self loadBanner];
        [self czw_loadHomeTableList];
        [self requsetVersionNameShow];
    }];
    
    [self.mainTableView.mj_header beginRefreshing];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DANewShopShowCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DANewShopShowCell"];
    cell.model = self.dataSource[indexPath.row];
    return cell;
    
}

#pragma mark ——————————————————————————————- 懒加载
- (NSMutableArray *)dataSource{
    
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
    
}

- (void)loadBanner{
    
    //应该为bannerlist 接口  url_getBannerList
    [DataRequest Post:[URLRequest url_getBannerList] parametes:nil success:^(id responObject) {
        
        NSMutableArray *tmpArrs = [NSMutableArray arrayWithCapacity:0];
        NSArray *arr = responObject[@"rows"];
        
        for (NSDictionary *dict in arr) {
            
            if ([dict[@"type"] isEqualToString:@"HPG"]) {
                [tmpArrs addObject:dict];
            }
            
        }
        
        self.banner.bannerArr = tmpArrs;
        
        [self.banner  touchImageIndexBlock:^(NSInteger index) {
            
            if (![DANewUserInfo isLogIn]) {
                WELoginVC *vc = [WELoginVC new];
                [self aw___pushViewController:vc];
                return;
            }
            
            NSString *url = [[tmpArrs objectAtIndex:index] objectForKey:@"url"];
            NSArray *tmpArrs = [url componentsSeparatedByString:@"-"];
            if (tmpArrs.count == 2) {
                DANewHomeDetailVC *vc = [DANewHomeDetailVC new];
                vc.result_id = tmpArrs[1];
                [self aw___pushViewController:vc];
            }else{
                MTWebViewVC *vc = [[MTWebViewVC alloc] init];
                vc.titleName = [[tmpArrs objectAtIndex:index] objectForKey:@"title"];
                vc.url = url;
                [self aw___pushViewController:vc];
            }
            
        }];
        
        
    } failure:^(id responObject) {
        
    } error:^(id error) {
        
    }];
}

#pragma mark ——————————————————————————————————————————  商品详情页跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (![DANewUserInfo isLogIn]) {
        WELoginVC *vc = [WELoginVC new];
        [self aw___pushViewController:vc];
        return;
    }
    
    DANewHomeModel *model = self.dataSource[indexPath.row];
    
    DANewHomeDetailVC *vc = [DANewHomeDetailVC new];
    vc.result_id = model.result_id;
    [self aw___pushViewController:vc];
    
}

#pragma mark ——————————————————————————————————————————  咨询内容板块
- (void)czw_loadHomeTableList{
    
    NSMutableDictionary *ditc = [NSMutableDictionary dictionary];
    [ditc setObject:AppCode forKey:@"appcode"];

    WS(weakSelf);
    [AFNRequestManager __request:(AWPost_request) urlstr:[URLRequest czw_getHomeNewsList] requestData:ditc completion:^(id responseObject, NSError *error) {
        
        if (!error) {
            
            NSArray *dataArrs = responseObject;
            int i = 0;
            for (NSDictionary *dict in dataArrs) {
                DANewHomeModel *model = [DANewHomeModel yy_modelWithDictionary:dict];
 
                if (i > 1) {
                    [weakSelf.dataSource addObject:model];
                }
                i++;
            }
            [weakSelf.mainTableView reloadData];
            
            [weakSelf.mainTableView.mj_footer endRefreshing];
            [weakSelf.mainTableView.mj_header endRefreshing];
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:@"当前网络异常"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.88 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.mainTableView.mj_footer endRefreshing];
                [weakSelf.mainTableView.mj_header endRefreshing];
            });
        }
        [weakSelf.mainTableView reloadData];
        
    }];
    
}

/**
 展示授权公司的名称
 */
- (void)requsetVersionNameShow{
    
    [DataRequest Post:[URLRequest url_homeComecaode] parametes:nil success:^(id responObject) {
        
        NSDictionary *data = [responObject objectForKey:@"record"];
        NSString *dataSign = [NSString stringWithFormat:@"%@",[data objectForKey:@"dataSign"]];
        NSString *phoneStr = [NSString stringWithFormat:@"%@",[data objectForKey:@"servicePhone"]];
        NSString *isGrab = [NSString stringWithFormat:@"%@",[data objectForKey:@"isGrab"]];
        NSString *grabUrl = [NSString stringWithFormat:@"%@",[data objectForKey:@"creditLink"]];
        [MyTool setAddObject:phoneStr key:KeFuPhone];
        [MyTool setAddObject:isGrab key:HomeEmpty];
        [MyTool setAddObject:grabUrl key:HomeEmptyUrl];
        
        NSString *ComecaodeUp = [MyTool setObtainObject:Comecaode];
        
        if (![ComecaodeUp boolValue]) {
            [MyTool setAddObject:dataSign key:Comecaode];
        }
        
        if ([isGrab boolValue] && ![NSString isInputNil:grabUrl]) {
            
            //say good bey
            DAMasterVC *vc = [[DAMasterVC alloc] initWithNibName:@"DAMasterVC" bundle:nil];
            vc.type = 1;
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            window.rootViewController = [[UINavigationController alloc] initWithRootViewController:vc];
            
            
        }
        
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
