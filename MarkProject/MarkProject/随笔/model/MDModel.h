//
//  MDModel.h
//  MarkProject
//
//  Created by MAC on 2020/4/20.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MDModel : NSObject
@property (nonatomic, assign) int MDID;///<随笔ID
@property (nonatomic, copy) NSString *Title;///<标题
@property (nonatomic, copy) NSString *Type;///<1文件2文件夹
@property (nonatomic, copy) NSString *FilePath;///<所属文件夹 如果没有所属文件夹首页展示
@property (nonatomic, copy) NSString *StoragePath;///<存储路径
@property (nonatomic, copy) NSString *CreateTime;///<创建时间
@property (nonatomic, copy) NSString *UpdateTime;///<修改时间
@property (nonatomic, copy) NSString *currentTime;///<时间戳
@end

NS_ASSUME_NONNULL_END
