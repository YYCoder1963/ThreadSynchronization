//
//  OSSpinLockLockController.m
//  LockPractice
//
//  Created by lyy on 2019/3/18.
//  Copyright © 2019 lyy. All rights reserved.
//


#import "OSSpinLockController.h"
#import <libkern/OSAtomic.h>

@interface OSSpinLockController ()

@property(assign,nonatomic)OSSpinLock lock;

/*
 * OSSpinLock
 * "自旋锁"，等待锁的线程会处于忙等状态，一直占用CPU资源
 * 现在已经不再安全，苹果已经弃用，可能会出现优先级翻转问题
 * 如果等待锁的线程优先级高，它会一直占用CPU资源，导致优先级从线程无法释放锁
 * 使用时需导入头文件 #import <libkern/OSAtomic.h>
 */

@end

@implementation OSSpinLockController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.lock = OS_SPINLOCK_INIT;
    __weak typeof(OSSpinLockController) *weakSelf = self;
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
    
    OSSpinLockLock(&_lock);
//    sleep(.2);
//    self.balance += 100;
//    NSLog(@"\n余额：%d",self.balance);
    [super saveMoney];
    OSSpinLockUnlock(&_lock);
}

- (void)withDrawMoney {
//
//    sleep(.2);
//    if (self.balance < 100) {
//        NSLog(@"余额不足");
//        return;
//    }
    OSSpinLockLock(&_lock);
    [super withDrayMoney];
//    self.balance -= 100;
//    NSLog(@"\n余额：%d",self.balance);
    OSSpinLockUnlock(&_lock);
}

@end
