//
//  NSRecursiveLockViewController.m
//  LockPractice
//
//  Created by lyy on 2019/3/18.
//  Copyright © 2019 lyy. All rights reserved.
//

#import "NSRecursiveLockController.h"

@interface NSRecursiveLockController ()

@property(strong,nonatomic)NSRecursiveLock *recursiveLock;

@end

@implementation NSRecursiveLockController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.recursiveLock = [[NSRecursiveLock alloc]init];
    [self recursive];
}


- (void)recursive {
    [self.recursiveLock lock];
    static int count = 0;
    NSLog(@"recursive:%d",count);
    if (count < 10) {
        count++;
        [self recursive];
    }
    [self.recursiveLock unlock];
}

@end
