//
//  JuChatMoreView.m
//  JuChatMessage
//
//  Created by Juvid on 2018/9/18.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import "JuChatMoreView.h"
#import "UIView+JuLayGroup.h"
#define Window_Width        [[UIScreen mainScreen] bounds].size.width
@implementation JuChatMoreView
-(instancetype)init{
    self=[super init];
    if (self) {
        [self shSubViews];
    }
    return self;
}
-(void)shSubViews{
    self.backgroundColor=[UIColor whiteColor];
    NSArray *arrTitle=@[@"照片",@"拍照",@"快捷回复"];///< ,@"立即转诊",@"服务评价"
    NSArray *arrImage = @[@"chat_messageAlbum",@"chat_messageCamera",@"quick_reply"];
    CGFloat itemH=50;
    CGFloat space= (Window_Width-200)/5;
    for (int i=0; i<arrTitle.count; i++) {
        UIButton *btn=[[UIButton alloc]init];
        [btn setImage:[UIImage imageNamed:arrImage[i]] forState:UIControlStateNormal];
        [btn setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
        btn.contentEdgeInsets = UIEdgeInsetsMake(15, 0, 0, 0);
        [btn addTarget:self action:@selector(juTouchMore:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=i;
        [self addSubview:btn];
        UILabel *lab=[[UILabel alloc]init];
        lab.text=arrTitle[i];
        lab.textColor = [UIColor colorWithWhite:0.6 alpha:1];
        lab.font = [UIFont systemFontOfSize:13];
        [btn addSubview:lab];
        lab.juOrigin(CGPointMake(0, -8));

        btn.juLead.equal(space+(itemH+space)*i);
        btn.juTop.equal(0);
        btn.juSize(CGSizeMake(itemH, [JuChatMoreView juHeight]));
    }
}
-(void)juShowView:(UIView *)view{

    if (view) {
        if (!self.superview) {
            [view addSubview:self];
        }
        self.hidden=NO;
        self.ju_Bottom.constant=0;
        [UIView animateWithDuration:0.3 animations:^{
            [self.superview layoutIfNeeded];
        }];
    }else{
        self.ju_Bottom.constant=-[JuChatMoreView juHeight]-34;
        [UIView animateWithDuration:0.3 animations:^{
            [self.superview layoutIfNeeded];
        }completion:^(BOOL finished) {
            self.hidden=YES;
        }];
    }
}
-(void)juTouchMore:(UIButton *)sender{


}
-(void)didMoveToSuperview{
    [super didMoveToSuperview];
    if (self.superview) {
        self.juSafeFrame(CGRectMake(0, -0.01, 0, [JuChatMoreView juHeight]));
        self.ju_Bottom.constant=-[JuChatMoreView juHeight];
        [self.superview layoutIfNeeded];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(CGFloat)juHeight{
    return 100;
}
@end
