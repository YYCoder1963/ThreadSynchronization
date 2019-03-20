//
//  PthreadMutexRecursiveController.m
//  LockPractice
//
//  Created by lyy on 2019/3/19.
//  Copyright © 2019 lyy. All rights reserved.
//

#import "PthreadMutexRecursiveController.h"
#import <pthread.h>

@interface PthreadMutexRecursiveController ()

@property(assign,nonatomic)pthread_mutex_t mutex;

@end

/* pthread_mutex_t PTHREAD_MUTEX_RECURSIVE "递归锁"
 * 对于同一个个线程可以重复加锁，解锁，对于多个线程，线程1加锁，线程2等待线程1解锁后方可加锁
 * 使用时需导入头文件 #import <pthread.h>
 */

@implementation PthreadMutexRecursiveController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initMutex:_mutex];
    
//    [self recursive];
    
    __weak typeof(PthreadMutexRecursiveController) *weakSelf = self;
    dispatch_queue_t queue =  dispatch_queue_create("XL.LockPractice.ConcurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        for (int i = 0 ; i < 10; i++) {
            [weakSelf multiThreadRecursive];
        }
    });

    dispatch_async(queue, ^{
        for (int i = 0 ; i < 10; i++) {
            [weakSelf multiThreadRecursive];
        }
    });
}

- (void)initMutex:(pthread_mutex_t)mutex {
    // 初始化属性
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr);
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
    // 初始化锁
    pthread_mutex_init(&mutex, &attr);
    // 销毁属性
    pthread_mutexattr_destroy(&attr);
}

- (void)recursive {
    pthread_mutex_lock(&_mutex);
    static int count = 0;
    NSLog(@"recursive:%d",count);
    if (count < 10) {
        count++;
        [self recursive];
    }
    pthread_mutex_unlock(&_mutex);
}

- (void)multiThreadRecursive {
    pthread_mutex_lock(&_mutex);
    NSLog(@"recursive:%@",[NSThread currentThread]);
    pthread_mutex_unlock(&_mutex);
}

- (void)dealloc {
    pthread_mutex_destroy(&(_mutex));
}

@end
