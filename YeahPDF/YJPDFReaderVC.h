//
//  YJPDFReaderVC.h
//  小移云店
//
//  Created by 微品致远 on 2018/11/26.
//  Copyright © 2018年 liuyingjieyeah. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJPDFReaderVC : UIViewController

/**
 *  预览PDF文件
 *  urlSting:文件路径
 */
- (void)setQLPreViewMethodWith:(NSString *)urlString;

@end

NS_ASSUME_NONNULL_END
