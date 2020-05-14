//
//  MemoModel.h
//  MarkProject
//
//  Created by 孙冬 on 2020/5/14.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MemoModel : BaseModel
@property (nonatomic, copy) NSString *memoTitle;///<便签标题
@property (nonatomic, copy) NSString *memoContent;///<便签内容
@property (nonatomic, copy) NSString *memoColorHex;///<便签颜色
@end

NS_ASSUME_NONNULL_END
