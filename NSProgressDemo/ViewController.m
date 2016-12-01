//
//  ViewController.m
//  NSProgressDemo
//
//  Created by csdc-iMac on 2016/12/1.
//  Copyright © 2016年 Cloudox. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSProgress *progress;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    // 创建实例
    self.progress = [NSProgress progressWithTotalUnitCount:10];
    // 配置KVO观察
    [self.progress addObserver:self forKeyPath:@"fractionCompleted" options:NSKeyValueObservingOptionNew context:nil];
    
    
    // 单任务——————————
    // 每秒执行一次任务
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(doTask) userInfo:nil repeats:YES];
    // ————————————————
    
    /*
    // 多任务——————————
    // 第一个子任务
    [self.progress becomeCurrentWithPendingUnitCount:5];
    [self subTask];
    [self.progress resignCurrent];// 必须与 becomeCurrentWithPendingUnitCount: 方法成对
    
    // 第二个子任务
    [self.progress becomeCurrentWithPendingUnitCount:5];
    [self subTask];
    [self.progress resignCurrent];// 必须与 becomeCurrentWithPendingUnitCount: 方法成对
    // ————————————————
    
    
    // iOS 9 开始支持的多任务方式————————
    NSProgress *sub1 = [NSProgress progressWithTotalUnitCount:10 parent:self.progress pendingUnitCount:4];
    NSProgress *sub2 = [NSProgress progressWithTotalUnitCount:10 parent:self.progress pendingUnitCount:6];
    for (int i = 0; i < 10; i++) {
        sub1.completedUnitCount ++;
        sub2.completedUnitCount ++;
    }
    // ————————————————————————————————
    */
    
}

// 单任务——————————————————
- (void)doTask {
    if (self.progress.completedUnitCount < self.progress.totalUnitCount) {
        self.progress.completedUnitCount ++;
    }
}
// ————————————————————————

// 多任务————————————————————
- (void)subTask {
    NSProgress *subProgress = [NSProgress progressWithTotalUnitCount:10];
    while (subProgress.completedUnitCount < subProgress.totalUnitCount) {
        subProgress.completedUnitCount ++;
    }
}
// ————————————————————————

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"fractionCompleted"]) {
        NSLog(@"进度表示形式1：%f", self.progress.fractionCompleted);
        NSLog(@"进度表示形式2：%@", self.progress.localizedDescription);
        NSLog(@"进度表示形式3：%@", self.progress.localizedAdditionalDescription);
        NSLog(@"=============================");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
