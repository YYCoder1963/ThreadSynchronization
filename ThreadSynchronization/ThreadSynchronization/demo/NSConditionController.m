//
//  NSConditionViewController.m
//  LockPractice
//
//  Created by lyy on 2019/3/18.
//  Copyright © 2019 lyy. All rights reserved.
//

#import "NSConditionController.h"

@interface NSConditionController ()

@property(strong,nonatomic)NSCondition *condition;
@property(strong,nonatomic)NSMutableArray *dataArray;

@end

@implementation NSConditionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.condition = [[NSCondition alloc]init];
    self.dataArray = NSMutableArray.array;
    [self operateDataArray];
}

- (void)operateDataArray {
    [[[NSThread alloc]initWithTarget:self selector:@selector(removeItem) object:nil] start];
    sleep(.2);
    [[[NSThread alloc]initWithTarget:self selector:@selector(addItem) object:nil] start];
}

- (void)addItem {
    [self.condition lock];
    [self.dataArray addObject:@"item"];
    NSLog(@"add item");
    [self.condition signal];
    [self.condition unlock];
}

- (void)removeItem {
    [self.condition lock];
    if (self.dataArray.count == 0) {
        NSLog(@"wait");
        [self.condition wait];
    }
    [self.dataArray removeObject:@"item"];
    NSLog(@"remove item");
    [self.condition unlock];
}

@end
