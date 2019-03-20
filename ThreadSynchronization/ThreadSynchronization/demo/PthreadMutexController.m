//
//  PthreadMutexController.m
//  LockPractice
//
//  Created by lyy on 2019/3/18.
//  Copyright © 2019 lyy. All rights reserved.
//

#import "PthreadMutexController.h"
#import <pthread.h>

@interface PthreadMutexController ()

@property(assign,nonatomic)pthread_mutex_t mutex;

/* pthread_mutex_t PTHREAD_MUTEX_DEFAULT "互斥锁"
 * 等待pthread_mutex_t锁的线程处于休眠状态而非忙等
 * 使用时需导入头文件 #import <pthread.h>
 */

@end

@implementation PthreadMutexController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initMutex:_mutex];
    __weak typeof(PthreadMutexController) *weakSelf = self;
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

/*  Mutex type attributes
 *
 *  #define PTHREAD_MUTEX_NORMAL        0
 *  #define PTHREAD_MUTEX_ERRORCHECK    1
 *  #define PTHREAD_MUTEX_RECURSIVE     2
 *  #define PTHREAD_MUTEX_DEFAULT       PTHREAD_MUTEX_NORMAL
 */
- (void)initMutex:(pthread_mutex_t)mutex {
    // 初始化属性
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr);
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_DEFAULT);
    // 初始化锁
    pthread_mutex_init(&mutex, &attr);
    // 销毁属性
    pthread_mutexattr_destroy(&attr);
    
    // 或
    // attr传入NULL代表 PTHREAD_MUTEX_DEFAULT
    //pthread_mutex_init(&mutex, NULL);
    
    // 尝试加锁
    // pthread_mutex_trylock(&mutex);
}

- (void)saveMoney {
    pthread_mutex_lock(&_mutex);
    [super saveMoney];
    pthread_mutex_unlock(&_mutex);
}

- (void)withDrayMoney {
    pthread_mutex_lock(&_mutex);
    [super withDrayMoney];
    pthread_mutex_unlock(&_mutex);
}

- (void)dealloc {
    pthread_mutex_destroy(&(_mutex));
}

@end
