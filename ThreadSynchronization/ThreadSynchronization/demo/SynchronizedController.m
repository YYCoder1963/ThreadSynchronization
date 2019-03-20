//
//  SynchronizedController.m
//  LockPractice
//
//  Created by lyy on 2019/3/18.
//  Copyright © 2019 lyy. All rights reserved.
//

#import "SynchronizedController.h"

@interface SynchronizedController ()

@end

@implementation SynchronizedController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    __weak typeof(SynchronizedController) *weakSelf = self;
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
    @synchronized (self.class) {
        [super saveMoney];
    }
}

- (void)withDrayMoney {
    @synchronized (self.class) {
        [super withDrayMoney];
    }
}

@end
