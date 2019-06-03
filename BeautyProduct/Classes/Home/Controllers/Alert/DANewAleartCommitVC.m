//
//  DANewAleartCommitVC.m
//  BeautyProduct
//
//  Created by iMac-1 on 2018/9/6.
//  Copyright © 2018年 iOS_阿玮. All rights reserved.
//

#import "DANewAleartCommitVC.h"

@interface DANewAleartCommitVC ()

@property (weak, nonatomic) IBOutlet UITextField *tf_name;
@property (weak, nonatomic) IBOutlet UITextField *tf_tell;


@end

@implementation DANewAleartCommitVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"弹窗";
    
}

- (IBAction)cancleClick:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
}

- (IBAction)commitClick:(UIButton *)sender {
    
    if (self.tf_name.text.length > 8) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入真实姓名"];
        
        return;
    }

    if (self.tf_tell.text.length != 11) {
            
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
            
        return;
    }
    
    [SVProgressHUD showWithStatus:@"正在提交"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.888 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
         [SVProgressHUD showSuccessWithStatus:@"提交成功，客服将于2个小时内主动与您联系。"];
         [self dismissViewControllerAnimated:NO completion:nil];
        
    });
        

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
