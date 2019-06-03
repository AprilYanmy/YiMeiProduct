//
//  WEForgetVC.m
//  PeoitELoanProject
//
//  Created by iMac-1 on 2017/9/8.
//  Copyright © 2017年 iOS_Awei. All rights reserved.
//

#import "WEForgetVC.h"

@interface WEForgetVC ()

@property (weak, nonatomic) IBOutlet UITextField *tf_phone;
@property (weak, nonatomic) IBOutlet UITextField *tf_code;
@property (weak, nonatomic) IBOutlet UITextField *tf_psw;
@property (weak, nonatomic) IBOutlet UIButton *btn_getVerifyCode;
@property (nonatomic, assign) NSInteger countTime;
@property (nonatomic, strong) NSTimer *timerHandle;

@end

@implementation WEForgetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"忘记密码";
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"获取验证码"];
    NSRange strRange = {0,[str length]};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    //此时如果设置字体颜色要这样
    [str addAttribute:NSForegroundColorAttributeName value:RGB(255, 131, 9)  range:strRange];
    //设置下划线颜色...
    [str addAttribute:NSUnderlineColorAttributeName value:RGB(255, 131, 9) range:strRange];
    [_btn_getVerifyCode setAttributedTitle:str forState:UIControlStateNormal];
}

#pragma mark --- 返回按钮点事件
- (void)leftBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- 获取验证码
- (IBAction)getCodeClick:(UIButton *)sender {
    
    
    if (self.tf_phone.text.length==0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号码!"];
        return;
    }
    if (self.tf_phone.text.length!=11) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码!"];
        return;
    }
    
    self.btn_getVerifyCode.userInteractionEnabled = NO;
    [DataRequest Post:[URLRequest url_getVerCode] parametes:@{@"phone":self.tf_phone.text,@"code":@"HXK"} success:^(id responObject) {
        
        NSInteger success = [[responObject objectForKey:@"success"] integerValue];
        
        if (success==1) {
            
            self.countTime = 60;
            self.btn_getVerifyCode.titleLabel.numberOfLines = 2;
            self.timerHandle = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeTime) userInfo:nil repeats:YES];
            [self.timerHandle fire];
        }else{
            self.btn_getVerifyCode.userInteractionEnabled = YES;
        }
        
    } failure:^(id responObject) {
        self.btn_getVerifyCode.userInteractionEnabled = YES;
    } error:^(id error) {
        self.btn_getVerifyCode.userInteractionEnabled = YES;
    }];
    
}

#pragma mark -- 忘记密码
- (IBAction)forgetClick:(UIButton *)sender {
    
    if (self.tf_phone.text.length==0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号码"];
        return;
    }
    
    
    if (self.tf_code.text.length==0) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }
    
    if (self.tf_phone.text.length!=11) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
        return;
    }
    
    if (self.tf_code.text.length!=6) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的验证码"];
        return;
    }
    
    if (self.tf_psw.text.length==0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:self.tf_phone.text forKey:@"phone"];
    
    [dic setObject:self.tf_code.text forKey:@"verCode"];
    
    [dic setObject:self.tf_psw.text forKey:@"pwd"];
    
    sender.userInteractionEnabled = NO;
 
    [DataRequest Post:[URLRequest url_resetPwd] parametes:dic success:^(id responObject) {
        NSString *userId = [[responObject objectForKey:@"data"] objectForKey:@"id"];
        DANewUserInfo *user = [DANewUserInfo sharedInstance];
        user.userID = userId;
        user.tell = self.tf_phone.text;
        [DANewUserInfo synchronize];
        [self.navigationController popToRootViewControllerAnimated:YES];
        sender.userInteractionEnabled = YES;
    } failure:^(id responObject) {
        sender.userInteractionEnabled = YES;
    } error:^(id error) {
        sender.userInteractionEnabled = YES;
    }];
    
}

#pragma mark -时间倒计时-
-(void)changeTime{
    
    _countTime --;
    NSString *timeString = [NSString stringWithFormat:@"%@(%ld)",@"重新发送",(long)_countTime];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:timeString];
    NSRange strRange = {0,[str length]};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    //此时如果设置字体颜色要这样
    [str addAttribute:NSForegroundColorAttributeName value:RGB(255, 131, 9)  range:strRange];
    //设置下划线颜色...
    [str addAttribute:NSUnderlineColorAttributeName value:RGB(255, 131, 9) range:strRange];
    [_btn_getVerifyCode setAttributedTitle:str forState:UIControlStateNormal];
    
    if (_countTime == 0)
    {
        [self.timerHandle invalidate];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"重新发送"];
        NSRange strRange = {0,[str length]};
        [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
        //此时如果设置字体颜色要这样
        [str addAttribute:NSForegroundColorAttributeName value:RGB(255, 131, 9)  range:strRange];
        //设置下划线颜色...
        [str addAttribute:NSUnderlineColorAttributeName value:RGB(255, 131, 9) range:strRange];
        [_btn_getVerifyCode setAttributedTitle:str forState:UIControlStateNormal];
        self.btn_getVerifyCode.userInteractionEnabled = YES;
        
        NSDate *datenow = [NSDate date];
        
        NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
        
        [[NSUserDefaults standardUserDefaults] setValue:timeSp forKeyPath:@"VerificationTime"];
        
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
