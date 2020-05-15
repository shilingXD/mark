//
//  BaseModel.h
//  MarkProject
//
//  Created by 孙冬 on 2020/5/8.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseModel : NSObject
@property (nonatomic, assign) NSInteger ID;///<编号
@property (nonatomic, assign) NSInteger createdAt;///<创建时间戳
@property (nonatomic, assign) NSInteger updatedAt;///<更新时间戳

/// 创建所有的表
+(void)createTableIfNoExit;
+(void)deleteWithTableName:(NSString *)str deleteID:(NSInteger)deleteID;
@end

NS_ASSUME_NONNULL_END
