//
//  OS_Unfair_LockController.m
//  LockPractice
//
//  Created by lyy on 2019/3/18.
//  Copyright © 2019 lyy. All rights reserved.
//

#import "OS_Unfair_LockController.h"
#import <os/lock.h>

@interface OS_Unfair_LockController ()

@property(assign,nonatomic)os_unfair_lock lock;

@end

/* os_unfair_lock
 * 用于取代不安全的OSSpinLock，iOS10之后开始支持
 * 等待os_unfair_lock的线程处于休眠状态而非忙等
 * 使用时需导入头文件 #import <os/lock.h>
 */

@implementation OS_Unfair_LockController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.lock = OS_UNFAIR_LOCK_INIT;
    __weak typeof(OS_Unfair_LockController) *weakSelf = self;
    dispatch_queue_t queue =  dispatch_queue_create("XL.LockPractice.ConcurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        for (int i = 0 ; i < 10; i++) {
            [weakSelf saveMoney];
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0 ; i < 10; i++) {
            [weakSelf withDrawMoney];
        }
    });
}


- (void)saveMoney {
    os_unfair_lock_lock(&_lock);
    [super saveMoney];
    os_unfair_lock_unlock(&_lock);
}

- (void)withDrawMoney {
    os_unfair_lock_lock(&_lock);
    [super withDrayMoney];
    os_unfair_lock_unlock(&_lock);
}

@end
