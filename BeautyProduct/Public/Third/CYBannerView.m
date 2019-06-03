//
//  CYBannerView.m
//  茶语
//
//  Created by zqc on 16/8/24.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBannerView.h"
#import "UIImageView+WebCache.h"

@interface CYBannerView ()
/** 外面加层UIView*/
@property (nonatomic,strong) UIView *divView;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) SMPageControl *pageControl;
@property (nonatomic,strong) UIView *titView;
@property (nonatomic,strong) UILabel *typeLbl;
@property (strong,nonatomic) UILabel *titleLbl;
@property (nonatomic,strong) UILabel *pageLbl;
/** 当前图片索引*/
@property (nonatomic,assign) NSInteger imgIndexOf;
/** 定时器*/
@property (nonatomic,strong) NSTimer *timer;
/** 回调block*/
@property (nonatomic,copy) void (^block)(void);
@property (nonatomic,copy) void (^changeBlock)(void);

@property (nonatomic,assign) float oldContentOffsetX;
@property (nonatomic,assign) NSInteger imgCount;
@end

@implementation CYBannerView

#pragma mark -- 初始化
- (instancetype)initWithFrame:(CGRect)frame pageType:(CYPageType)pageType bannerArr:(NSMutableArray *)bannerArr{
    if (self = [super init]) {
        self.frame = frame;
        [self addSubview:self.scrollView];
        self.pageType = pageType;
        if (self.pageType!=1) {
            [self addSubview:self.titView];
            [self.titView addSubview:self.typeLbl];
            [self.titView addSubview:self.titleLbl];
            [self.titView addSubview:self.pageLbl];
        }else{
            if (bannerArr.count!=1) {
                [self addSubview:self.pageControl];
            }

        }
        if (bannerArr.count!=0) {
           
        
            
            //显示无限循环的效果，先在数组最后添加第一组数据
            [(NSMutableArray *)bannerArr addObject:bannerArr[0]];
            _bannerArr = bannerArr;
            self.imgCount = bannerArr.count;
            self.pageControl.currentPage=0;
            for (int i=0; i<bannerArr.count; i++) {
                UIImageView *imgView = [[UIImageView alloc]init];
                NSString *url = [[_bannerArr objectAtIndex:i] objectForKey:@"picture"];
                if (url.length!=0) {
                    if (self.pageType ==1 ) {
                        [imgView sd_setImageWithURL:[NSURL URLWithString:url]];
                    }else{
                        [imgView sd_setImageWithURL:[NSURL URLWithString:url]];
                    }
                }
                imgView.contentMode = UIViewContentModeScaleToFill;
                imgView.clipsToBounds = YES;
                imgView.frame = CGRectMake(i*self.width, 0, self.width, self.height);
                [self.scrollView addSubview:imgView];
                
            }
            
            
            self.scrollView.contentSize = CGSizeMake(self.width*bannerArr.count, 0);
            self.pageControl.numberOfPages = bannerArr.count-1;
            [self addImgClick];
            if (bannerArr.count!=2) {
                [self startTimer];
                self.scrollView.scrollEnabled = YES;
            }else{
                self.scrollView.scrollEnabled = NO;
            }
        }
        
    }
    return self;
}

- (void)setShowType:(NSInteger)showType{
    
    _showType = showType;
    
}

- (void)setBannerArr:(NSMutableArray *)bannerArr
{
  
    [self stopTimer];
    [self.scrollView removeFromSuperview];
    [self addSubview:self.scrollView];
    if (self.pageType!=1) {
        [self addSubview:self.titView];
        [self.titView addSubview:self.typeLbl];
        [self.titView addSubview:self.titleLbl];
        [self.titView addSubview:self.pageLbl];
    }else{
        if (bannerArr.count!=1) {
            [self addSubview:self.pageControl];
        }
    }
    
    
    if (bannerArr.count==0) {
        return;
    }
    
    //显示无限循环的效果，先在数组最后添加第一组数据
    [(NSMutableArray *)bannerArr addObject:bannerArr[0]];
    _bannerArr = bannerArr;
    self.imgCount = bannerArr.count;
    self.pageControl.currentPage=0;
    for (int i=0; i<bannerArr.count; i++) {
        UIImageView *imgView = [[UIImageView alloc]init];
        NSString *url = @"";
        if (_showType == 1) {
            url = [_bannerArr objectAtIndex:i];
        }else{
            url = [[_bannerArr objectAtIndex:i] objectForKey:@"picture"];
        }
        
        if (url.length!=0) {
            [imgView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"detail_noPic"]];
        }
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.clipsToBounds = YES;
        imgView.frame = CGRectMake(i*self.frame.size.width, 0, self.width, self.height);
        [self.scrollView addSubview:imgView];
    }
    

    self.scrollView.contentSize = CGSizeMake(self.width*bannerArr.count, 0);
    self.pageControl.numberOfPages = bannerArr.count-1;
    [self addImgClick];
    if (bannerArr.count!=2) {
        [self startTimer];
        self.scrollView.scrollEnabled = YES;
    }else{
        self.scrollView.scrollEnabled = NO;
    }
    
}

- (instancetype)initWithFrame:(CGRect)frame pageType:(CYPageType)pageType bannerArr:(NSMutableArray *)bannerArr useTimer:(BOOL)useTimer currentIndex:(NSInteger)currentIndex
{
    if (self = [super init]) {
        self.frame = frame;
        [self addSubview:self.scrollView];
        self.pageType = pageType;
        if (self.pageType == 2) {
            [self addSubview:self.titView];
            [self.titView addSubview:self.typeLbl];
            [self.titView addSubview:self.titleLbl];
            [self.titView addSubview:self.pageLbl];
        }else if(self.pageType == 1)
        {
            [self addSubview:self.pageControl];
        }
        
        //显示无限循环的效果，先在数组最后添加第一组数据
        [(NSMutableArray *)bannerArr addObject:bannerArr[0]];
        _bannerArr = bannerArr;
        self.imgCount = bannerArr.count;
        self.pageControl.currentPage=0;
        for (int i=0; i<bannerArr.count; i++) {
            UIImageView *imgView = [[UIImageView alloc]init];
            NSString *url = [[_bannerArr objectAtIndex:i] objectForKey:@"picture"];
            if (url.length!=0) {
                if (self.pageType ==1 ) {
                    [imgView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"logo"]];
                }else{
                    [imgView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"logo"]];
                }
            }
            imgView.contentMode = UIViewContentModeScaleAspectFill;
            imgView.clipsToBounds = YES;
            imgView.frame = CGRectMake(i*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
            [self.scrollView addSubview:imgView];
        }
        
        
        self.scrollView.contentSize = CGSizeMake(self.frame.size.width*bannerArr.count, 0);
        self.pageControl.numberOfPages = bannerArr.count-1;
        
        self.pageControl.currentPage = currentIndex;//momo

        [self addImgClick];
        
        if(useTimer)
        {
            [self startTimer];
        }
        else
        {
            [self.scrollView setContentOffset:CGPointMake((self.pageControl.currentPage)*self.width, 0) animated:YES];
        }
    }
    return self;
}

#pragma mark -- 代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint point = scrollView.contentOffset;
    BOOL isRight = self.oldContentOffsetX < point.x;
    self.oldContentOffsetX = point.x;
    // 开始显示最后一张图片的时候切换到第二个图
    if (point.x > self.width*(self.imgCount-2)+self.width*0.5 && !self.timer) {
        self.pageControl.currentPage = 0;
    }else if (point.x > self.width*(self.imgCount-2) && self.timer && isRight){
        self.pageControl.currentPage = 0;
    }else{
        self.pageControl.currentPage = (point.x + self.width*0.5) / self.width;
    }
    
    [self changeIndex:self.pageControl.currentPage];
    
    // 开始显示第一张图片的时候切换到倒数第二个图
    if (point.x >= self.width*(self.imgCount-1)) {
        [_scrollView setContentOffset:CGPointMake(self.width+point.x-self.width*self.imgCount, 0) animated:NO];
    }else if (point.x < 0) {
        [scrollView setContentOffset:CGPointMake(point.x+self.width*(self.imgCount-1), 0) animated:NO];
    }
    
    if(self.changeBlock)
    {
        self.changeBlock();
    }
}


-(void)changeIndex:(NSInteger)index
{
    if (_bannerArr.count) {
        
            self.pageLbl.text = [NSString stringWithFormat:@"%li/%lu",index+1,(unsigned long)_bannerArr.count-1];
        
    }
    
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self stopTimer];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self startTimer];
}
#pragma mark -- 定时器
- (void)startTimer
{
    self.timer = [NSTimer timerWithTimeInterval:4 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (void)nextPage
{
    [self.scrollView setContentOffset:CGPointMake((self.pageControl.currentPage+1)*self.width, 0) animated:YES];
}
- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark -- 点击图片
-(void)touchImageIndexBlock:(void (^)(NSInteger))block{
    __block CYBannerView *men = self;
    self.block = ^(){
        if (block) {
            block((men.pageControl.currentPage));
        }
    };
}

- (void)changePageBlock:(void (^)(NSInteger))block
{
    __block CYBannerView * men = self;
    self.changeBlock = ^()
    {
        if(block)
        {
            block(men.pageControl.currentPage);
        }
    };
}

- (void)addImgClick{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgClick)];
    [self.scrollView addGestureRecognizer:tap];
}
- (void)imgClick{
    if (self.block) {
        self.block();
    }
}
#pragma mark -- 懒加载
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.contentOffset = CGPointMake(0, 0);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        self.imgIndexOf = 1;
        _scrollView.delegate = self;
    }
    return _scrollView;
}
- (SMPageControl *)pageControl{
    if (!_pageControl) {
  
        CGRect rect = CGRectMake(0, self.height-30, self.width, 30);
        self.pageControl = [[SMPageControl alloc] initWithFrame:rect];
        self.pageControl.backgroundColor = [UIColor clearColor];
        self.pageControl.currentPage = 0;
        self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    

    }
    return _pageControl;
}


- (UIView *)titView{
    if (!_titView) {
        CGRect rect = CGRectMake(0, self.height-28, self.width, 28);
        self.titView = [[UIView alloc] initWithFrame:rect];
        self.titView.backgroundColor = RGBA(0, 0, 0, 0.5f);
    }
    
    return _titView;
}


- (UILabel *)typeLbl{
    if (!_typeLbl) {
        CGRect rect = CGRectMake(0, 0, 48, 28);
        self.typeLbl = [[UILabel alloc] initWithFrame:rect];
        self.typeLbl.font = [UIFont systemFontOfSize:11.0f];
        self.typeLbl.textColor = [UIColor whiteColor];
        self.typeLbl.textAlignment = NSTextAlignmentCenter;
        self.typeLbl.backgroundColor = RGBA(137, 62, 32, 1.0f);
    }
    
    return _typeLbl;
}

- (UILabel *)titleLbl{
    if (!_titleLbl) {
        CGRect rect = CGRectMake(58, 3, self.width-58-50, 21);
        self.titleLbl = [[UILabel alloc] initWithFrame:rect];
        self.titleLbl.font = [UIFont systemFontOfSize:14.0f];
        self.titleLbl.textColor = [UIColor whiteColor];
        self.titleLbl.textAlignment = NSTextAlignmentLeft;
        self.titleLbl.backgroundColor = [UIColor clearColor];
    }
    
    return _titleLbl;
}


- (UILabel *)pageLbl{
    if (!_pageLbl) {
        CGRect rect = CGRectMake(SCREEN_WIDTH-40, 0, 40, 28);
        self.pageLbl = [[UILabel alloc] initWithFrame:rect];
        self.pageLbl.font = [UIFont systemFontOfSize:11.0f];
        self.pageLbl.textColor = [UIColor whiteColor];
        self.pageLbl.textAlignment = NSTextAlignmentCenter;
        self.pageLbl.backgroundColor = [UIColor clearColor];
    }
    
    return _pageLbl;
}

//-(void)changePage:(UIPageControl *)sender {
////    _curPage = self.pageControl.currentPage;
////    [self loadData];
//}




@end
