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
    ///< 文本输入
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
    _ju_TextView.juBottom.equal(7);
    _ju_TextView.juTop.equal(7);


    UIView *vieLine=[[UIView alloc]init];
    vieLine.backgroundColor=[UIColor lightGrayColor];
    [self addSubview:vieLine];
    vieLine.juFrame(CGRectMake(0, 0.01, 0, 0.5));

    _ju_btnVoice=[[UIButton alloc]init];
    [_ju_btnVoice addTarget:self action:@selector(juTouchVoice:) forControlEvents:UIControlEventTouchUpInside];
    [_ju_btnVoice setImage:[UIImage imageNamed:@"chatBar_record"] forState:UIControlStateNormal];
    [self addSubview:_ju_btnVoice];
    _ju_btnVoice.juLead.equal(5);
    _ju_btnVoice.juCenterY.equal(0);
    _ju_btnVoice.juSize(CGSizeMake(35, 35));

    _ju_btnRecord=[[UIButton alloc]init];
    _ju_btnRecord.hidden=YES;
    [_ju_btnRecord setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_ju_btnRecord.layer setBorderWidth:.5];
    [_ju_btnRecord.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [_ju_btnRecord.layer setCornerRadius:5];
    [_ju_btnRecord.layer setMasksToBounds:YES];
    [_ju_btnRecord setBackgroundColor:[UIColor whiteColor]];
    [_ju_btnRecord setTitle:@"按住说话" forState:UIControlStateNormal];
    [self addSubview:_ju_btnRecord];
    _ju_btnRecord.juCenterY.equal(0);
    _ju_btnRecord.juTrail.equal(10);
    _ju_btnRecord.juHeight.equal(33);

    _ju_btnMedia=[[UIButton alloc]init];
    [_ju_btnMedia addTarget:self action:@selector(juTouchMore:) forControlEvents:UIControlEventTouchUpInside];
    [_ju_btnMedia setImage:[UIImage imageNamed:@"chatBar_more"] forState:UIControlStateNormal];
    [self addSubview:_ju_btnMedia];
    _ju_btnMedia.juTrail.equal(5);
    _ju_btnMedia.juCenterY.equal(0);
    _ju_btnMedia.juSize(CGSizeMake(35, 35));


    if (_ju_btnVoice) {
        _ju_TextView.juLeaSpace.toView(_ju_btnVoice).equal(5);
    }else{
        _ju_TextView.juLead.equal(10);
    }
    if (_ju_btnMedia) {
        _ju_TextView.juTraSpace.toView(_ju_btnMedia).equal(-5);
    }else{
        _ju_TextView.juTrail.equal(10);
    }

    _ju_btnRecord.juLead.toView(_ju_TextView).equal(0);
    _ju_btnRecord.juTrail.toView(_ju_TextView).equal(0);

}
-(void)juTouchVoice:(UIButton *)sender{
    _ju_btnRecord.hidden=!_ju_btnRecord.hidden;
    _ju_TextView.hidden=!_ju_btnRecord.hidden;
    if (_ju_btnRecord.hidden) {
        [self textViewDidChange:_ju_TextView];
    }else{
        [self adjustTextViewHeightBy:33];
    }
}
-(void)juTouchMore:(UIButton *)sender{

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
    self.ju_Height.constant=changeHeight;

    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
    }];

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
