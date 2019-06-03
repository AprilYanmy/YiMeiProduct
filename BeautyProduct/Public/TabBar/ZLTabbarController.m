//
//  ZLTabbarController.m
//  
//
//  Created by sammy on 2017/7/3.
//
//

#import "ZLTabbarController.h"

#import "DANewHomeVC.h"
#import "DANewDiaryVC.h"
#import "DANewInstitutionVC.h"
#import "BWMineVC.h"
#import "DAMasterVC.h"

#import "DANewTabButton.h"

#define EACH_W(A) ([UIScreen mainScreen].bounds.size.width/A)
#define EACH_H (self.tabBar.bounds.size.height)
#define BTNTAG 10000

static ZLTabbarController *tabbarVC;
@interface ZLTabbarController (){

    DANewTabButton *_button;

}

@end

@implementation ZLTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self initControllers];
    [self creatTabbar:self.viewControllers.count];
    
}

#pragma mark - 如果想添加控制器到tabbar里面在这里面实例化就行
- (void)initControllers
{
    
    NSString *Comecaode1 = [MyTool setObtainObject:Comecaode];
    
    if (Comecaode1==nil||Comecaode1.length==0||[Comecaode1 isEqualToString:@"(null)"]||[Comecaode1 isEqualToString:@"0"]) {
        
#pragma mark ————————————————主页
        DANewHomeVC *homeVC  = [[DANewHomeVC alloc]initWithNibName:@"DANewHomeVC" bundle:nil];
        self.navVC1 = [[UINavigationController alloc]initWithRootViewController:homeVC];
        
#pragma mark ————————————————日记
        DANewDiaryVC *diaryVC = [[DANewDiaryVC alloc]initWithNibName:@"DANewDiaryVC" bundle:nil];
        self.navVC2 = [[UINavigationController alloc] initWithRootViewController:diaryVC];
        
#pragma mark ————————————————机构
        DANewInstitutionVC *newsVC  = [[DANewInstitutionVC alloc]initWithNibName:@"DANewInstitutionVC" bundle:nil];
        self.navVC3 = [[UINavigationController alloc]initWithRootViewController:newsVC];
        
#pragma mark ————————————————我的
        BWMineVC *mineVC = [[BWMineVC alloc]initWithNibName:@"BWMineVC" bundle:nil];
        self.navVC4 = [[UINavigationController alloc] initWithRootViewController:mineVC];
        
    }else{
        
        //首页
        DAMasterVC *vc2 = [[DAMasterVC alloc] init];
        vc2.type = 2;
        self.navVC1 = [[UINavigationController alloc]initWithRootViewController:vc2];
        
        //日记
        DAMasterVC *vc3 = [[DAMasterVC alloc] init];
        vc3.type = 3;
        self.navVC2 = [[UINavigationController alloc]initWithRootViewController:vc3];
        
        //机构
        DAMasterVC *vc4 = [[DAMasterVC alloc] init];
        vc4.type = 4;
        self.navVC3 = [[UINavigationController alloc]initWithRootViewController:vc4];
        
#pragma mark ————————————————我的
        BWMineVC *mineVC = [[BWMineVC alloc]initWithNibName:@"BWMineVC" bundle:nil];
        self.navVC4 = [[UINavigationController alloc] initWithRootViewController:mineVC];
        
    }
    
    NSArray *ctrlArr = [NSArray arrayWithObjects:self.navVC1,self.navVC2,self.navVC3,self.navVC4,nil];
    
    self.viewControllers =ctrlArr;

    
    //  照着上面添加控制球就行了
}

- (void)creatTabbar:(NSInteger)ControllersNum
{
    
    //  只需要该图片名字就行
    NSArray * normImage = @[@"tabbar_home",@"tabbar_news",@"tabbar_find",@"tabbar_my"];
    //  只需修改选中图片的名字
    NSArray * selectImage = @[@"tabbar_homeSelect",@"tabbar_newsSelect",@"tabbar_findSelect",@"tabbar_mySelect"];
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, DownH)];
    bgView.backgroundColor =  [UIColor whiteColor];
    bgView.userInteractionEnabled = YES;
    for(int i = 0;i<self.viewControllers.count;i++)
    {
        DANewTabButton *btn = [DANewTabButton creatCustomTaBarNor:normImage[i]
                                                          withSel:selectImage[i]
                                                       withFrameX:(SCREEN_WIDTH/self.viewControllers.count)*i];
        btn.tag = BTNTAG+i;
        btn.showIndex = i;
        [bgView addSubview:btn];
        
        if(btn.tag == BTNTAG)
        {
            btn.isShowSelect = YES;
            _button = btn;
//            [self btnSelect:btn];
        }
        [btn addTarget:self action:@selector(btnSelect:) forControlEvents:UIControlEventTouchUpInside];

    }
    
//    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
//    line.backgroundColor = RGB(237, 237, 237);
//    [bgView addSubview:line];
//    
//    [self.view addSubview:bgView];
    
    UIView *line_center = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 5, 0.5, EACH_H-10)];
    line_center.backgroundColor = RGB(237, 237, 237);
//    [bgView addSubview:line_center];
    
    [self.tabBar addSubview:bgView];
    
    
}
- (void)btnSelect:(DANewTabButton *)sender
{
    _button.isShowSelect = NO ;
    sender.isShowSelect = YES;
    _button = sender;
    self.selectedIndex = sender.tag-BTNTAG;
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
