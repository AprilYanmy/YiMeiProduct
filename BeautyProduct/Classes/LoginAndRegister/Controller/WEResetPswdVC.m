//
//  WEResetPswdVC.m
//  PeoitELoanProject
//
//  Created by iMac-1 on 2017/9/8.
//  Copyright © 2017年 iOS_Awei. All rights reserved.
//

#import "WEResetPswdVC.h"

@interface WEResetPswdVC ()<UITextFieldDelegate>{
    NSString *defultStr1;
    NSString *defultStr2;
    NSString *changeStr1;
    NSString *changeStr2;
}

@property (weak, nonatomic) IBOutlet UITextField *tf_psw;
@property (weak, nonatomic) IBOutlet UITextField *tf_pswSure;

@end

@implementation WEResetPswdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"重置密码";
    self.tf_psw.delegate = self;
    self.tf_pswSure.delegate = self;
    defultStr1 = self.tf_psw.text;
    defultStr2 = self.tf_pswSure.text;
    
    
}

#pragma mark -- 重置密码
- (IBAction)commitClick:(UIButton *)sender {
    
    if (self.tf_psw.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    
    if (self.tf_psw.text.length < 6||self.tf_psw.text.length > 18) {
        [SVProgressHUD showErrorWithStatus:@"请输入6-18位密码"];
        return;
    }
    
    
    if (self.tf_pswSure.text.length==0) {
        [SVProgressHUD showErrorWithStatus:@"请再次输入密码"];
        return;
    }
    
    if (![self.tf_psw.text isEqualToString:self.tf_pswSure.text]) {
        
        [SVProgressHUD showErrorWithStatus:@"两次密码不相同"];
        return;
    }
    
    NSString *userId = [NSString stringWithFormat:@"%@",[MyTool setObtainObject:@"userid"]];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc] init];
    
    NSString *logo = [NSString stringWithFormat:@"appCode=%@...userid=%@....one=%@....two=%@...defult1=%@...defult2=%@...change1=%@...change2=%@",AppCode,userId,self.tf_psw.text,self.tf_pswSure.text,defultStr1,defultStr2,changeStr1,changeStr2];
    
    [dic1 setObject:logo forKey:@"content"];
    
    sender.userInteractionEnabled = NO;
    
    [DataRequest Post:[URLRequest url_pwdLogo] parametes:dic1 success:^(id responObject) {
        
    } failure:^(id responObject) {
        
    } error:^(id error) {
        
    }];
    
    
    [dic setObject:self.tf_pswSure.text forKey:@"pwd"];
    [dic setObject:userId forKey:@"id"];
    
    [DataRequest Post:[URLRequest url_setPwd] parametes:dic success:^(id responObject) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        sender.userInteractionEnabled = YES;
    } failure:^(id responObject) {
        sender.userInteractionEnabled = YES;
    } error:^(id error) {
        sender.userInteractionEnabled = YES;
    }];
    
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    //返回BOOL值，指定是否允许文本字段结束编辑，当编辑结束，文本字段会让出first responder
    //要想在用户结束编辑时阻止文本字段消失，可以返回NO
    //这对一些文本字段必须始终保持活跃状态的程序很有用，比如即时消息
    
    if (textField==self.tf_psw) {
        changeStr1 = textField.text;
    }else if(textField==self.tf_pswSure){
        changeStr2 = textField.text;
    }
    
    
    return YES;
}

#pragma mark --- 返回按钮点事件
- (void)leftBtn:(UIButton *)sender{
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
