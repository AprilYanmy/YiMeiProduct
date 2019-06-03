//
//  DANewInstitutionVC.m
//  BeautyProduct
//
//  Created by iMac-1 on 2018/8/30.
//  Copyright © 2018年 iOS_阿玮. All rights reserved.
//

#import "DANewInstitutionVC.h"
#import "DANewInsitutionDetailVC.h"
#import "WELoginVC.h"

#import "DANewInstiitutCell.h"
#import "DANewHostChooseView.h"

@interface DANewInstitutionVC () <UITableViewDataSource,UITableViewDelegate>
{
    int _page;
    NSArray *_cityArrs;
    BOOL _isLeftOpen,_isRightOpen;
}
@property (weak, nonatomic) IBOutlet UIImageView *img_city;
@property (weak, nonatomic) IBOutlet UIImageView *img_type;
@property (weak, nonatomic) IBOutlet UILabel *lab_cityName;
@property (weak, nonatomic) IBOutlet UILabel *lab_typeName;

@property (weak, nonatomic) IBOutlet UITableView *hospitalTableView;

@property (nonatomic,strong) DANewHostChooseView *chooseView;

/**
 整形列表 数据
 */
@property (nonatomic,strong) NSMutableArray <DANewHostModel *> *hosDataSource;

/**
 整形类型列表 数据
 */
@property (nonatomic,strong) NSMutableArray <DANewHostModel *> *chooseTypeDataSource;

/**
 擅长项目 数据
 */
@property (nonatomic,strong) NSMutableArray <NSString *> *hosTypeSource;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;

@end

@implementation DANewInstitutionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"机构";
    [self.hospitalTableView registerNib:[UINib nibWithNibName:@"DANewInstiitutCell" bundle:nil]
                 forCellReuseIdentifier:@"DANewInstiitutCell"];
    _page = 1;
    _cityArrs = @[@"重庆",@"杭州",
                  @"上海",@"北京",
                  @"武汉"];
    
    _isLeftOpen = _isRightOpen = NO;
    
    self.hospitalTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self->_page = 1;
        self.lab_typeName.text = @"擅长项目";
        [self czw_loadHospitTableList];
        
    }];
    
    self.hospitalTableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        
        self->_page++;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.666 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

            [self czw_loadHospitTableList];

        });
        
    }];

    [self.hospitalTableView.mj_header beginRefreshing];
    
    self.chooseView = [DANewHostChooseView creatViewChooseBlock:^(NSString *chooseStr, NSInteger type) {
        
        self.img_city.image = [UIImage imageNamed:@"jigou_down"];
        self.img_type.image = [UIImage imageNamed:@"jigou_down"];

        if (type == 2) {
            
            self.lab_cityName.text = chooseStr;
            [self czw_loadHospitTableList];
            
        }else{
            
            self.lab_typeName.text = chooseStr;
            [self czw___changChooseTypeDataSource];
            
        }
        
        
    }];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([self.lab_typeName.text isEqualToString:@"全部"]||
        [self.lab_typeName.text isEqualToString:@"擅长项目"]) {
        
        return self.hosDataSource.count;
        
    }else{
        
        return self.chooseTypeDataSource.count;

    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DANewInstiitutCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DANewInstiitutCell"];
    if ([self.lab_typeName.text isEqualToString:@"全部"]||
        [self.lab_typeName.text isEqualToString:@"擅长项目"]) {
        
        cell.hostModel = self.hosDataSource[indexPath.row];
        
    }else{
        
        cell.hostModel = self.chooseTypeDataSource[indexPath.row];
        
    }
    
    return cell;
    
}

#pragma mark ——————————————————————————————————————————— 详情页跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (![DANewUserInfo isLogIn]) {
        WELoginVC *vc = [WELoginVC new];
        [self aw___pushViewController:vc];
        return;
    }
    
    DANewInsitutionDetailVC *vc = [DANewInsitutionDetailVC new];
    
    if ([self.lab_typeName.text isEqualToString:@"全部"]||
        [self.lab_typeName.text isEqualToString:@"擅长项目"]) {
        
        DANewHostModel *hostModel = self.hosDataSource[indexPath.row];
        vc.detailModel = hostModel;
        
    }else{
        
        DANewHostModel *hostModel = self.chooseTypeDataSource[indexPath.row];
        vc.detailModel = hostModel;
    }

    [self aw___pushViewController:vc];
    
}

#pragma mark ——————————————————————————————————————————  城市选择
- (IBAction)chooseCityClick:(UIButton *)sender {
    
    if (![DANewUserInfo isLogIn]) {
        WELoginVC *vc = [WELoginVC new];
        [self aw___pushViewController:vc];
        return;
    }
    
    _isLeftOpen = YES;
    
    _isRightOpen = NO;
    
    self.img_city.image = [UIImage imageNamed:@"jigou_up"];
    
    self.img_type.image = [UIImage imageNamed:@"jigou_down"];

    self.chooseView.titleArrs = _cityArrs;
    
    if (sender.selected) {
        
        [self.chooseView closeView];
        self.img_city.image = [UIImage imageNamed:@"jigou_down"];
        
    }else{
        
         [self.chooseView openView:2];
        
    }
    
   self.rightBtn.selected = sender.selected =! sender.selected;
    
   
}

#pragma mark ——————————————————————————————————————————  擅长项目
- (IBAction)chooseTypeClick:(UIButton *)sender{
    
    if (![DANewUserInfo isLogIn]) {
        WELoginVC *vc = [WELoginVC new];
        [self aw___pushViewController:vc];
        return;
    }
    
    self.img_type.image = [UIImage imageNamed:@"jigou_up"];
    
    self.img_city.image = [UIImage imageNamed:@"jigou_down"];
    
    self.chooseView.titleArrs = self.hosTypeSource;
    
    if (sender.selected) {
        
        [self.chooseView closeView];
        self.img_type.image = [UIImage imageNamed:@"jigou_down"];
        
    }else{
        
        [self.chooseView openView:0];
        
    }
    
    self.leftBtn.selected = sender.selected =! sender.selected;
    
}

#pragma mark ——————————————————————————————————————————  咨询内容板块
- (void)czw_loadHospitTableList{
    
    NSMutableDictionary *ditc = [NSMutableDictionary dictionary];
    [ditc setObject:AppCode forKey:@"appcode"];
    [ditc setObject:[NSString stringWithFormat:@"%d",_page]
             forKey:@"page"];
    [ditc setObject:[[NSString aw___transform:self.lab_cityName.text] stringByReplacingOccurrencesOfString:@" " withString:@""]
             forKey:@"city_py"];
    
    if (_page == 1) {
        [self.hosDataSource removeAllObjects];
        [self.hosTypeSource removeAllObjects];
    }
    
    WS(weakSelf);
    [AFNRequestManager __request:(AWPost_request) urlstr:[URLRequest czw___getHostDataSourceList] requestData:ditc completion:^(id responseObject, NSError *error) {
        
        if (!error) {
            
            NSArray *dataArrs = responseObject;
            
            if (dataArrs.count != 0) {
                for (NSDictionary *dict in dataArrs) {
                    DANewHostModel *model = [DANewHostModel yy_modelWithDictionary:dict];
                    [weakSelf.hosTypeSource addObject:model.advantage];
                    [weakSelf.hosDataSource addObject:model];
                }
            }else{
                [SVProgressHUD showInfoWithStatus:@"暂无更多数据"];
            }
            
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:0];
            
            for(NSString *str in weakSelf.hosTypeSource)
            {
                [dic setValue:str forKey:str];
            }
            
            weakSelf.hosTypeSource = [NSMutableArray arrayWithArray:[dic allKeys]];
            
            for (int i = 0; i < weakSelf.hosTypeSource.count; i++) {
                
                NSString *tmpStr = weakSelf.hosTypeSource[i];
                if ([tmpStr isEqualToString:@"其它"]) {
                    [weakSelf.hosTypeSource removeObjectAtIndex:i];
                }
            }
            
            [weakSelf.hosTypeSource insertObject:@"全部" atIndex:0];
            
            [weakSelf.hosTypeSource addObject:@"其它"];
            
            [weakSelf.hospitalTableView reloadData];
            
            [weakSelf.hospitalTableView.mj_footer endRefreshing];
            [weakSelf.hospitalTableView.mj_header endRefreshing];
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:@"当前网络异常"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.88 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.hospitalTableView.mj_footer endRefreshing];
                [weakSelf.hospitalTableView.mj_header endRefreshing];
            });
        }
        [weakSelf.hospitalTableView reloadData];
        
    }];
    
}


/**
 数据类型处理
 */
- (void)czw___changChooseTypeDataSource{
    
    if (![self.lab_typeName.text isEqualToString:@"全部"]) {
        
        self.chooseTypeDataSource = [NSMutableArray arrayWithCapacity:0];
        
        for (DANewHostModel *model in self.hosDataSource) {
            
            if ([model.advantage isEqualToString:self.lab_typeName.text]) {
                
                 [self.chooseTypeDataSource addObject:model];
            
            }
            
        }
        
    }
    [self.hospitalTableView reloadData];
    
}

#pragma mark ———————————————————————————————————— 懒加载
- (NSMutableArray *)hosDataSource{
    
    if (!_hosDataSource) {
        _hosDataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _hosDataSource;
    
}

- (NSMutableArray *)hosTypeSource{
    
    if (!_hosTypeSource) {
        _hosTypeSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _hosTypeSource;
    
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
