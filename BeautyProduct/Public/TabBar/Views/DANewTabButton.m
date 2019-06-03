//
//  DANewTabButton.m
//  BeautyProduct
//
//  Created by iMac-1 on 2018/8/30.
//  Copyright © 2018年 iOS_阿玮. All rights reserved.
//

#import "DANewTabButton.h"

#define TabarCount 4.0

@interface DANewTabButton ()

@end

@implementation DANewTabButton

+ (instancetype)creatCustomTaBarNor:(NSString *)norImageName withSel:(NSString *)selImageName withFrameX:(NSInteger)x{
    
    return [[self alloc] initWithFrame:CGRectMake(x, 0, SCREEN_WIDTH/TabarCount, 49) withNorStr:norImageName withSelStr:selImageName withFrameX:x];
    
}

- (instancetype)initWithFrame:(CGRect)frame withNorStr:(NSString *)norStr withSelStr:(NSString *)selStr withFrameX:(NSInteger)x{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self creatTabarViewNorStr:norStr
                        withSelStr:selStr];
        
        [self addTarget:self
                 action:@selector(customClick)
         
       forControlEvents:(UIControlEventTouchUpOutside)];
        
    }
    return self;
    
}

- (void)creatTabarViewNorStr:(NSString *)norStr withSelStr:(NSString *)selStr{
    
    UIImage *norImg = [UIImage imageNamed:norStr];
    UIImage *selImg = [UIImage imageNamed:selStr];
    
    self.norImageView = [[UIImageView alloc] initWithImage:norImg];
    self.norImageView.frame = CGRectMake((self.width-norImg.size.width)/2, (self.height-norImg.size.height)/2, norImg.size.width, norImg.size.height);
    self.norImageView.alpha = 1;
    [self addSubview:self.norImageView];
    
    self.selImageView = [[UIImageView alloc] initWithImage:selImg];
    self.selImageView.bounds = CGRectMake((self.width-selImg.size.width)/2, (self.height-selImg.size.height)/2, selImg.size.width, selImg.size.height);
    self.selImageView.alpha = 0;
    
    [self addSubview:self.selImageView];
    
    
}

- (void)setShowIndex:(NSInteger)showIndex{
    
    _showIndex = showIndex;
    
    switch (showIndex) {
        case 0:
            self.selImageView.center = CGPointMake(self.norImageView.center.x,self.norImageView.center.y-2);
            break;
        case 1:
            self.selImageView.center = CGPointMake(self.norImageView.center.x,self.norImageView.center.y-4);
            break;
        case 2:
            self.selImageView.center = CGPointMake(self.norImageView.center.x-2,self.norImageView.center.y-2);
            break;
        case 3:
            self.selImageView.center = CGPointMake(self.norImageView.center.x-1,self.norImageView.center.y-2);
            break;
        default:
            break;
    }
    
}

- (void)setIsShowSelect:(BOOL)isShowSelect{
    
    _isShowSelect = isShowSelect;
    
    if (self.isShowSelect) {
        self.selImageView.alpha = 1;
        self.norImageView.alpha = 0;
    }else{
        self.selImageView.alpha = 0;
        self.norImageView.alpha = 1;
    }
    
}


- (void)customClick{
    
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
