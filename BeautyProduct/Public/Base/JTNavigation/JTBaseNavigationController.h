//
//  JTBaseNavigationController.h
//  JTNavigationController
//
//  Created by Tian on 16/1/23.
//  Copyright © 2016年 TianJiaNan. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kDefaultBackImageName @"back"

@interface JTBaseNavigationController : UINavigationController

+ (instancetype)shareNavgationController;

@property (nonatomic, copy) NSArray<UIViewController *> *rootViewControllers;

@end
