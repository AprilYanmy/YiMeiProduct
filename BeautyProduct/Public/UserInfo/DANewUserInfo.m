//
//  DAUserInfo.m
//  Divination
//
//  Created by iMac-1 on 2018/4/3.
//  Copyright © 2018年 iOS_阿玮. All rights reserved.
//

#import "DANewUserInfo.h"

//(注：本文将用户的信息，存储到Library文件中)
#define kEncodedObjectPath_User ([[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"user"])

@implementation DANewUserInfo

+ (instancetype)sharedInstance
{
    static DANewUserInfo *single = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if([DANewUserInfo isLogIn])
        {
            single = [NSKeyedUnarchiver unarchiveObjectWithFile:kEncodedObjectPath_User];
        }
        else
        {
            single = [[DANewUserInfo alloc] init];
        }
    });
    return single;
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"userID" : @"id"};
}

+ (BOOL)synchronize
{
    return [NSKeyedArchiver archiveRootObject:[DANewUserInfo sharedInstance] toFile:kEncodedObjectPath_User];
}

+ (BOOL)isLogIn
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:kEncodedObjectPath_User];
}


+ (BOOL)logout
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL result = [fileManager removeItemAtPath:kEncodedObjectPath_User error:&error];
    if(!result){
        
    }
    return result;
}

//把一个对象从解码器中取出
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        [self yy_modelInitWithCoder:aDecoder];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [self yy_modelEncodeWithCoder:aCoder];
}

@end
