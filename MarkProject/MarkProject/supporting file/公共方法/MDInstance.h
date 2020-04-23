//
//  Instance.h
//  MarkProject
//
//  Created by 孙冬 on 2019/12/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MDInstance : NSObject

@property (nonatomic, assign) BOOL isLogin;///<是否登陆账号
@property (nonatomic, copy) NSString *UserID;///<用户ID
@property (nonatomic, copy) NSString *DeviceID;///<设备ID
@property (nonatomic, copy) NSString *UserName;///<用户名称
@property (nonatomic, copy) NSString *UserPassWord;///<用户密码
@property (nonatomic, copy) NSString *UserheadimageBase64;///<用户头像base64


/*主题相关*/

+(MDInstance *)sharedInstance;
@end

NS_ASSUME_NONNULL_END
