# YeahPDFTools
iOS PDF Read&amp;Cache

####需求：检查本地是否有需要查看的PDF文件，没有即下载缓存到本地(base64转码)，有则直接使用原生QLPreviewController打开，常规缓存方案。

#####YJPDFTools
```
/**
 *  IsExist 判断是否本地存在
 */
//IsExist
- (BOOL)isExistPdfFileWithBase:(UIViewController *)superVC file:(NSString *)fileName{
    
    //HomeDirectory
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //DocumentsName
    NSString *filePaths = [documentsDirectory stringByAppendingPathComponent:@"PdfDocuments"];
    if (![fileManager fileExistsAtPath:filePaths]) {
        [fileManager createDirectoryAtPath:filePaths withIntermediateDirectories:YES attributes:nil error:nil];
        return NO;
    }
    
    //FileName
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"PdfDocuments/%@",fileName]];
    
    if(![fileManager fileExistsAtPath:filePath]) {
        
        //Return To Download File
        return false;
        
    } else{
        
        //OpenLocalFile
        YJPDFReaderVC *readerVC = [YJPDFReaderVC new];
        readerVC.title = fileName;
        [readerVC setQLPreViewMethodWith:filePath];
        [superVC.navigationController pushViewController:readerVC animated:true];
        return true;
    }
}


/**
 *  Write  写入下载的PDF文件
 */
- (void)writeFileWith:(NSDictionary *)data completeBlock:(void(^)(void))completionHandler{
    
    NSDictionary *dataDic = data;
    NSString *fileName = [dataDic objectForKey:@"file_name"];
    NSString *base64String = [dataDic objectForKey:@"base64"];
    NSData *dataData = [[NSData alloc]initWithBase64EncodedString:base64String options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *strPath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"PdfDocuments/%@",fileName]];
    
    if ([dataData writeToFile:strPath atomically:YES]) {
        
        completionHandler();
    }
}


```
#####PDFReader
```
/**
 *  预览PDF文件
 *  urlSting:文件路径
 */
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
```
---
###使用：
```
- (void)loadPDFMethod{
    
    NSString *fileName = @"pdf20181204.pdf";
    
    BOOL isExist = [kPDFToolMgr isExistPdfFileWithBase:self file:fileName];
    
    if (!isExist) {
        
        NSLog(@"Not Exist,LoadingFile");

        //DownLoad
        NSDictionary *data = @{@"file_name":fileName,
                               @"base64":self.base64String
                               };
        [kPDFToolMgr writeFileWith:data completeBlock:^{
            
            if (![kPDFToolMgr isExistPdfFileWithBase:self file:fileName]) {
                NSLog(@"Load Error!");
            } else{
                NSLog(@"Load Success!");
            }
        }];

    } else{

        NSLog(@"Read Local File");
    }
}
```
