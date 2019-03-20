//
//  NSLockViewController.m
//  LockPractice
//
//  Created by lyy on 2019/3/18.
//  Copyright © 2019 lyy. All rights reserved.
//

#import "NSLockViewController.h"

@interface NSLockViewController ()
@property(strong,nonatomic)NSLock *lock;
@end

@implementation NSLockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.lock = [[NSLock alloc]init];
    
    __weak typeof(NSLockViewController) *weakSelf = self;
    dispatch_queue_t queue =  dispatch_queue_create("XL.LockPractice.ConcurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        for (int i = 0 ; i < 10; i++) {
            [weakSelf saveMoney];
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0 ; i < 10; i++) {
            [weakSelf withDrayMoney];
        }
    });
    
}

- (void)saveMoney {
    [self.lock lock];
    [super saveMoney];
    [self.lock unlock];
}

- (void)withDrayMoney {
    [self.lock lock];
    [super withDrayMoney];
    [self.lock unlock];
}


@end
