//
//  YJPDFTools.h
//  小移云店
//
//  Created by 微品致远 on 2018/11/23.
//  Copyright © 2018年 liuyingjieyeah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define kPDFToolMgr ([YJPDFTools sharedTools])

@interface YJPDFTools : NSObject

+(instancetype)sharedTools;

/**
 *  IsExist
 */
- (BOOL)isExistPdfFileWithBase:(UIViewController *)superVC file:(NSString *)fileName;


/**
 *  Write
 */
- (void)writeFileWith:(NSDictionary *)data completeBlock:(void(^)(void))completionHandler;

@end

NS_ASSUME_NONNULL_END
