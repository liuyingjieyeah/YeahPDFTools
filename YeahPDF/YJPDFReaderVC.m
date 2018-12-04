//
//  YJPDFReaderVC.m
//  小移云店
//
//  Created by 微品致远 on 2018/11/26.
//  Copyright © 2018年 liuyingjieyeah. All rights reserved.
//

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define NavHeight 64

#import "YJPDFReaderVC.h"

#import <QuickLook/QuickLook.h>

@interface YJPDFReaderVC ()<QLPreviewControllerDataSource,QLPreviewControllerDelegate>

@property (strong, nonatomic) QLPreviewController *qlpreView;

@property (nonatomic , strong) NSURL *pdfUrl;

@end

@implementation YJPDFReaderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)setQLPreViewMethodWith:(NSString *)urlString{
    
    self.pdfUrl = [NSURL fileURLWithPath:urlString];
    [self addChildViewController:self.qlpreView];
    [self.view addSubview:self.qlpreView.view];
}

#pragma mark - Delegate

#pragma mark - 返回文件的个数
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller {
    return 1;
}

#pragma mark - 即将要退出浏览文件时执行此方法
- (void)previewControllerWillDismiss:(QLPreviewController *)controller {
}


#pragma mark - 在此代理处加载需要显示的文件
- (NSURL *)previewController:(QLPreviewController *)previewController previewItemAtIndex:(NSInteger)idx
{
    return self.pdfUrl;
}


- (QLPreviewController *)qlpreView{
    if (!_qlpreView) {
        _qlpreView = [[QLPreviewController alloc]init];
        _qlpreView.view.frame = CGRectMake(0, NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-NavHeight);
        _qlpreView.delegate = self;
        _qlpreView.dataSource = self;
    }
    return _qlpreView;
}


@end
