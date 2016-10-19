//
//  NextViewController.m
//  JuChatMessage
//
//  Created by Juvid on 2016/10/19.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import "NextViewController.h"

@interface NextViewController ()

@end

@implementation NextViewController

- (void)viewDidLoad {
    self.view.backgroundColor=[UIColor whiteColor];

    UIImageView *ImageView01 = [[UIImageView alloc] init];
    [ImageView01 setFrame:CGRectMake(90, 190, 120, 180)];
    [ImageView01 setImage:[UIImage imageNamed:@"timg.jpeg"]];
    [self.view addSubview:ImageView01];

    UIImage *bubble = [UIImage imageNamed:@"consult_RightBubble"];
    UIImageView *imageBubble = [[UIImageView alloc] init];
    [imageBubble setFrame:ImageView01.frame];
    [imageBubble setImage:[bubble stretchableImageWithLeftCapWidth:15 topCapHeight:15]];

    CALayer *layer              = imageBubble.layer;
    layer.frame                 = (CGRect){{0,0},ImageView01.layer.frame.size};

    ImageView01.layer.mask = layer;
    [ImageView01 setNeedsDisplay];
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
