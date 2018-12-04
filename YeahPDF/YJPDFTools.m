//
//  YJPDFTools.m
//  小移云店
//
//  Created by 微品致远 on 2018/11/23.
//  Copyright © 2018年 liuyingjieyeah. All rights reserved.
//

#import "YJPDFTools.h"
#import "YJPDFReaderVC.h"

@interface YJPDFTools ()

@end

@implementation YJPDFTools

+(instancetype)sharedTools{
    static YJPDFTools *_sharedTools = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedTools = [[YJPDFTools alloc]init];
    });
    return _sharedTools;
}

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

//Write
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


@end
