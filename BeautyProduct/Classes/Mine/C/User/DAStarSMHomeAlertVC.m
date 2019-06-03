//
//  WQHomeAlertVC.m
//  Created by iMac-1 on 2017/11/28.
//  Copyright © 2017年 iOS_阿玮. All rights reserved.
//

#import "DAStarSMHomeAlertVC.h"

@interface DAStarSMHomeAlertVC ()
@property (weak, nonatomic) IBOutlet UILabel *lab_topMessage;
@property (weak, nonatomic) IBOutlet UIButton *btn_name;
@end

@implementation DAStarSMHomeAlertVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self aw___hideSystemNav];
//    if (self.type == 1) {
//        [self.btn_name setImage:[UIImage imageNamed:@"alert_ok"] forState:(UIControlStateNormal)];
//        self.lab_topMessage.text = @"填写的资料不能保存，确认要返回？";
//    }
//    if (self.type == 2) {
//        [self.btn_name setImage:[UIImage imageNamed:@"alert_ok"] forState:(UIControlStateNormal)];
//        self.lab_topMessage.text = @"银行卡绑定后不能修改，是否绑定？";
//    }
//    if (self.type == 3) {
//        [self.btn_name setImage:[UIImage imageNamed:@"alert_bank"] forState:(UIControlStateNormal)];
//        self.lab_topMessage.text = @"银行卡绑定后不能修改，是否绑定？";
//    }
//    if (self.type == 4) {
//        [self.btn_name setImage:[UIImage imageNamed:@"alert_ok"] forState:(UIControlStateNormal)];
//        self.lab_topMessage.text = @"是否要退出当前账号？";
//    }
}

#pragma mark --- 取消
- (IBAction)canleClick:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
}

#pragma mark --- 去查看
- (IBAction)goToLookClick:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:NO completion:nil];
    if (self.backBlock) {
        self.backBlock();
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
