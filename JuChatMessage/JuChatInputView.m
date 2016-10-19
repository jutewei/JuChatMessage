//
//  PFBChatInputView.m
//  TestIM
//
//  Created by Juvid on 16/7/25.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import "JuChatInputView.h"
#import "UIView+JuLayGroup.h"

@implementation JuChatInputView
-(instancetype)init{
    self=[super init];
    if (self) {
        [self juSetTextView];
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}
-(void)juViewWillAppear{

    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(keyboardFrame:)
                                                name:UIKeyboardWillChangeFrameNotification
                                              object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(keyboardFrame:)
                                                name:UIKeyboardWillHideNotification
                                              object:nil];
}
-(void)juViewWillDisAppear{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)keyboardFrame:(NSNotification *)notification{

    NSDictionary *userInfo = [notification userInfo];
    CGRect keyboardEndFrame;
    NSTimeInterval animationDuration;
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];

    if ([notification.name isEqualToString:UIKeyboardWillHideNotification]) {
        [self juShowOrHide:CGRectMake(0, 0, 0, 0) duration:animationDuration];
    }else if([notification.name isEqualToString:UIKeyboardWillChangeFrameNotification]){
        [self juShowOrHide:keyboardEndFrame duration:animationDuration];
    }
}

-(void)juShowOrHide:(CGRect)frame duration:(NSTimeInterval)time{
///< 键盘动画可以不用设置动画，我也是醉了
     self.ju_Bottom.constant=-frame.size.height;
    [UIView animateWithDuration:time animations:^{
        [self.superview layoutIfNeeded];
    }];
}
-(void)juSetTextView{
    _ju_TextView=[[UITextView alloc]init];
    _ju_TextView.font=[UIFont systemFontOfSize:14];
    _ju_TextView.scrollEnabled=NO;
    _ju_TextView.delegate=self;
    _ju_TextView.returnKeyType=UIReturnKeySend;
    [_ju_TextView.layer setBorderWidth:.5];
    [_ju_TextView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [_ju_TextView.layer setCornerRadius:5];
    [_ju_TextView.layer setMasksToBounds:YES];
    [self addSubview:_ju_TextView];
    _ju_TextView.juEdge(UIEdgeInsetsMake(7, 10, 7, 10));

//    UIButton *ju_btnSend=[[UIButton alloc]init];
//    [ju_btnSend setTitle:@"发送" forState:UIControlStateNormal];
//    [ju_btnSend setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [ju_btnSend addTarget:self action:@selector(juTouchSend:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:ju_btnSend];
//    ju_btnSend.juFrame(CGRectMake(-0.01, -8, 60, 30));

    UIView *vieLine=[[UIView alloc]init];
    vieLine.backgroundColor=[UIColor lightGrayColor];
    [self addSubview:vieLine];
    vieLine.juFrame(CGRectMake(0, 0.01, 0, 0.5));
    
}
-(void)juTouchSend:(UIButton *)sender{
    [self juSendText];
}
/**弹键盘设置**/
//检测输入框文本高度
- (void)textViewDidChange:(UITextView *)textView
{
    CGFloat maxHeight = [JuChatInputView maxHeight];
    //    内容高度
    CGSize size = [textView sizeThatFits:CGSizeMake(textView.frame.size.width, maxHeight)];
    if (size.height >= maxHeight-14){
        textView.scrollEnabled = YES;   // 允许滚动
    }
    else{
        textView.scrollEnabled = NO;    // 不允许滚动，当textview的大小足以容纳它的text的时候，需要设置scrollEnabed为NO，否则会出现光标乱滚动的情况
    }
    [self adjustTextViewHeightBy:size.height];

}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqual:@"\n"]) {
        [self juSendText];
        return NO;
    }
    return YES;
}
-(void)juSendText{
    if (_ju_TextResult) {
        _ju_TextResult(_ju_TextView.text);
    }
    _ju_TextView.text=@"";
    [_ju_TextView resignFirstResponder];
    [self textViewDidChange:_ju_TextView];
}
//改变输入框的高度
#pragma mark - Message input view
-(void)adjustTextViewHeightBy:(CGFloat)changeHeight
{
    CGFloat maxHeight = [JuChatInputView maxHeight];
    changeHeight=MIN(maxHeight, changeHeight+14);//   changeInHeight+19 文本内容高度加上最小高度
    self.juHeight.equal(changeHeight);

}
///每行高度
+ (CGFloat)textViewLineHeight{
    return 26.0f; // for fontSize 16.0f
}
/// 最大行
+ (CGFloat)maxLines{
    return 4.0f;
}
/// 最大高度
+ (CGFloat)maxHeight{
    return ([self maxLines] + 1.0f) * [self textViewLineHeight];
}
-(void)dealloc{
    [self juViewWillDisAppear];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
