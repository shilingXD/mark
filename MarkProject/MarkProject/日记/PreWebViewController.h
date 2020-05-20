//
//  PreWebViewController.h
//  MarkProject
//
//  Created by MAC on 2020/4/20.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PreWebViewController : UIViewController
- (void)refreshMarkdown:(NSString *)markdown WithCss:(NSString *)cssString;
@end

NS_ASSUME_NONNULL_END
