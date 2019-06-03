//
//  DAUpdataAlertVC.m
//  Divination
//
//  Created by iMac-1 on 2018/4/11.
//  Copyright © 2018年 iOS_阿玮. All rights reserved.
//

#import "DAUpdataAlertVC.h"

@interface DAUpdataAlertVC ()

@end

@implementation DAUpdataAlertVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     [self aw___hideSystemNav];
    self.navigationItem.title = @"更新弹窗";
}

/** 去App商城  */
- (IBAction)goToAppStoreClick:(UIButton *)sender {
    
    if (self.backBlock) {
        self.backBlock(1);
    }
    [self dismissViewControllerAnimated:NO completion:nil];
    
}

/** 取消  */
- (IBAction)canleClick:(UIButton *)sender {
    
    if (self.backBlock) {
        self.backBlock(0);
    }
    [self dismissViewControllerAnimated:NO completion:nil];
    
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
