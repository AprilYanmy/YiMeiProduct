//
//  BWMineVC.m
//  MoneyManagerProject
//
//  Created by iMac-1 on 2018/6/19.
//  Copyright © 2018年 iOS_阿玮. All rights reserved.
//

#import "BWMineVC.h"
#import "WELoginVC.h"
#import "DAMessageVC.h"
#import "DAStarSMUserCenterVC.h"
#import "DAStarAWSettingVC.h"
#import "DAStarSMHomeAlertVC.h"
#import "MTWebViewVC.h"

#warning 修改为你自己的 appkey 和 appSecret。
static NSString * const kAppKey = @"24605817";
static NSString * const kAppSecret = @"6b84685c678d6b19fd2514235d90ad58";

@interface BWMineVC ()

@property (weak, nonatomic) IBOutlet BaseImageView *img_user;
@property (weak, nonatomic) IBOutlet UIButton *userNameBtn;
@property (nonatomic, strong) YWFeedbackKit *feedbackKit;
@property (weak, nonatomic) IBOutlet UIButton *logoutBtn;
@property (weak, nonatomic) IBOutlet UIView *line_View;
@property (weak, nonatomic) IBOutlet UILabel *lab_msg;

@end

@implementation BWMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"我的";
    
    [self aw___setRightBtnImagName:@"home_msgNor"];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self aw___showSystemNav];
    
    if ([DANewUserInfo isLogIn]) {
        
        self.lab_msg.hidden = self.line_View.hidden = YES;
        self.userNameBtn.hidden = NO;
        self.logoutBtn.hidden = NO;
        [self loadData];
        
    }else{
        
        self.img_user.image = [UIImage imageNamed:@"no_login"];
        [self.userNameBtn setTitle:@"点击登录" forState:(UIControlStateNormal)];
        self.lab_msg.hidden = self.line_View.hidden = NO;
        self.userNameBtn.hidden = YES;
        self.logoutBtn.hidden = YES;
        
    }
    
}

/**
 获取用户数据
 */
- (void)loadData{
    
    if (![DANewUserInfo sharedInstance].userID) {
        return;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[DANewUserInfo sharedInstance].userID forKey:@"id"];
    [DataRequest Post:[URLRequest url_getUserInfo] parametes:dic success:^(id responObject) {
        
        NSDictionary *data = [responObject objectForKey:@"data"];
        
        DANewUserInfo *user = [DANewUserInfo sharedInstance];
        
        NSString *nickName = [data objectForKey:@"nickName"];
        NSString *workStr = [data objectForKey:@"spouseSocialIdentity"];
        NSString *marriesStr = [data objectForKey:@"maritalStatus"];
        NSString *sexStr = [data objectForKey:@"sex"];
        NSString *phoneStr = [data objectForKey:@"phone"];
        NSString *brithStr = [data objectForKey:@"birthdayRoma"];
        
        user.userID = data[@"id"];
        if ([NSString isInputNil:nickName]) {
            user.nickName = [NSString aw___setNumberEncryption:phoneStr];
            [self.userNameBtn setTitle:user.nickName forState:UIControlStateNormal];
        }else{
            user.nickName = data[@"nickName"];
            [self.userNameBtn setTitle:user.nickName forState:UIControlStateNormal];
        }
        
        
        if ([NSString isInputNil:sexStr]) {
            user.sex = @"请点击选择";
        }else{
            user.sex = data[@"sex"];
        }
        
        if ([NSString isInputNil:workStr]) {
            user.workInfo = @"请点击选择";
        }else{
            
            switch ([workStr intValue]) {
                case 1:
                    user.workInfo = @"上班族";
                    break;
                case 2:
                    user.workInfo = @"个体户";
                    break;
                case 3:
                    user.workInfo = @"企业主";
                    break;
                case 4:
                    user.workInfo = @"学生";
                    break;
                case 5:
                    user.workInfo = @"其他";
                    break;
                default:
                    break;
            }
            
        }
        
        if ([NSString isInputNil:marriesStr]) {
            user.maritalStatus = @"请点击选择";
        }else{
            
            switch ([marriesStr intValue]) {
                case 1:
                    user.maritalStatus = @"已婚";
                    break;
                case 2:
                    user.maritalStatus = @"未婚";
                    break;
                case 3:
                    user.maritalStatus = @"离异";
                    break;
                    
                default:
                    break;
            }
            
        }
        
        if ([NSString isInputNil:sexStr]) {
            user.sex = @"请点击选择";
        }else{
            
            switch ([sexStr intValue]) {
                case 0:
                    user.sex = @"女";
                    break;
                case 1:
                    user.sex = @"男";
                    break;
                default:
                    break;
            }
            
        }
        
        //        if ([NSString isInputNil:emailStr]) {
        //            user.email = @"点击认证邮箱";
        //        }else{
        //            user.email = emailStr;
        //        }
        
        if ([NSString isInputNil:brithStr]) {
            user.birthday = @"请点击选择";
        }else{
            user.birthday = brithStr;
        }
        
        NSString *imgeStr = [data objectForKey:@"headPortrait"];
        if (![NSString isInputNil:imgeStr]) {
            user.user_headerUrl = imgeStr;
        }
        
        
        //登录 信息存储
        [DANewUserInfo synchronize];
        
        [self.img_user sd_setImageWithURL:[NSURL URLWithString:[DANewUserInfo sharedInstance].user_headerUrl]
                         placeholderImage:[UIImage imageNamed:@"no_login"]];
        
        
    } failure:^(id responObject) {
        
    } error:^(id error) {
        
    }];
    
}

#pragma mark  ———————————————————————————————————————————————— 个人中心  按钮跳转事件
- (IBAction)goToUserCenterClick:(UIButton *)sender {
    
    if (![DANewUserInfo isLogIn]) {
        WELoginVC *vc = [[WELoginVC alloc] initWithNibName:@"WELoginVC" bundle:nil];
        [self aw___pushViewController:vc];
        return;
    }
    DAStarSMUserCenterVC *vc = [[DAStarSMUserCenterVC alloc] initWithNibName:@"DAStarSMUserCenterVC" bundle:nil];
    [self aw___pushViewController:vc];
    
}

#pragma mark ———————————————————————————————————————————————— 设置中心
- (IBAction)goToSettingClick:(UIButton *)sender {
    
    if (![DANewUserInfo isLogIn]) {
        WELoginVC *vc = [WELoginVC new];
        [self aw___pushViewController:vc];
        return;
    }
    DAStarAWSettingVC *vc = [[DAStarAWSettingVC alloc] initWithNibName:@"DAStarAWSettingVC" bundle:nil];
    [self aw___pushViewController:vc];
    
}

#pragma mark ———————————————————————————————————————————————— 客服中心
- (IBAction)goToCustomerServiceClick:(UIButton *)sender {
    
    if (![DANewUserInfo isLogIn]) {
        WELoginVC *vc = [WELoginVC new];
        [self aw___pushViewController:vc];
        return;
    }
    
    [AFNRequestManager __request:(AWPost_request) urlstr:[URLRequest getToolsServices] requestData:@{@"appcode":AppCode,@"typeid":@"1",@"localcation":@"1"} completion:^(id responseObject, NSError *error) {
        
        if (!error && [responseObject[@"menu"] count] != 0) {
            MTWebViewVC *vc = [[MTWebViewVC alloc] init];
            vc.titleName = responseObject[@"menu"][0][@"name"];
            vc.typeStr = 2;
            vc.url = responseObject[@"menu"][0][@"url"];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }];
    
}

#pragma mark ———————————————————————————————————————————————— 意见反馈
- (IBAction)goToFeedbackClick:(UIButton *)sender {
    
    if (![DANewUserInfo isLogIn]) {
        WELoginVC *vc = [WELoginVC new];
        [self aw___pushViewController:vc];
        return;
    }
    
    // app名称
    NSString *app_Name = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    /** 设置App自定义扩展反馈数据 */
    self.feedbackKit.extInfo = @{@"loginTime":[[NSDate date] description],
                                 @"visitPath":@"登陆->关于->反馈",
                                 @"userid":[DANewUserInfo sharedInstance].userID,
                                 @"name":[DANewUserInfo sharedInstance].nickName,
                                 @"phone":[DANewUserInfo sharedInstance].tell,
                                 @"appName":app_Name,
                                 @"appCode":AppCode};
    
    __weak typeof(self) weakSelf = self;
    [self.feedbackKit makeFeedbackViewControllerWithCompletionBlock:^(YWFeedbackViewController *viewController, NSError *error) {
        if (viewController != nil) {
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
            [weakSelf presentViewController:nav animated:YES completion:nil];
            
            [viewController setCloseBlock:^(UIViewController *aParentController){
                [aParentController dismissViewControllerAnimated:YES completion:nil];
            }];
        } else {
            
            
        }
    }];

    
}

#pragma mark ———————————————————————————————————————————————— 退出app
- (IBAction)logoutAppClick:(UIButton *)sender {
    
    DAStarSMHomeAlertVC *vc = [[DAStarSMHomeAlertVC alloc] initWithNibName:@"DAStarSMHomeAlertVC" bundle:nil];
    vc.type = 0;
    [vc setBackBlock:^{
        [DANewUserInfo logout];
        [self viewWillAppear:NO];
    }];
    vc.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.8f];
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:vc animated:NO completion:nil];
    
}

#pragma mark getter
- (YWFeedbackKit *)feedbackKit {
    if (!_feedbackKit) {
        // SDK初始化，手动配置appKey/appSecret
        _feedbackKit = [[YWFeedbackKit alloc] initWithAppKey:kAppKey appSecret:kAppSecret];
        
        // 请从控制台下载AliyunEmasServices-Info.plist配置文件，并正确拖入工程
        //_feedbackKit = [[YWFeedbackKit alloc] autoInit];
    }
    return _feedbackKit;
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
