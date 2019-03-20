//
//  NSConditionLockController.m
//  LockPractice
//
//  Created by lyy on 2019/3/18.
//  Copyright © 2019 lyy. All rights reserved.
//

#import "NSConditionLockController.h"

@interface NSConditionLockController ()

@property(strong,nonatomic)NSConditionLock *condintionLock;

@end

@implementation NSConditionLockController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.condintionLock = [[NSConditionLock alloc]initWithCondition:1];
    [self operations];
}

- (void)operations {
    [[[NSThread alloc]initWithTarget:self selector:@selector(operation1) object:nil] start];
    [[[NSThread alloc]initWithTarget:self selector:@selector(operation2) object:nil] start];
    [[[NSThread alloc]initWithTarget:self selector:@selector(operation3) object:nil] start];
}

- (void)operation1 {
    [self.condintionLock lockWhenCondition:1];
    NSLog(@"%s",__func__);
    sleep(1);
    [self.condintionLock unlockWithCondition:2];
}

- (void)operation2 {
    [self.condintionLock lockWhenCondition:2];
    NSLog(@"%s",__func__);
    sleep(1);
    [self.condintionLock unlockWithCondition:3];
}

- (void)operation3 {
    [self.condintionLock lockWhenCondition:3];
    NSLog(@"%s",__func__);
    sleep(1);
    [self.condintionLock unlock];
}

@end
