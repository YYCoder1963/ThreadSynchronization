//
//  DispatchSemaphoreController.m
//  LockPractice
//
//  Created by lyy on 2019/3/18.
//  Copyright © 2019 lyy. All rights reserved.
//

#import "DispatchSemaphoreController.h"

@interface DispatchSemaphoreController ()

@property(strong,nonatomic)dispatch_semaphore_t semaphore;


@end

@implementation DispatchSemaphoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.semaphore  = dispatch_semaphore_create(1);
    
    __weak typeof(DispatchSemaphoreController) *weakSelf = self;
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
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    [super saveMoney];
    dispatch_semaphore_signal(self.semaphore);
}

- (void)withDrayMoney {
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    [super withDrayMoney];
    dispatch_semaphore_signal(self.semaphore);
}

@end
