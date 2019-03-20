
//
//  BaseViewController.m
//  LockPractice
//
//  Created by lyy on 2019/3/18.
//  Copyright © 2019 lyy. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.balance = 100;
    self.view.backgroundColor = UIColor.whiteColor;

    UILabel *tips = [UILabel new];
    tips.text = @"请查看控制台打印结果";
    tips.frame = CGRectMake(0, 0, 200, 50);
    tips.center = self.view.center;
    [self.view addSubview:tips];
}

- (void)saveMoney {
    sleep(.2);
    self.balance += 100;
    NSLog(@"\n存钱后余额：%d",self.balance);
}

- (void)withDrayMoney {
    sleep(.2);
    if (self.balance >= 100) {
        self.balance -= 100;
        NSLog(@"\n取钱后余额：%d",self.balance);
    }else {
        NSLog(@"\n余额不足,取款失败");
    }
    
}

@end
