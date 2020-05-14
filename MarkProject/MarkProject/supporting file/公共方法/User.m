//
//  User.m
//  MarkProject
//
//  Created by 孙冬 on 2020/5/13.
//  Copyright © 2020 mac. All rights reserved.
//

#import "User.h"

@implementation User
+(MDInstance *)sharedInstance{
    static User *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance =[[self alloc]init];
    });
    return _sharedInstance;
}
@end
