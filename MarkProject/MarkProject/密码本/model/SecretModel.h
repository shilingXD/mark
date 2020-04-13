//
//  SecretModel.h
//  MarkProject
//
//  Created by 孙冬 on 2020/3/25.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SecretModel : NSObject
@property (nonatomic, copy) NSString *Name;///<账号所属应用或网站
@property (nonatomic, copy) NSString *NameURL;///<网站地址
@property (nonatomic, copy) NSString *Account;///<账号
@property (nonatomic, copy) NSString *PassWord;///<密码
@property (nonatomic, copy) NSString *Note;///<备注
@property (nonatomic, copy) NSString *CreateTime;///<创建时间
@property (nonatomic, copy) NSString *UpdateTime;///<修改时间
@property (nonatomic, copy) NSString *currentTime;///<时间戳
@end

NS_ASSUME_NONNULL_END
