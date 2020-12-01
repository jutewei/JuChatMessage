//
//  PFBChatInputView.m
//  TestIM
//
//  Created by Juvid on 16/7/25.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import "JuChatBarView.h"
#import "UIView+JuLayGroup.h"
#import "JuRecordView.h"
#import "JuChatMoreView.h"
#import "JuChatBarDelegate.h"

@implementation JuChatBarView{
    JuRecordView *ju_recordView;
    JuChatMoreView *ju_chatMoreView;
}

-(instancetype)init{
    self=[super init];
    if (self) {
        [self juSetTextView];
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *view=[super hitTest:point withEvent:event];
    if (!view&&(_ju_TextView.isFirstResponder||!ju_chatMoreView.hidden)) {
        [self juNotHiddenView:self.juViewItem];
    }
    return view;
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
        [self juChangeBarHeight:0 duration:animationDuration];
    }else if([notification.name isEqualToString:UIKeyboardWillChangeFrameNotification]){
        if (@available(iOS 11.0, *)) {///< 减去安全区域底部高度
            UIEdgeInsets instes = self.superview.safeAreaInsets;
            keyboardEndFrame.size.height-=instes.bottom;
        }
        [self juChangeBarHeight:keyboardEndFrame.size.height duration:animationDuration];
    }
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

    //分割线
    UIView *vieLine=[[UIView alloc]init];
    vieLine.backgroundColor=[UIColor lightGrayColor];
    [self addSubview:vieLine];
    vieLine.juFrame(CGRectMake(0, 0.01, 0, 0.5));

    //录音按钮
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
    [_ju_btnRecord addTarget:self action:@selector(juRecordTouchDown) forControlEvents:UIControlEventTouchDown];
    [_ju_btnRecord addTarget:self action:@selector(juRecordTouchUpOutside) forControlEvents:UIControlEventTouchUpOutside];
    [_ju_btnRecord addTarget:self action:@selector(juRecordTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    [_ju_btnRecord addTarget:self action:@selector(juRecordDragOutside) forControlEvents:UIControlEventTouchDragExit];
    [_ju_btnRecord addTarget:self action:@selector(juRecordDragInside) forControlEvents:UIControlEventTouchDragEnter];
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

//更多按钮操作
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
        _ju_TextView.juTraSpace.toView(_ju_btnMedia).equal(5);
    }else{
        _ju_TextView.juTrail.equal(10);
    }

    _ju_btnRecord.juLead.toView(_ju_TextView).equal(0);
    _ju_btnRecord.juTrail.toView(_ju_TextView).equal(0);

}
-(void)juChangeBarHeight:(CGFloat)height duration:(NSTimeInterval)time{
    ///< 键盘动画可以不用设置动画，我也是醉了

    UIEdgeInsets inset=self.ju_tableView.contentInset;
    inset.bottom = height;
    self.ju_tableView.contentInset=inset;

    if (height>0&&[self.ju_tableView numberOfRowsInSection:0]>0) {
        [self.ju_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.ju_tableView numberOfRowsInSection:0]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }

    self.ju_Bottom.constant=height;
    [UIView animateWithDuration:time animations:^{
        [self.superview layoutIfNeeded];
    }];
}
/**弹键盘设置**/
//检测输入框文本高度
- (void)textViewDidChange:(UITextView *)textView
{
    CGFloat maxHeight = [JuChatBarView maxHeight];
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
        if ([self.delegate respondsToSelector:@selector(juDidSendText:)]) {
            [self.delegate juDidSendText:textView.text];
        }
        textView.text=@"";
        [textView resignFirstResponder];
        [self adjustTextViewHeightBy:0];
        return NO;
    }
    return YES;
}
//改变输入框的高度
#pragma mark - Message input view
-(void)adjustTextViewHeightBy:(CGFloat)changeHeight
{
    CGFloat maxHeight = [JuChatBarView maxHeight];
    changeHeight=MIN(maxHeight, changeHeight+14);//   changeInHeight+19 文本内容高度加上最小高度
    self.ju_Height.constant=MAX(ChatBarHeight, changeHeight);
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
-(JuRecordView *)ju_recordView{
    if (!ju_recordView) {
        ju_recordView = [[JuRecordView alloc]init];
    }
    return ju_recordView;
}
/***各个事件处理***/
-(void)juTouchMore:(UIButton *)sender{
    sender.selected=!sender.selected;
    if (!ju_chatMoreView) {
        ju_chatMoreView=[[JuChatMoreView alloc]init];
    }
    [self juShowView:sender.selected?@"more":@"text"];
}
/**语音与键盘切换*/
-(void)juTouchVoice:(UIButton *)sender{
    sender.selected=!sender.selected;
    [self juShowView:sender.selected?@"voice":@"text"];
}
/**键盘显示*/
-(void)textViewDidBeginEditing:(UITextView *)textView{
    [self juShowView:@"text"];
}
-(NSArray *)juViewItem{
    return @[@"text",@"voice",@"more"];
}
//显示单个事件
-(void)juShowView:(NSString *)type{
    NSMutableArray *arrItem=[self.juViewItem mutableCopy];
    [arrItem removeObject:type];
    [self juNotHiddenView:arrItem];
    _ju_TextView.hidden=NO;
    if ([type isEqual:@"text"]) {
        [_ju_TextView becomeFirstResponder];
    }else if ([type isEqual:@"voice"]){
        _ju_btnRecord.hidden=NO;
        _ju_TextView.hidden=YES;
        [self juChangeBarHeight:0 duration:0.3];
    }else{
        [self juChangeBarHeight:[JuChatMoreView juHeight] duration:0.3];
        [ju_chatMoreView juShowView:self.superview];
    }
}
//隐藏多个事件
-(void)juNotHiddenView:(NSArray *)types{
    for (NSString *string in types) {
        if ([string isEqual:@"text"]) {
            if (_ju_TextView.isFirstResponder) {
                 [_ju_TextView resignFirstResponder];
            }
        }else if ([string isEqual:@"voice"]){
            if (!_ju_btnRecord.hidden) {
                _ju_btnRecord.hidden=YES;
                _ju_btnVoice.selected=NO;
            }
        }else if ([string isEqual:@"more"]){
            if (!ju_chatMoreView.hidden) {
                _ju_btnMedia.selected=NO;
                [ju_chatMoreView juShowView:nil];
            }
        }
    }
    if (types.count==self.juViewItem.count) {
        [self juChangeBarHeight:0 duration:0.3];
    }
}
//按下
-(void)juRecordTouchDown{
    [_ju_btnRecord setTitle:@"松开发送" forState:UIControlStateNormal];
    [self.ju_recordView juStartRecord:self.superview];
}
//松开录制完成
-(void)juRecordTouchUpInside{
    [_ju_btnRecord setTitle:@"按住说话" forState:UIControlStateNormal];
    [self.ju_recordView juStopRecord];
    if ([self.delegate respondsToSelector:@selector(juDidSendVoice:)]) {
        [self.delegate juDidSendVoice:nil];
    }
}
//移走后松开取消录制
-(void)juRecordTouchUpOutside{
    [_ju_btnRecord setTitle:@"按住说话" forState:UIControlStateNormal];
    [self.ju_recordView juStopRecord];
}
//移动回来
-(void)juRecordDragInside{
    [self.ju_recordView juSetVoiceImage:NO];
}
//移走
-(void)juRecordDragOutside{
    [self.ju_recordView juSetVoiceImage:YES];
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
