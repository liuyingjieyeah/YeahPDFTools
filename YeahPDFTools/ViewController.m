//
//  ViewController.m
//  YeahPDFTools
//
//  Created by 微品致远 on 2018/12/4.
//  Copyright © 2018年 liuyingjieyeah. All rights reserved.
//

#import "ViewController.h"

#import "YJPDFTools.h"

@interface ViewController ()

@property (nonatomic , strong) NSString *base64String;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 150, 50)];
    btn.center = self.view.center;
    [btn setBackgroundColor:[UIColor redColor]];
    [btn setTitle:@"LoadPDF" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(loadPDFMethod) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.masksToBounds = true;
    btn.layer.cornerRadius = 8.f;
    [self.view addSubview:btn];
    
}

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

- (NSString *)base64String{
    
    if(!_base64String){
        //FileData
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"pdf20181204" ofType:@"txt"];
        NSString *fileStr  = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        _base64String = fileStr;
    }
    return _base64String;
}


@end
