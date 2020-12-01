//
//  JuChatMoreView.m
//  JuChatMessage
//
//  Created by Juvid on 2018/9/18.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import "JuChatMoreView.h"
#import "JuLayoutFrame.h"
#import "JuMsgConfig.h"
#import "JuChatBarDelegate.h"
@implementation JuChatMoreView
-(instancetype)init{
    self=[super init];
    if (self) {
        [self shSubViews];
    }
    return self;
}
-(void)shSubViews{
    self.backgroundColor=JUMsgColor_ChatMore;
    NSArray *arrTitle=@[@"照片",@"拍照"];///< 
    NSArray *arrImage = @[@"chat_morePhoto",@"chat_moreCamera"];
    CGFloat itemW=65;
    CGFloat space= (Chat_WindowWidth-itemW*4)/5;
    for (int i=0; i<arrTitle.count; i++) {
        UIButton *btn=[[UIButton alloc]init];
        [btn setImage:JuChatImageName(arrImage[i]) forState:UIControlStateNormal];
        [btn setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
//        btn.contentEdgeInsets = UIEdgeInsetsMake(12, 0, 0, 0);
        [btn addTarget:self action:@selector(juTouchMore:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=i;
        [self addSubview:btn];
        UILabel *lab=[[UILabel alloc]init];
        lab.text=arrTitle[i];
        lab.textColor = JUMsgColor_moreText;
        lab.font = [UIFont systemFontOfSize:13];
        [btn addSubview:lab];
        lab.juOrigin(CGPointMake(0, -0.01));

        btn.juLead.equal(space+(itemW+space)*i);
        btn.juTop.equal(20);
        btn.juSize(CGSizeMake(itemW, 89));
    }
}
-(void)juShowView:(UIView *)view{
    [self.superview layoutIfNeeded];
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
        self.ju_Bottom.constant=-[JuChatMoreView mbHeight]-34;
        [UIView animateWithDuration:0.3 animations:^{
            [self.superview layoutIfNeeded];
        }completion:^(BOOL finished) {
            self.hidden=YES;
        }];
    }
}
-(void)juTouchMore:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(juDidSelectMore:)]) {
        [self.delegate juDidSelectMore:sender];
    }

}
-(void)didMoveToSuperview{
    [super didMoveToSuperview];
    if (self.superview) {
        self.juSafeFrame(CGRectMake(0, -0.01, 0, [JuChatMoreView mbHeight]));
        self.ju_Bottom.constant=-[JuChatMoreView mbHeight];
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
+(CGFloat)mbHeight{
    return 189;
}
@end
