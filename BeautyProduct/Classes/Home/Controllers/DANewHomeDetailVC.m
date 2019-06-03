//
//  DANewHomeDetailVC.m
//  BeautyProduct
//
//  Created by iMac-1 on 2018/8/30.
//  Copyright © 2018年 iOS_阿玮. All rights reserved.
//

#import "DANewHomeDetailVC.h"
#import "DANewAleartCommitVC.h"

#import "DANewProductModel.h"
#import "DANewInsitutionDetailVC.h"

#import "DANewProductDetailCell.h"

@interface DANewHomeDetailVC () <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *downHeight;
@property (weak, nonatomic) IBOutlet UIView *downView;

@property (weak, nonatomic) IBOutlet UITableView *productTableView;

@property DANewProductModel *produtcModel;
@property (weak, nonatomic) IBOutlet UIImageView *img_produtcBanner;
@property (weak, nonatomic) IBOutlet UILabel *lab_productName;
@property (weak, nonatomic) IBOutlet UILabel *lab_productUpPrice;
@property (weak, nonatomic) IBOutlet UILabel *lab_productOldPrice;
@property (weak, nonatomic) IBOutlet UILabel *lab_saleCount;
@property (weak, nonatomic) IBOutlet UILabel *lab_program;
@property (weak, nonatomic) IBOutlet UILabel *lab_hospitalName;
@property (weak, nonatomic) IBOutlet UILabel *lab_hospitalAddress;
@property (weak, nonatomic) IBOutlet BaseImageView *img_hospitalLogo;
@property (weak, nonatomic) IBOutlet UILabel *lab_hospitalScore;
@property (weak, nonatomic) IBOutlet UIImageView *img_hospitalStar;
@property (weak, nonatomic) IBOutlet UILabel *lab_downPrice;

@end

@implementation DANewHomeDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"商品详情页";
    
    self.img_produtcBanner.clipsToBounds = YES;
    
    [self czw_loadProductDetailRequest];
    
    [self.productTableView registerNib:[UINib nibWithNibName:@"DANewProductDetailCell" bundle:nil]
                forCellReuseIdentifier:@"DANewProductDetailCell"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.produtcModel.detail_heigthArrs.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DANewProductDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DANewProductDetailCell"];
    cell.imgUrl = self.produtcModel.detail_imgs[indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float height = [self.produtcModel.detail_heigthArrs[indexPath.row] floatValue];
    
    return height;
    
}

#pragma mark ——————————————————————————————————————————  咨询内容板块
- (void)czw_loadProductDetailRequest{
    
    NSMutableDictionary *ditc = [NSMutableDictionary dictionary];
    [ditc setObject:AppCode forKey:@"appcode"];
    [ditc setObject:self.result_id forKey:@"product_id"];
    
    WS(weakSelf);
    [AFNRequestManager __request:(AWPost_request) urlstr:[URLRequest czw___getHomeNewsDetail] requestData:ditc completion:^(id responseObject, NSError *error) {
        
        if (!error) {
            
            NSDictionary *jsonDict = responseObject;
            
            DANewProductModel *model = [DANewProductModel yy_modelWithDictionary:jsonDict];
            self.produtcModel = model;
            
            [self.img_produtcBanner sd_setImageWithURL:[NSURL URLWithString:model.img]];
            self.lab_productName.text = model.name;
            self.lab_downPrice.text = self.lab_productUpPrice.text = [NSString stringWithFormat:@"￥%@",model.newprice];
            self.lab_productOldPrice.text = [NSString stringWithFormat:@"￥%@",model.oldprice];
            self.lab_saleCount.text = model.sale_num;
            self.lab_program.text = model.program;
            self.lab_hospitalName.text = model.hospitalModel.name;
            self.lab_hospitalAddress.text = model.hospitalModel.address;
            [self.img_hospitalLogo sd_setImageWithURL:[NSURL URLWithString:model.hospitalModel.img]];
            self.lab_hospitalScore.text = [NSString stringWithFormat:@"共%@人评价",model.oldprice];
            self.img_hospitalStar.image = [UIImage imageNamed:model.hospitalModel.starImgName];
            
            [weakSelf.productTableView reloadData];
            [weakSelf.productTableView.mj_footer endRefreshing];
            [weakSelf.productTableView.mj_header endRefreshing];
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:@"当前网络异常"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.88 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.productTableView.mj_footer endRefreshing];
                [weakSelf.productTableView.mj_header endRefreshing];
            });
        }
        [weakSelf.productTableView reloadData];
        
    }];
    
}

#pragma mark ———————————————————————————————————— 医院详情页
- (IBAction)showHospDetailClick:(UIButton *)sender {
    
    DANewInsitutionDetailVC *vc = [DANewInsitutionDetailVC new];
    
    Hospital *model = self.produtcModel.hospitalModel;
    
    DANewHostModel *tmpModel = [DANewHostModel new];
    tmpModel.name = model.name;
    tmpModel.result_id = model.hospital_id;
    
    vc.detailModel = tmpModel;
    
    [self aw___pushViewController:vc];
    
}

#pragma mark ———————————————————————————————————— 购买咨询
- (IBAction)goToBuyProductClick:(UIButton *)sender {
    
    DANewAleartCommitVC *vc = [[DANewAleartCommitVC alloc] initWithNibName:@"DANewAleartCommitVC" bundle:nil];
//    vc.type = 0;
//    [vc setBackBlock:^{
//        [DANewUserInfo logout];
//        [self viewWillAppear:NO];
//    }];
    vc.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.8f];
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:vc animated:NO completion:nil];
    
//    //提示框添加文本输入框
//    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"温馨提示"
//                                                                   message:@"请输入您的姓名和手机，方便专业客服人员电话联系您了解具体情况"
//                                                            preferredStyle:UIAlertControllerStyleAlert];
//
//    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault
//                                                     handler:^(UIAlertAction * action) {
//                                                         //响应事件
//                                                         //得到文本信息
//                                                         for(UITextField *text in alert.textFields){
//                                                             NSLog(@"text = %@", text.text);
//                                                             if (text.tag == 100) {
//
//                                                                 if (text.text.length>8) {
//                                                                     [SVProgressHUD showErrorWithStatus:@"请输入真实姓名"];
//                                                                     return;
//                                                                 }
//
//                                                             }else{
//
//                                                                 if (text.text.length != 11) {
//                                                                     [SVProgressHUD showErrorWithStatus:@"请输入正确的联系方式"];
//                                                                     return;
//                                                                 }
//
//                                                             }
//                                                         }
//
//                                                         [SVProgressHUD showSuccessWithStatus:@"提交成功，客服将于2个小时内主动与您联系。"];
//
//                                                     }];
//    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
//                                                         handler:^(UIAlertAction * action) {
//                                                             //响应事件
//                                                             NSLog(@"action = %@", alert.textFields);
//                                                         }];
//    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
//        textField.placeholder = @"咨询姓名";
//        textField.tag = 100;
//        textField.keyboardType = UIKeyboardTypeDefault;
//    }];
//    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
//        textField.placeholder = @"联系方式";
//        textField.keyboardType = UIKeyboardTypeNumberPad;
//    }];
//
//    [alert addAction:okAction];
//    [alert addAction:cancelAction];
//    [self presentViewController:alert animated:YES completion:nil];

    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.y > 308.0) {
        self.downHeight.constant = 48;
        self.downView.hidden = NO;
    }else{
        self.downHeight.constant = 0;
        self.downView.hidden = YES;
    }
    
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
