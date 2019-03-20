//
//  BaseViewController.h
//  LockPractice
//
//  Created by lyy on 2019/3/18.
//  Copyright © 2019 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

@property(assign,nonatomic)int balance;

- (void)saveMoney;

- (void)withDrayMoney;

@end

NS_ASSUME_NONNULL_END
