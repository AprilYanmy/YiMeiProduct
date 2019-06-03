//
//  AWBaseVC.m
//  AWDivinationProduct
//
//  Created by iMac-1 on 2018/5/16.
//  Copyright © 2018年 iOS_阿玮. All rights reserved.
//

#import "AWBaseVC.h"
//#import "WELoginVC.h"
#import "DAMessageVC.h"

@interface AWBaseVC ()<UIGestureRecognizerDelegate,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewT;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHA;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewD;

AWAssign(BOOL, isNoScroll);


@end

@implementation AWBaseVC


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if ([self.detailNews intValue] == 1) {
        
        [MobClick beginLogPageView:@"咨询详情"];
        
    }else{
        
        [MobClick beginLogPageView:self.navigationItem.title];
        
    }
    if (self.navigationController.viewControllers.count > 1) {
        
        [self setLeftBtnImag];
        
    }else{
        
        if (![self.navigationItem.title isEqualToString:@"城市"] &&
            ![self.navigationItem.title isEqualToString:@"星座运势"]) {
            
            [self aw___setRightBtnImagName:@"home_msgNor"];
            
        }
        
    }

    //隐藏黑线
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    if ([self.detailNews intValue] == 1) {
        [MobClick beginLogPageView:@"咨询详情"];
    }else{
        [MobClick beginLogPageView:self.navigationItem.title];
    }
    
}

- (void)aw___hideSystemNav{
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

- (void)aw___showSystemNav{
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
}

- (void)setDetailNews:(NSString *)detailNews{
    
    _detailNews = detailNews;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.scroll.delegate = self;
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    self.navigationController.navigationBar.translucent = NO;//设置导航栏透明度 NO表示不透明
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];//改变系统按钮的线条颜色
    self.navigationController.navigationBar.barTintColor = ColorMainBG;//改变导航栏的背景颜色

    self.navigationController.navigationBar.translucent = NO;//设置导航栏透明度 NO表示不透明
        
    self.view.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    
    // 设置导航默认标题的颜色及字体大小
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:FontS(18),
       NSForegroundColorAttributeName:[UIColor whiteColor]}];

    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;      // 手势有效设置为YES  无效为NO
        self.navigationController.interactivePopGestureRecognizer.delegate = self;    // 手势的代理设置为self
    }
    
    if (@available(iOS 11.0, *)) {
        self.scroll.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self aw___statusBarStyle:YES];
    
    self.viewT.constant = TopH;
    
    self.viewD.constant = DownH;
    
    if (IPHONEX) {
        self.topHA.constant = 40;
    }
    
    
}

- (void)aw___statusBarStyle:(BOOL)isWhiteColor{
    if (isWhiteColor) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }else{
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }
}

- (void)setLeftBtnImag{
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0);
    [leftBtn setImage:[UIImage imageNamed:@"nav_left"] forState:(UIControlStateNormal)];
    [leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
}

- (void)aw___setLeftBtnImagName:(NSString *)img{
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0);
    [leftBtn setImage:[UIImage imageNamed:img] forState:(UIControlStateNormal)];
    [leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
}

- (void)leftBtnClick:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)aw___setRightBtnImagName:(NSString *)img{
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
    [rightBtn setImage:[UIImage imageNamed:img] forState:(UIControlStateNormal)];
    [rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
}

/**
 顶部导航右侧按钮设置 --- 文字
 
 */
- (void)aw___setRightBtnStrName:(NSString *)str{
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
    rightBtn.titleLabel.font = FontS(16);
    [rightBtn setTitle:str forState:(UIControlStateNormal)];
    [rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
}

- (void)rightBtnClick:(UIButton *)sender{
    
    if (self.navigationController.viewControllers.count==1) {
        if (![DANewUserInfo isLogIn]) {
            //WELoginVC *vc = [WELoginVC new];
            //vc.hidesBottomBarWhenPushed = YES;
            //[self.navigationController pushViewController:vc animated:YES];
            return;
        }
        DAMessageVC *vc = [DAMessageVC new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        if (self.navigationController.viewControllers.count==1) {
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
    }
    
}


/**
 视图跳转方法

 */
- (void)aw___pushViewController:(UIViewController *)controller{
    
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (self.isNoScroll) {
        if (scrollView.contentOffset.y <= 0 ) {
            //[scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        }
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
