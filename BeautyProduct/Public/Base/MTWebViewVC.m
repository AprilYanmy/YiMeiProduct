//
//  MTWebViewVC.m
//  MakeTea
//
//  Created by cy on 2016/12/22.
//  Copyright © 2016年 cy. All rights reserved.
//

#import "MTWebViewVC.h"
#import <WebKit/WebKit.h>

static void *KINWebBrowserContext = &KINWebBrowserContext;

@interface MTWebViewVC ()<WKNavigationDelegate, WKUIDelegate,UIScrollViewDelegate>{
  
}

// The main and only UIProgressView
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong) NSTimer *fakeProgressTimer;
@property (nonatomic, assign) BOOL uiWebViewIsLoading;
@property (nonatomic, strong) NSURL *uiWebViewCurrentURL;
@property (nonatomic, strong) NSURL *URLToLaunchWithPermission;
@property (nonatomic, strong) UIAlertView *externalAppPermissionAlertView;
@end

@implementation MTWebViewVC

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self aw___showSystemNav];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = _titleName;
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    // 设置偏好设置
    config.preferences = [[WKPreferences alloc] init];
    // 默认为0
    config.preferences.minimumFontSize = 10;
    // 默认认为YES
    config.preferences.javaScriptEnabled = YES;
    // 在iOS上默认为NO，表示不能自动通过窗口打开
    config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    
    self.wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) configuration:config];
//    [self.wkWebView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    self.wkWebView.scrollView.delegate = self;
    [self.wkWebView setNavigationDelegate:self];
    [self.wkWebView setUIDelegate:self];
    [self.wkWebView setMultipleTouchEnabled:YES];
    [self.wkWebView setAutoresizesSubviews:YES];
    [self.wkWebView.scrollView setAlwaysBounceVertical:YES];
    [self.view addSubview:self.wkWebView];
//    self.wkWebView.scrollView.bounces = NO;
    [self.wkWebView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:KINWebBrowserContext];
    

    if (_typeStr==1) {
        
        if (_url.length!=0) {
            [self.wkWebView loadHTMLString:_url baseURL:nil];
            self.wkWebView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                [self.wkWebView loadHTMLString:self->_url baseURL:nil];
            }];
        }
        
    }else if(_typeStr==2){
        
        if (_url.length!=0) {
            _url = [NSString stringWithFormat:@"%@?appCode=%@&xyOrQh=%@&oldOrNewH5=%@",_url,AppCode,Poatform,NewHTML];
            NSURLRequest *_request=[NSURLRequest  requestWithURL:[NSURL URLWithString:_url]];
            [self.wkWebView loadRequest:_request];
            self.wkWebView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                [self.wkWebView loadRequest:_request];
            }];
        }
        
    }else{
        

        if (_url.length!=0) {
            NSURLRequest *_request=[NSURLRequest  requestWithURL:[NSURL URLWithString:_url]];
            [self.wkWebView loadRequest:_request];
            self.wkWebView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                [self.wkWebView loadRequest:_request];
            }];
        }
    }
    
    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    [self.progressView setTrackTintColor:[UIColor colorWithWhite:1.0f alpha:0.0f]];
    [self.progressView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.progressView.size.height)];
    
    //设置进度条颜色
    [self.progressView setTintColor:[UIColor colorWithRed:0.400 green:0.863 blue:0.133 alpha:1.000]];
    [self.view addSubview:self.progressView];
    
    if (@available(iOS 11.0, *)) {
        self.wkWebView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
}


- (void)leftBtn:(UIButton *)sender{
    
    if (self.wkWebView.goBack) {
        [self.wkWebView goBack];
    }else{
        if (_type==1) {
            [self.navigationController popToRootViewControllerAnimated:YES];
            return;
        }else if (_type==2){
            UIViewController *viewCtl = self.navigationController.viewControllers[1];
            [self.navigationController popToViewController:viewCtl animated:YES];
            return;
        }
        
        [self.navigationController popViewControllerAnimated:YES];

    }
}

- (void)deleteBtn:(UIButton *)sender{
    
    if (_type==1) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        return;
    }else if (_type==2){
        UIViewController *viewCtl = self.navigationController.viewControllers[1];
        [self.navigationController popToViewController:viewCtl animated:YES];
        return;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBtnClick:(UIButton *)sender{
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //    //清除cookies
    //    NSHTTPCookie *cookie;
    //    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    //    for (cookie in [storage cookies]){
    //        [storage deleteCookie:cookie];
    //    }
    //    //清除UIWebView的缓存
    //    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    //    NSURLCache * cache = [NSURLCache sharedURLCache];
    //    [cache removeAllCachedResponses];
    //    [cache setDiskCapacity:0];
    //    [cache setMemoryCapacity:0];
    
}


#pragma mark - WKNavigationDelegate


- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [self.wkWebView.scrollView.mj_header endRefreshing];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self.wkWebView.scrollView.mj_header endRefreshing];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
      withError:(NSError *)error {
 
    [self.wkWebView.scrollView.mj_header endRefreshing];
    
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation
      withError:(NSError *)error {
 
    [self.wkWebView.scrollView.mj_header endRefreshing];
    
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    
    if(webView == self.wkWebView) {
        
        NSURL *URL = navigationAction.request.URL;
        
        NSString *urlStr = [NSString stringWithFormat:@"%@",URL];
        
        NSArray *array = [urlStr componentsSeparatedByString:@"://"];
        
        NSString *name = [array objectAtIndex:0];
        if ([name isEqualToString:@"qq"]) {
            NSString *retStr = [array objectAtIndex:1];
            NSString *word = [retStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            [pasteboard setString:word];
            
            [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
            [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
            [SVProgressHUD showInfoWithStatus:@"QQ号码已复制到剪贴板，请添加"];
        }else if ([name isEqualToString:@"wx"]) {
            NSString *retStr = [array objectAtIndex:1];
            NSString *word = [retStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            [pasteboard setString:word];
            
            [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
            [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
            [SVProgressHUD showInfoWithStatus:@"微信公众号已复制到剪贴板，请添加"];
        }
//        else if ([name isEqualToString:@"tel"]) {
//            NSString *retStr = [array objectAtIndex:1];
//            NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"tel:%@",retStr];
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
//        }
        
        
        if(![self externalAppRequiredToOpenURL:URL]) {
            if(!navigationAction.targetFrame) {
                [self.wkWebView loadRequest:[NSURLRequest requestWithURL:URL]];
                decisionHandler(WKNavigationActionPolicyCancel);
                return;
            }
            [self callback_webViewShouldStartLoadWithRequest:navigationAction.request navigationType:navigationAction.navigationType];
            
        }
        else if([[UIApplication sharedApplication] canOpenURL:URL]) {
            [self launchExternalAppWithURL:URL];
            [[UIApplication sharedApplication] openURL:URL];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    
    [self.wkWebView.scrollView.mj_header endRefreshing];
    
    decisionHandler(WKNavigationActionPolicyAllow);
    
    
}

-(BOOL)callback_webViewShouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(NSInteger)navigationType
{
    return YES;
}


#pragma mark - WKUIDelegate

- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}
#pragma mark - Estimated Progress KVO (WKWebView)

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self.wkWebView) {
        [self.progressView setAlpha:1.0f];
        BOOL animated = self.wkWebView.estimatedProgress > self.progressView.progress;
        [self.progressView setProgress:self.wkWebView.estimatedProgress animated:animated];
        
        // Once complete, fade out UIProgressView
        if(self.wkWebView.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


#pragma mark - External App Support

- (BOOL)externalAppRequiredToOpenURL:(NSURL *)URL {
    NSSet *validSchemes = [NSSet setWithArray:@[@"http", @"https",@"file"]];
    return ![validSchemes containsObject:URL.scheme];
}

- (void)launchExternalAppWithURL:(NSURL *)URL {
    self.URLToLaunchWithPermission = URL;
    if (![self.externalAppPermissionAlertView isVisible]) {
        [self.externalAppPermissionAlertView show];
    }
    
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if(alertView == self.externalAppPermissionAlertView) {
        if(buttonIndex != alertView.cancelButtonIndex) {
            [[UIApplication sharedApplication] openURL:self.URLToLaunchWithPermission];
        }
        self.URLToLaunchWithPermission = nil;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //禁止左右滑动左右
    // 让webview的内容一直居中显示
    scrollView.contentOffset = CGPointMake((scrollView.contentSize.width - SCREEN_WIDTH) / 2, scrollView.contentOffset.y);
    
}

#pragma mark - Dealloc

- (void)dealloc {
    [self.wkWebView setNavigationDelegate:nil];
    [self.wkWebView setUIDelegate:nil];
    [self.wkWebView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
    
}

@end
