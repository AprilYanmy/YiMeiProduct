//
//  DAMineEmailVC.m
//  Divination
//
//  Created by iMac-1 on 2018/3/30.
//  Copyright © 2018年 iOS_阿玮. All rights reserved.
//

#import "DAStarAWMineEmailVC.h"

@interface DAStarAWMineEmailVC ()

@property (weak, nonatomic) IBOutlet BaseButton *btn_name;
@property (weak, nonatomic) IBOutlet UITextField *tf_content;

@end

@implementation DAStarAWMineEmailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"邮箱验证";
    if ([[DANewUserInfo sharedInstance].email isEqualToString:@"点击认证邮箱"]) {
        [self.btn_name  setTitle:@"认证邮箱" forState:(UIControlStateNormal)];
    }else{
        [self.btn_name  setTitle:@"修改邮箱" forState:(UIControlStateNormal)];
    }
    
    if (self.type == 1) {
        self.navigationItem.title = @"我的昵称";
        self.tf_content.placeholder = @"请输入昵称";

       [self.btn_name  setTitle:@"修改昵称" forState:(UIControlStateNormal)];
    }
}

#pragma mark —————————————————————————————————————————— 修改昵称 邮箱
- (IBAction)backClick:(UIButton *)sender {
    
    if ([NSString isInputNil:self.tf_content.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入真实姓名"];
        return;
    }
    if ([NSString isPureInt:self.tf_content.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入真实姓名"];
        return;
    }
//    if ([NSString __AWdeptNameInputShouldChinese:self.tf_content.text]) {
//        [SVProgressHUD showErrorWithStatus:@"请输入真实姓名"];
//        return;
//    }
    if (self.tf_content.text.length > 8) {
        [SVProgressHUD showErrorWithStatus:@"请输入不多于8位的真实姓名"];
        return;
    }
    
    self.contentBack(self.tf_content.text,self.type);
    [self.navigationController popViewControllerAnimated:YES];
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
