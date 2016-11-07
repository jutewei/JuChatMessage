//
//  TestViewController.m
//  JuChatMessage
//
//  Created by Juvid on 2016/10/20.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import "TestViewController.h"
#import "UIView+JuLayGroup.h"
@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    NSArray *arr=@[@"gfdgfd"];
    NSMutableArray *Marr=[arr copy];
    if ([Marr isKindOfClass:[NSMutableArray class]]) {
        NSLog(@"可变数组1");
    }
    if ([Marr isMemberOfClass:[NSMutableArray class]]) {
        NSLog(@"可变数组2");
    }

   UIActivityIndicatorView *_ju_sendStatus=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.view addSubview:_ju_sendStatus];
    [_ju_sendStatus startAnimating];
    _ju_sendStatus.juCenterX.equal(0);
    _ju_sendStatus.juCenterY.equal(0);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
