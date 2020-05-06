//
//  NSDictionary+Extension.m
//  MarkProject
//
//  Created by 孙冬 on 2020/5/6.
//  Copyright © 2020 mac. All rights reserved.
//

#import "NSDictionary+Extension.h"

@implementation NSDictionary (Extension)
/**
 处理字典中的null值，并转换成@“”
 
 @return 转换后的字典
 */
- (NSDictionary *)deleteNull{
    
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] init];
    for (NSString *keyStr in self.allKeys) {
        
        if ([[self objectForKey:keyStr] isEqual:[NSNull null]]) {
            
            [mutableDic setObject:@"" forKey:keyStr];
        }
        else{
            
            [mutableDic setObject:[self objectForKey:keyStr] forKey:keyStr];
        }
    }
    return mutableDic;
}
@end
