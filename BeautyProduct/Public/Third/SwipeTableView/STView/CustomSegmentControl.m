//
//  CustomSegmentControl.m
//  SwipeTableView
//
//  Created by Roy lee on 16/5/28.
//  Copyright © 2016年 Roy lee. All rights reserved.
//

#import "CustomSegmentControl.h"
#import "UIView+STFrame.h"

@interface CustomSegmentControl ()

@property (nonatomic, strong) UIView * contentView;
@property (nonatomic, strong) NSArray * items;
@property (nonatomic, strong) UIView * lineView;

@end

@implementation CustomSegmentControl

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithItems:(NSArray *)items {
    self = [self initWithFrame:CGRectZero];
    if (self) {
        if (items.count > 0) {
            self.items = items;
        }
    }
    return self;
}

- (void)commonInit {
    _contentView = [UIView new];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_contentView];
    _font = [UIFont systemFontOfSize:15];
    _textColor = RGBColor(50, 50, 50);
    _selectedTextColor = RGBColor(0, 0, 0);
    _selectionIndicatorColor = RGBColor(150, 150, 150);
    _items = @[@"Segment0",@"Segment1"];
    _selectedSegmentIndex = 0;
    

}

- (void)layoutSubviews {
    [super layoutSubviews];
    for (UIView *subView in _contentView.subviews) {
        [subView removeFromSuperview];
    }
    UIView *gaylineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-0.5, SCREEN_WIDTH, 0.5)];
    gaylineView.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    [self addSubview:gaylineView];
    
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/_items.count/2, 2)];
    _lineView.backgroundColor = ColorMainBG;//[UIColor colorWithHexString:@"508cec"];
    [self addSubview:_lineView];
    
    _contentView.backgroundColor = _backgroundColor;
    _contentView.frame = self.bounds;
    for (int i = 0; i < _items.count; i ++) {
        UIButton * itemBt = [UIButton buttonWithType:UIButtonTypeCustom];
        itemBt.tag = 666 + i;
        [itemBt setTitleColor:_textColor forState:UIControlStateNormal];
        [itemBt setTitleColor:_selectedTextColor forState:UIControlStateSelected];
        [itemBt setTitle:_items[i] forState:UIControlStateNormal];
        [itemBt.titleLabel setFont:_font];
        CGFloat itemWidth = self.st_width/_items.count;
        itemBt.st_size = CGSizeMake(itemWidth, self.st_height);
        itemBt.st_x    = itemWidth * i;
        if (i == _selectedSegmentIndex) {
            itemBt.backgroundColor = _selectionIndicatorColor;
            itemBt.selected = YES;
            _lineView.center = CGPointMake(itemBt.center.x, itemBt.center.y+18);

        }else {
            itemBt.backgroundColor = [UIColor clearColor];
        }
        [itemBt addTarget:self action:@selector(didSelectedSegment:) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:itemBt];
    }
}

- (void)setSelectedSegmentIndex:(NSInteger)selectedSegmentIndex {
    UIButton * oldItemBt      = [_contentView viewWithTag:666 + _selectedSegmentIndex];
    oldItemBt.backgroundColor = [UIColor clearColor];
    oldItemBt.selected        = NO;
    
    UIButton * itemBt      = [_contentView viewWithTag:666 + selectedSegmentIndex];
    itemBt.backgroundColor = _selectionIndicatorColor;
    itemBt.selected        = YES;
    _selectedSegmentIndex  = selectedSegmentIndex;
    
    _lineView.center = CGPointMake(itemBt.center.x, itemBt.center.y+18);
    
}

- (void)didSelectedSegment:(UIButton *)itemBt {
    UIButton * oldItemBt      = [_contentView viewWithTag:666 + _selectedSegmentIndex];
    oldItemBt.backgroundColor = [UIColor clearColor];
    oldItemBt.selected        = NO;
    
    itemBt.backgroundColor = _selectionIndicatorColor;
    itemBt.selected        = YES;
    _selectedSegmentIndex  = itemBt.tag - 666;
    if (self.IndexChangeBlock) {
        self.IndexChangeBlock(_selectedSegmentIndex);
    }
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    
    _lineView.center = CGPointMake(itemBt.center.x, itemBt.center.y+18);
}

@end





