//
//  KeyChainStore.h
//  MarkProject
//
//  Created by 孙冬 on 2020/4/13.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KeyChainStore : NSObject
+ (void)save:(NSString*)service data:(id)data;
+ (id)load:(NSString*)service;
+ (void)deleteKeyData:(NSString*)service;
@end

NS_ASSUME_NONNULL_END

