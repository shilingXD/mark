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
@property (nonatomic, copy) NSString *DeviceID;///<设备ID

/*用户信息相关*/
@property (nonatomic, copy) NSString *objectID;///<bomb云中用户ID
@property (nonatomic, copy) NSString *Email;///<用户邮箱
@property (nonatomic, copy) NSString *UserName;///<用户名称
@property (nonatomic, copy) NSString *UserPassWord;///<用户密码
@property (nonatomic, strong) UIImage *headImage;///<用户头像
@property (nonatomic, copy) NSString *headImageURL;///<用户头像URL


/*主题相关*/
@property (nonatomic, strong) UIImage *billHeadImage;///<账单背景图片
@property (nonatomic, strong) UIColor *themeColor;///<主题颜色
/*首页*/
@property (nonatomic, assign) BOOL isOpenSoul;///<是否开启毒鸡汤

+(MDInstance *)sharedInstance;

+(void)setNSUserDefaults;
@end

NS_ASSUME_NONNULL_END
