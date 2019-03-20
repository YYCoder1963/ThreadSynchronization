//
//  DispatchSerialQueueController.m
//  LockPractice
//
//  Created by lyy on 2019/3/18.
//  Copyright © 2019 lyy. All rights reserved.
//

#import "DispatchSerialQueueController.h"

@interface DispatchSerialQueueController ()

@property(strong,nonatomic)dispatch_queue_t serialQueue;


@end

@implementation DispatchSerialQueueController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.serialQueue = dispatch_queue_create("XL.ThreadSynchronization", NULL);
    for (int i = 0 ; i < 10; i++) {
        [self saveMoney];
        [self withDrayMoney];
    }
}

- (void)saveMoney {
    dispatch_sync(self.serialQueue, ^{
        [super saveMoney];
    });
}

- (void)withDrayMoney {
    
    dispatch_sync(self.serialQueue, ^{
        [super withDrayMoney];
    });
}

@end
