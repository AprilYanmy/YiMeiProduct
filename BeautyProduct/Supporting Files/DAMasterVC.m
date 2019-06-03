//
//  DAMasterVC.m
//  Divination
//
//  Created by iMac-1 on 2018/3/28.
//  Copyright © 2018年 iOS_阿玮. All rights reserved.
//

#import "DAMasterVC.h"

#import "MTWebViewVC.h"

#import "WELoginVC.h"

@interface DAMasterVC () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
/** 进度条 */
@property (nonatomic,strong) UIProgressView  * progressView;
@property (assign, nonatomic) NSUInteger       loadCount;
@property (assign, nonatomic) NSInteger       loadNumber;
@property (weak, nonatomic) IBOutlet UIScrollView *mainView;

@end

@implementation DAMasterVC

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];

    [self aw___setLeftBtnImagName:@"nav_left"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"Beautiful More";
    
    if (self.type == 1) {
        
        [self showView];
        
        NSString *grabUrl1 = [MyTool setObtainObject:HomeEmptyUrl];
        
        self.navigationItem.title = [NSString aw___getAppName];
        
        NSURLRequest *quest = [NSURLRequest requestWithURL:[NSURL URLWithString:grabUrl1]];
        
        [self.webView loadRequest:quest];
        
        self->_webView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
             [self.webView loadRequest:quest];
            
        }];
        
        return;
    }
    
    [_mainView removeFromSuperview];
    [self showView];
    
}

#pragma mark - ***** 导航栏的反回按钮
- (void)leftBtnClick:(UIButton *)sender{
    

    if (self.webView.canGoBack) {
        
        [self.webView goBack];
        
        if (self.navigationItem.leftBarButtonItems.count == 1) {
            [self aw___setLeftBtnImagName:@"nav_left"];
        }
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)backBtnAction:(UIButton *)sender{
    
    
}

#pragma mark 关闭按钮点击
- (void)colseBtnAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)showView{
    
    _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _webView.backgroundColor = [UIColor clearColor];
    /*! 适应屏幕 */
    _webView.scalesPageToFit = YES;
    /*! 解决iOS9.2以上黑边问题 */
    _webView.opaque = NO;
    /*! 关闭多点触控 */
    _webView.multipleTouchEnabled = YES;
    /*! 加载网页中的电话号码，单击可以拨打 */
    _webView.dataDetectorTypes = YES;
    _webView.delegate = self;
    _webView.hidden = NO;
    
    
}


#pragma mark - ***** UIWebViewDelegate
#pragma mark 计算webView进度条
- (void)setLoadCount:(NSUInteger)loadCount
{
    if (loadCount == 0)
    {
        self.progressView.hidden = YES;
        [self.progressView setProgress:0 animated:NO];
    }
    else
    {
        self.progressView.hidden = NO;
        CGFloat oldP = self.progressView.progress;
        CGFloat newP = (1.0 - oldP) / (loadCount + 1) + oldP;
        if (newP > 0.95)
        {
            newP = 0.95;
        }
        [self.progressView setProgress:newP animated:YES];
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@" ===== 111111");
    [self.webView.scrollView.mj_header endRefreshing];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.loadCount = 0;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.webView.scrollView.mj_header endRefreshing];
    
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.webView.scrollView.mj_header endRefreshing];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

//设置请求头
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    return YES;
}

#pragma mark - 懒加载  Lazy Load
- (UIProgressView *)progressView{
    if (_progressView == nil) {
        UIProgressView *progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        progressView.frame = CGRectMake(0, 0, self.view.frame.size.width, 10);
        progressView.trackTintColor = [UIColor clearColor];
        [progressView setTintColor:[UIColor colorWithRed:0.400 green:0.863 blue:0.133 alpha:1.000]];
        [self.webView addSubview:progressView];
        self.progressView = progressView;
    }
    return _progressView;
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
