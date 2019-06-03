//
//  DANewInsitutionDetailVC.m
//  BeautyProduct
//
//  Created by iMac-1 on 2018/9/5.
//  Copyright © 2018年 iOS_阿玮. All rights reserved.
//

#import "DANewInsitutionDetailVC.h"
#import "DANewHomeDetailVC.h"

#import "CYBannerView.h"
#import "DANewInsDetailCell.h"
#import "HZPhotoBrowser.h"

#import "DANewInsiDetailModel.h"

@interface DANewInsitutionDetailVC () <UITableViewDataSource,UITableViewDelegate>
{
    HZPhotoBrowser *browser;
}
@property (weak, nonatomic) IBOutlet CYBannerView *banner;
@property (weak, nonatomic) IBOutlet UILabel *lab_name;
@property (weak, nonatomic) IBOutlet UILabel *lab_qualification;
@property (weak, nonatomic) IBOutlet UILabel *lab_level;
@property (weak, nonatomic) IBOutlet UILabel *lab_area;
@property (weak, nonatomic) IBOutlet UILabel *lab_address;
@property (weak, nonatomic) IBOutlet UITableView *insDetailTableView;

@property (nonatomic,strong) DANewInsiDetailModel *showModel;

@end

@implementation DANewInsitutionDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.lab_name.text = self.navigationItem.title = self.detailModel.name;
    
    self.banner.pageType = CYPageTypeDefault;
    
    self.banner.showType = 1;

    [self.insDetailTableView registerNib:[UINib nibWithNibName:@"DANewInsDetailCell" bundle:nil]
                  forCellReuseIdentifier:@"DANewInsDetailCell"];
    
    [self czw_loadProductDetailRequest];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.showModel.hotsalesModel.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DANewInsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DANewInsDetailCell"];
    cell.model = self.showModel.hotsalesModel[indexPath.row];
    return cell;
    
}

#pragma mark ——————————————————————————————————————————  商品详情页跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Hot_sales *model = self.showModel.hotsalesModel[indexPath.row];
    
    DANewHomeDetailVC *vc = [DANewHomeDetailVC new];
    vc.result_id = model.result_id;
    [self aw___pushViewController:vc];
    
}

#pragma mark ——————————————————————————————————————————  咨询内容板块
- (void)czw_loadProductDetailRequest{
    
    NSMutableDictionary *ditc = [NSMutableDictionary dictionary];
    [ditc setObject:AppCode forKey:@"appcode"];
    [ditc setObject:self.detailModel.result_id forKey:@"hospital_id"];
    
    WS(weakSelf);
    [AFNRequestManager __request:(AWPost_request) urlstr:[URLRequest czw___getHostDataSourceDetail] requestData:ditc completion:^(id responseObject, NSError *error) {
        
        if (!error) {
            
            NSDictionary *jsonDict = responseObject;
            
            DANewInsiDetailModel *model = [DANewInsiDetailModel yy_modelWithDictionary:jsonDict];
            self.showModel = model;
            
//            [self.img_produtcBanner sd_setImageWithURL:[NSURL URLWithString:model.img]];
            self.lab_name.text = model.name;
            self.lab_qualification.text = model.qualification;
            self.lab_level.text = model.level;
            self.lab_area.text = model.surface;
            self.lab_address.text = model.address;
            
            self.banner.bannerArr = [NSMutableArray arrayWithArray:model.imgs];
            
            [self banerShowBigPic];
            
            [weakSelf.insDetailTableView reloadData];
            [weakSelf.insDetailTableView.mj_footer endRefreshing];
            [weakSelf.insDetailTableView.mj_header endRefreshing];
            
            
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:@"当前网络异常"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.88 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.insDetailTableView.mj_footer endRefreshing];
                [weakSelf.insDetailTableView.mj_header endRefreshing];
            });
        }
        [weakSelf.insDetailTableView reloadData];
        
    }];
    
}


/**
 查看banner的大图
 */
- (void)banerShowBigPic{
    
    [self.banner  touchImageIndexBlock:^(NSInteger index) {
        
        [self->browser removeFromSuperview];
        
        self->browser = [[HZPhotoBrowser alloc] init];
        self->browser.isFullWidthForLandScape = YES;
        self->browser.isNeedLandscape = YES;
        self->browser.imageArray = self.showModel.imgs;

        self->browser.currentImageIndex = (int)index;
        
        [self->browser show];
        
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
