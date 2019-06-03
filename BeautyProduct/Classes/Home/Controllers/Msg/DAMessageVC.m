//
//  DAMessageVC.m
//  Divination
//
//  Created by iMac-1 on 2018/4/4.
//  Copyright © 2018年 iOS_阿玮. All rights reserved.
//

#import "DAMessageVC.h"
#import "MTWebViewVC.h"

#import "DAMessageTableViewCell.h"
#import "DAMessageModel.h"

#import "JPUSHService.h"

@interface DAMessageVC () <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
AWStrong(NSMutableArray, dataSource);
@property (weak, nonatomic) IBOutlet UIView *noDataView;

@end

@implementation DAMessageVC

- (NSMutableArray *)dataSource{
    
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"消息中心";
    [self.tableView registerNib:[UINib nibWithNibName:@"DAMessageTableViewCell" bundle:nil] forCellReuseIdentifier:@"DAMessageTableViewCell"];
    
    NSString *ComecaodeUp = [MyTool setObtainObject:Comecaode];
    
    if ([ComecaodeUp boolValue]) {
        [self reloadDataSource];
    }
    
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    [JPUSHService resetBadge];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DAMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DAMessageTableViewCell"];
    cell.model = self.dataSource[indexPath.row];
    return cell;
    
}

/**
 消息列表 网路请求
 */
- (void)reloadDataSource{
    
    WS(weakSelf);
    [DataRequest Post:[URLRequest aw___getMessageList] parametes:@{@"apps":[NSString aw___getAppName]} success:^(id responObject) {
        
        NSArray *arr = responObject[@"rows"];
        if (arr.count == 0) {
            weakSelf.noDataView.hidden = NO;
            weakSelf.tableView.hidden = YES;
            return ;
        }
        
            weakSelf.noDataView.hidden = YES;
            weakSelf.tableView.hidden = NO;

        for (NSDictionary *dict in arr) {
            
            DAMessageModel * model = [DAMessageModel yy_modelWithDictionary:dict];
            [weakSelf.dataSource addObject:model];
            
        }
        [weakSelf.tableView reloadData];
        
    } failure:^(id responObject) {
        
    } error:^(id error) {
        
    }];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DAMessageModel * model = self.dataSource[indexPath.row];
    
    MTWebViewVC *vc = [MTWebViewVC new];
    vc.titleName = model.title;
    vc.url = model.url;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
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
