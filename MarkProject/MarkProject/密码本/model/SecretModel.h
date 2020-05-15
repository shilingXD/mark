//
//  SecretModel.h
//  MarkProject
//
//  Created by 孙冬 on 2020/3/25.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SecretModel : BaseModel
@property (nonatomic, copy) NSString *Name;///<账号所属应用或网站
@property (nonatomic, copy) NSString *NameURL;///<网站地址
@property (nonatomic, copy) NSString *Account;///<账号
@property (nonatomic, copy) NSString *PassWord;///<密码
@property (nonatomic, copy) NSString *Note;///<备注
@end

NS_ASSUME_NONNULL_END
