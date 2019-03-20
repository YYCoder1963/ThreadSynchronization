//
//  ViewController.m
//  ThreadSynchronization
//
//  Created by lyy on 2019/3/20.
//  Copyright © 2019 lyy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(copy,nonatomic)NSArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.dataArray = @[@"OSSpinLockController",@"OS_Unfair_LockController",@"PthreadMutexController",@"PthreadMutexRecursiveController",@"PthreadMutexConditionController",@"DispatchSemaphoreController",@"DispatchSerialQueueController",@"NSLockViewController",@"NSRecursiveLockController",@"NSConditionController",@"NSConditionLockController",@"SynchronizedController"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseId = @"lcok";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Class class = NSClassFromString(self.dataArray[indexPath.row]);
    UIViewController *vc = [class new];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
