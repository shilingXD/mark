//
//  Instance.m
//  MarkProject
//
//  Created by 孙冬 on 2019/12/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import "Instance.h"

@implementation Instance
+(Instance *)sharedInstance{
    static Instance *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance =[[self alloc]init];
    });
    return _sharedInstance;
}
@end
