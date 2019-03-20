//
//  PthreadMutexConditionController.m
//  LockPractice
//
//  Created by lyy on 2019/3/19.
//  Copyright © 2019 lyy. All rights reserved.
//

#import "PthreadMutexConditionController.h"
#import <pthread.h>

@interface PthreadMutexConditionController ()

@property(assign,nonatomic)pthread_mutex_t mutex;
@property(assign,nonatomic)pthread_cond_t cond;
@property(strong,nonatomic)NSMutableArray *dataArray;

@end

/* pthread_cond_t  条件
 * pthread_cond_signal：激活一个等待条件cond的线程
 * pthread_cond_broadcast：激活所有等待条件cond的线程
 * pthread_cond_wait：等待条件cond，线程进入休眠状态并解锁mutex，待线程唤醒后会重新加锁线程往下继续执行
 */

@implementation PthreadMutexConditionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArray = NSMutableArray.array;
    [self initPthread];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self operateDataArray];
}

- (void)initPthread {
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr);
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
    // 初始化锁
    pthread_mutex_init(&_mutex, &attr);
    // 销毁属性
    pthread_mutexattr_destroy(&attr);
    pthread_cond_init(&_cond, NULL);
}

- (void)operateDataArray {
    [[[NSThread alloc]initWithTarget:self selector:@selector(removeItem) object:nil] start];
    sleep(.2);
    [[[NSThread alloc]initWithTarget:self selector:@selector(addItem) object:nil] start];
}

- (void)addItem {
    pthread_mutex_lock(&_mutex);
    [self.dataArray addObject:@"item"];
    NSLog(@"添加后：%@",self.dataArray);
    pthread_cond_signal(&_cond);
//    pthread_cond_broadcast(&_cond);
    pthread_mutex_unlock(&_mutex);
}

- (void)removeItem {
    pthread_mutex_lock(&_mutex);
    if (self.dataArray.count == 0) {
        NSLog(@"等待");
        pthread_cond_wait(&_cond, &_mutex);
    }
    [self.dataArray removeObject:@"item"];
    NSLog(@"移除后：%@",self.dataArray);
    pthread_mutex_unlock(&_mutex);
}

- (void)dealloc {
    pthread_cond_destroy(&(_cond));
    pthread_mutex_destroy(&(_mutex));
}

@end
