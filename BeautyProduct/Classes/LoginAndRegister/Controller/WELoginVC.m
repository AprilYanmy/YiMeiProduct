//
//  WELoginVC.m
//  PeoitELoanProject
//
//  Created by iMac-1 on 2017/9/8.
//  Copyright © 2017年 iOS_Awei. All rights reserved.
//

#import "WELoginVC.h"
#import "WERegisterVC.h"
#import "WEForgetVC.h"

@interface WELoginVC ()
@property (weak, nonatomic) IBOutlet UITextField *tf_phone;
@property (weak, nonatomic) IBOutlet UITextField *tf_psw;

@end

@implementation WELoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"登录";
   
}

#pragma mark --- 返回按钮点事件
- (void)leftBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --- 登录
- (IBAction)loginClick:(UIButton *)sender {
    
    if (self.tf_phone.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号码"];
        return;
    }
    
    if (self.tf_phone.text.length != 11) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
        return;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if (self.tf_psw.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    
    [dic setObject:self.tf_phone.text forKey:@"userName"];
    [dic setObject:self.tf_psw.text forKey:@"pwd"];
    [dic setObject:@"2" forKey:@"type"];

    sender.userInteractionEnabled = NO;
    [DataRequest Post:[URLRequest url_login] parametes:dic success:^(id responObject) {
        
        NSString *userId = [[responObject objectForKey:@"data"] objectForKey:@"id"];
        DANewUserInfo *user = [DANewUserInfo sharedInstance];
        user.userID = userId;
        user.tell = self.tf_phone.text;
        [DANewUserInfo synchronize];
        
        [self.navigationController popViewControllerAnimated:YES];
        sender.userInteractionEnabled = YES;
        
    } failure:^(id responObject) {
        sender.userInteractionEnabled = YES;
    } error:^(id error) {
        sender.userInteractionEnabled = YES;
    }];
    
}
#pragma mark -- 忘记密码
- (IBAction)forgetPswClick:(UIButton *)sender {
    [self.navigationController pushViewController:[[WEForgetVC alloc] initWithNibName:@"WEForgetVC" bundle:nil] animated:YES];
}

#pragma mark -- 注册
- (IBAction)registerClick:(UIButton *)sender {
    [self.navigationController pushViewController:[[WERegisterVC alloc] initWithNibName:@"WERegisterVC" bundle:nil] animated:YES];
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
