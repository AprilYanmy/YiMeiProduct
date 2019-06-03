//
//  DASettingVC.m
//  Divination
//
//  Created by iMac-1 on 2018/3/30.
//  Copyright © 2018年 iOS_阿玮. All rights reserved.
//

#import "DAStarAWSettingVC.h"
#import "MTWebViewVC.h"
#import "DAStarSMHomeAlertVC.h"

@interface DAStarAWSettingVC ()

@property (weak, nonatomic) IBOutlet UILabel *lab_version;
@property (weak, nonatomic) IBOutlet UIButton *logoutBtn;


@property (weak, nonatomic) IBOutlet UIView *aboutView;
@property (weak, nonatomic) IBOutlet UIView *statementView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *statementH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *aboutH;

@end

@implementation DAStarAWSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"设置";
    self.lab_version.text = [NSString getAPPVerson];
    
    NSString *Comecaode1 = [MyTool setObtainObject:Comecaode];
    if (Comecaode1==nil||Comecaode1.length==0||[Comecaode1 isEqualToString:@"(null)"]||[Comecaode1 isEqualToString:@"0"]) {
        
        
        
    }else{
        
       self.aboutView.hidden = self.statementView.hidden = YES;
        self.aboutH.constant = self.statementH.constant = 0;
        
        
    }
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    if ([DANewUserInfo isLogIn]) {
        
        self.logoutBtn.hidden = NO;
        
    }else{
        
        self.logoutBtn.hidden = YES;
        
    }
    
}

#pragma Mark ———————————————————————————————————————— 本地提醒
- (IBAction)pushManagerClick:(UIButton *)sender {
    
    sender.selected =! sender.selected;
    
}

#pragma mark ———————————————————————————————————————————————— 退出app
- (IBAction)logoutAppClick:(UIButton *)sender {
    
    DAStarSMHomeAlertVC *vc = [[DAStarSMHomeAlertVC alloc] initWithNibName:@"DAStarSMHomeAlertVC" bundle:nil];
    vc.type = 0;
    [vc setBackBlock:^{
        [DANewUserInfo logout];
        [self.logoutBtn setHidden:YES];
    }];
    vc.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.8f];
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:vc animated:NO completion:nil];
    
}

#pragma Mark ———————————————————————————————————————— 关于我们
- (IBAction)aboutUsClick:(UIButton *)sender {
    
    [AFNRequestManager __request:(AWPost_request) urlstr:[URLRequest getToolsServices] requestData:@{@"appcode":AppCode,@"typeid":@"3",@"localcation":@"1"} completion:^(id responseObject, NSError *error) {
        
        if (!error && [responseObject[@"menu"] count] != 0) {
            MTWebViewVC *vc = [[MTWebViewVC alloc] init];
            vc.titleName = @"关于我们";
            vc.typeStr = 2;
            vc.url = responseObject[@"menu"][0][@"url"];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }];
    
//    MTWebViewVC *vc = [[MTWebViewVC alloc] init];
//    vc.titleName = @"关于我们";
//    vc.typeStr = 2;
//    vc.url = [URLRequest url_html:@"about"];
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma Mark ———————————————————————————————————————— 免责声明
- (IBAction)disclaimerClick:(UIButton *)sender {
    
    MTWebViewVC *vc = [[MTWebViewVC alloc] init];
    vc.titleName = @"免责声明";
    vc.typeStr = 2;
    vc.url = [URLRequest url_html:@"disclaimer"];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
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
