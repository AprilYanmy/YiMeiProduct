//
//  WERegisterVC.m
//  PeoitELoanProject
//
//  Created by iMac-1 on 2017/9/8.
//  Copyright © 2017年 iOS_Awei. All rights reserved.
//

#import "WERegisterVC.h"
#import "MTWebViewVC.h"

@interface WERegisterVC ()

@property (weak, nonatomic) IBOutlet UITextField *tf_phone;
@property (weak, nonatomic) IBOutlet UITextField *tf_code;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UITextField *tf_psw;
@property (weak, nonatomic) IBOutlet UIButton *tongyiBtn;
@property (nonatomic, assign) NSInteger countTime;
@property (nonatomic, strong) NSTimer *timerHandle;

@end

@implementation WERegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"注册";
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"获取验证码"];
    NSRange strRange = {0,[str length]};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    //此时如果设置字体颜色要这样
    [str addAttribute:NSForegroundColorAttributeName value:ColorMainBG
                range:strRange];
    //设置下划线颜色...
    [str addAttribute:NSUnderlineColorAttributeName value:ColorMainBG
                range:strRange];
    [_codeBtn setAttributedTitle:str forState:UIControlStateNormal];
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
    
    self.codeBtn.userInteractionEnabled = NO;
    [DataRequest Post:[URLRequest url_getVerCode] parametes:@{@"phone":self.tf_phone.text,@"code":@"HXK"} success:^(id responObject) {
        
        NSInteger success = [[responObject objectForKey:@"success"] integerValue];
        
        if (success==1) {
            
            self.countTime = 60;
            self.codeBtn.titleLabel.numberOfLines = 2;
            self.timerHandle = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeTime) userInfo:nil repeats:YES];
            [self.timerHandle fire];
        }else{
            self.codeBtn.userInteractionEnabled = YES;
        }
        
    } failure:^(id responObject) {
        self.codeBtn.userInteractionEnabled = YES;
    } error:^(id error) {
        self.codeBtn.userInteractionEnabled = YES;
    }];
    
    
}
#pragma mark -- 查看服务
- (IBAction)lookServiceClick:(UIButton *)sender {
    MTWebViewVC *vc = [[MTWebViewVC alloc] initWithNibName:@"MTWebViewVC" bundle:nil];
    
    vc.titleName = @"用户注册协议";
    
    vc.typeStr = 2;
    
    vc.url = [URLRequest url_html:@"userRegisterAgreement"];
    
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark -- 同意条款
- (IBAction)agreerClick:(UIButton *)sender {
    sender.selected = ! sender.selected;
}
#pragma mark -- 注册
- (IBAction)registerClick:(UIButton *)sender {
    
    if (self.tf_phone.text.length==0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号码"];
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
    
    if (self.tongyiBtn.selected!=YES) {
        [SVProgressHUD showErrorWithStatus:@"未同意《用户注册协议》"];
        return;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:self.tf_phone.text forKey:@"phone"];
    
    [dic setObject:self.tf_code.text forKey:@"verCode"];
    
    [dic setObject:@"appStore" forKey:@"channelName"];
    
    [dic setObject:self.tf_psw.text forKey:@"pwd"];
    
    sender.userInteractionEnabled = NO;
    [DataRequest Post:[URLRequest url_register] parametes:dic success:^(id responObject) {
        
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

#pragma mark -- 返回
- (IBAction)backClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -时间倒计时-
-(void)changeTime{
    
    _countTime --;
    NSString *timeString = [NSString stringWithFormat:@"%@(%ld)",@"重新发送",(long)_countTime];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:timeString];
    NSRange strRange = {0,[str length]};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    //此时如果设置字体颜色要这样
    [str addAttribute:NSForegroundColorAttributeName value:ColorMainBG
                range:strRange];
    //设置下划线颜色...
    [str addAttribute:NSUnderlineColorAttributeName value:ColorMainBG
                range:strRange];
    [_codeBtn setAttributedTitle:str forState:UIControlStateNormal];
    
    if (_countTime == 0)
    {
        [self.timerHandle invalidate];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"重新发送"];
        NSRange strRange = {0,[str length]};
        [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
        //此时如果设置字体颜色要这样
        [str addAttribute:NSForegroundColorAttributeName value:ColorMainBG
                    range:strRange];
        //设置下划线颜色...
        [str addAttribute:NSUnderlineColorAttributeName value:ColorMainBG
                    range:strRange];
        [_codeBtn setAttributedTitle:str forState:UIControlStateNormal];
        self.codeBtn.userInteractionEnabled = YES;
        
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
