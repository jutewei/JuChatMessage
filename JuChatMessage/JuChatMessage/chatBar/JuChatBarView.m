//
//  PFBChatInputView.m
//  TestIM
//
//  Created by Juvid on 16/7/25.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import "JuChatBarView.h"
#import "JuLayoutFrame.h"
#import "JuRecordView.h"
#import "JuChatMoreView.h"
#import "JuChatBarDelegate.h"
#import "JuAudioManage.h"
//#import "PredicateCheck.h"
#import "JuMsgConfig.h"
#import "JuChatEmojiView.h"

#define InputEdgeTop 11

typedef NS_ENUM(NSInteger,JUContentInputType){
    JUContentInputTypeNone,/// 初始状态
    JUContentInputTypeText,/// 文本输入
    JUContentInputTypeAduio,/// 语音输入
    JUContentInputTypeEmoji,/// 表情输入
    JUContentInputTypeMore,/// 更多输入
};

@implementation JuChatBarView{
    JuRecordView *ju_recordView;
    JuChatMoreView *ju_chatMoreView;
    JuChatEmojiView *ju_emojiView;
    JUContentInputType ju_lastInput,ju_currentInput;/// 上次活跃的输入
    CGFloat ju_textHeight;
}

-(instancetype)init{
    self=[super init];
    if (self) {
        [self juSetTextView];
        self.backgroundColor=JUMsgColor_CharBar;
    }
    return self;
}



-(void)juSetTextView{

    UIView *viewText=[[UIView alloc]init];
    viewText.backgroundColor=JUMsgColor_TextGround;
    [viewText.layer setCornerRadius:20];
    [viewText.layer setMasksToBounds:YES];
    [viewText.layer setBorderColor:JUMsgColor_TextGround.CGColor];
    [viewText.layer setBorderWidth:5];
    [self addSubview:viewText];
    viewText.juBottom.equal(InputEdgeTop);
    viewText.juTop.equal(InputEdgeTop);

    ///< 文本输入
    _ju_TextView=[[UITextView alloc]init];
    _ju_TextView.font=[UIFont systemFontOfSize:14];
    _ju_TextView.scrollEnabled=NO;
    _ju_TextView.delegate=self;
    _ju_TextView.returnKeyType=UIReturnKeySend;
    _ju_TextView.backgroundColor=JUMsgColor_TextGround;
//    _ju_TextView.textContainerInset=UIEdgeInsetsMake(5, 5, 5, 5);
//    [_ju_TextView.layer setCornerRadius:20];
//    [_ju_TextView.layer setMasksToBounds:YES];
    [viewText addSubview:_ju_TextView];
//    _ju_TextView.juEdge(UIEdgeInsetsMake(0, 16, 0, 16));
    _ju_TextView.juLead.equal(10);
    _ju_TextView.juTrail.equal(10);
    _ju_TextView.juCenterY.equal(0);
    _ju_TextView.juTop.greaterEqual(0);

    //分割线
//    UIView *vieLine=[[UIView alloc]init];
//    vieLine.backgroundColor=[UIColor colorWithWhite:0 alpha:0.1];
//    [self addSubview:vieLine];
//    vieLine.juFrame(CGRectMake(0, 0.01, 0, 0.5));

    CGFloat spaceH = 6;
    //录音按钮
    _ju_btnVoice=[[UIButton alloc]init];
    [_ju_btnVoice addTarget:self action:@selector(juTouchVoice:) forControlEvents:UIControlEventTouchUpInside];
    [_ju_btnVoice setImage:JuChatImageName(@"chatBar_record") forState:UIControlStateNormal];
    [_ju_btnVoice setImage:JuChatImageName(@"chatBar_keyBoard") forState:UIControlStateSelected];

    [self addSubview:_ju_btnVoice];
    _ju_btnVoice.juLead.equal(spaceH);
    _ju_btnVoice.juCenterY.equal(0);
    _ju_btnVoice.juSize(CGSizeMake(40, 40));

    _ju_btnRecord=[[UIButton alloc]init];
    _ju_btnRecord.hidden=YES;
    [_ju_btnRecord setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_ju_btnRecord addTarget:self action:@selector(juRecordTouchDown) forControlEvents:UIControlEventTouchDown];
    [_ju_btnRecord addTarget:self action:@selector(juRecordTouchUpOutside) forControlEvents:UIControlEventTouchUpOutside];
    [_ju_btnRecord addTarget:self action:@selector(juRecordTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    [_ju_btnRecord addTarget:self action:@selector(juRecordDragOutside) forControlEvents:UIControlEventTouchDragExit];
    [_ju_btnRecord addTarget:self action:@selector(juRecordDragInside) forControlEvents:UIControlEventTouchDragEnter];
//    [_ju_btnRecord.layer setBorderWidth:.5];
//    [_ju_btnRecord.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [_ju_btnRecord.layer setCornerRadius:20];
    [_ju_btnRecord.layer setMasksToBounds:YES];
    [_ju_btnRecord setBackgroundColor:JUMsgColor_TextGround];
    [_ju_btnRecord setTitle:@"按住说话" forState:UIControlStateNormal];
    [self addSubview:_ju_btnRecord];

    _ju_btnRecord.juCenterY.equal(0);
    _ju_btnRecord.juTrail.equal(spaceH);
    _ju_btnRecord.juHeight.equal(38);

//更多按钮操作
    _ju_btnMedia=[[UIButton alloc]init];
    [_ju_btnMedia addTarget:self action:@selector(juTouchMore:) forControlEvents:UIControlEventTouchUpInside];
    [_ju_btnMedia setImage:JuChatImageName(@"chatBar_more")  forState:UIControlStateNormal];
    [self addSubview:_ju_btnMedia];

    _ju_btnMedia.juTrail.equal(spaceH);
    _ju_btnMedia.juCenterY.equal(0);
    _ju_btnMedia.juSize(CGSizeMake(40, 40));

    _ju_btnEmoji=[[UIButton alloc]init];
    [_ju_btnEmoji addTarget:self action:@selector(juTouchEmoji:) forControlEvents:UIControlEventTouchUpInside];
    [_ju_btnEmoji setImage:JuChatImageName(@"chatBar_emoji")  forState:UIControlStateNormal];
    [self addSubview:_ju_btnEmoji];

    _ju_btnEmoji.juTraSpace.toView(_ju_btnMedia).equal(spaceH/2);
    _ju_btnEmoji.juCenterY.equal(0);
    _ju_btnEmoji.juSize(CGSizeMake(40, 40));


    if (_ju_btnVoice) {
        viewText.juLeaSpace.toView(_ju_btnVoice).equal(spaceH);
    }else{
        viewText.juLead.equal(spaceH);
    }
    if (_ju_btnMedia) {
        viewText.juTraSpace.toView(_ju_btnEmoji).equal(spaceH);
    }else{
        viewText.juTrail.equal(spaceH);
    }

    _ju_btnRecord.juLead.toView(viewText).equal(0);
    _ju_btnRecord.juTrail.toView(viewText).equal(0);

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
        if (ju_currentInput==JUContentInputTypeMore||ju_currentInput==JUContentInputTypeEmoji)  return;
        [self juChangeBarHeight:0 duration:animationDuration];
    }else if([notification.name isEqualToString:UIKeyboardWillChangeFrameNotification]){
        if (@available(iOS 11.0, *)) {///< 减去安全区域底部高度
            UIEdgeInsets instes = self.superview.safeAreaInsets;
            keyboardEndFrame.size.height-=instes.bottom;
        }
        [self juChangeBarHeight:keyboardEndFrame.size.height duration:animationDuration];
    }
}
//chatBar 位置
-(void)juChangeBarHeight:(CGFloat)height duration:(NSTimeInterval)time{
    ///< 键盘动画可以不用设置动画，我也是醉了
    UIEdgeInsets inset=self.ju_tableView.contentInset;

    if (height!=inset.bottom&&self.ju_tableView.numberOfSections>0) {
        inset.bottom = height;
        self.ju_tableView.contentInset=inset;

        if (height!=0) {
             [self.ju_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:self.ju_tableView.numberOfSections-1] atScrollPosition:UITableViewScrollPositionBottom animated:NO];

        }/*else{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.ju_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:self.ju_tableView.numberOfSections-1] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
            });
        }*/
    }

    self.ju_Bottom.constant=height;
    [UIView animateWithDuration:time animations:^{
        [self.superview layoutIfNeeded];
    }];

}
/**弹键盘设置**/
//检测输入框文本高度
- (void)textViewDidChange:(UITextView *)textView{
    CGFloat maxHeight = [JuChatBarView maxHeight];
    //    内容高度
    CGSize size = [textView sizeThatFits:CGSizeMake(textView.frame.size.width, maxHeight)];
    if (size.height >= maxHeight-14){
        textView.scrollEnabled = YES;   // 允许滚动
    }
    else{
        textView.scrollEnabled = NO;    // 不允许滚动，当textview的大小足以容纳它的text的时候，需要设置scrollEnabed为NO，否则会出现光标乱滚动的情况
    }
    ju_textHeight=size.height+1;
    [self setTextViewHeight:ju_textHeight];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqual:@"\n"]) {
//        [textView resignFirstResponder];
        [self juSendText];
        return NO;
    }
    return YES;
}
-(void)juSendText{
    NSString *notEmpty=[_ju_TextView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (notEmpty.length==0) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(juDidSendText:)]) {
        [self.delegate juDidSendText:_ju_TextView.text];
    }
    _ju_TextView.text=@"";
    ju_textHeight=0;
    [self setTextViewHeight:ju_textHeight];
}
#pragma mark emoji deletage
- (void)juDidSelectEmoji:(NSString *)text{
    if (!text) {
        [self juSendText];
    }
    else if ([text isEqual:@""]) {
        [_ju_TextView deleteBackward];
    }else{
        [_ju_TextView insertText:text];
    }
}

//改变输入框的高度
#pragma mark - Message input view
-(void)setTextViewHeight:(CGFloat)changeHeight{
    CGFloat maxHeight = [JuChatBarView maxHeight];
    changeHeight=MIN(maxHeight, changeHeight+InputEdgeTop*2);//   changeInHeight+19 文本内容高度加上最小高度
    self.ju_Height.constant=MAX(ChatBarHeight, changeHeight);
}

/// 最大高度
+ (CGFloat)maxHeight{
    return 5.0f * 26;
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
        ju_chatMoreView.delegate=self.delegate;
    }
    [self juShowView:sender.selected?JUContentInputTypeMore:JUContentInputTypeText];
}
-(void)juTouchEmoji:(UIButton *)sender{
    sender.selected=!sender.selected;
    if (!ju_emojiView) {
        ju_emojiView=[[JuChatEmojiView alloc]init];
        ju_emojiView.delegate=self;
    }
    [self juShowView:sender.selected?JUContentInputTypeEmoji:JUContentInputTypeText];
}
/**语音与键盘切换*/
-(void)juTouchVoice:(UIButton *)sender{
    sender.selected=!sender.selected;
    [self juShowView:sender.selected?JUContentInputTypeAduio:JUContentInputTypeText];
}

/**键盘显示*/
-(void)textViewDidBeginEditing:(UITextView *)textView{
    [self juShowView:JUContentInputTypeText];
}

-(void)juHidderAll{
    if(ju_lastInput==JUContentInputTypeAduio)return;;
    [self juHideView:ju_lastInput];
    [self juChangeBarHeight:0 duration:0.3];
    ju_lastInput=JUContentInputTypeNone;
}

//显示单个事件
-(void)juShowView:(JUContentInputType )type{

    if (type==ju_lastInput)  return;
    ju_currentInput=type;
    [self juHideView:ju_lastInput];
    _ju_TextView.hidden=NO;
    switch (type) {
        case JUContentInputTypeText:{
            if (ju_lastInput!=JUContentInputTypeText) {
                [_ju_TextView becomeFirstResponder];
                [self setTextViewHeight:ju_textHeight];
            }
        }
            break;
        case JUContentInputTypeAduio:{
            _ju_btnRecord.hidden=NO;
            _ju_TextView.hidden=YES;
            [self juChangeBarHeight:0 duration:0.3];
            [self setTextViewHeight:0];
        }
            break;
        case JUContentInputTypeMore:{
            [ju_chatMoreView juShowView:self.superview];
            [self juChangeBarHeight:[JuChatMoreView mbHeight] duration:0.25];
        }
            break;
        case JUContentInputTypeEmoji:
            [ju_emojiView juShowView:self.superview];
            [self juChangeBarHeight:[JuChatEmojiView mbHeight] duration:0.25];
            break;
    }
    ju_lastInput=type;

}

-(void)juHideView:(JUContentInputType)type{
    switch (type) {
        case JUContentInputTypeText:{
            [_ju_TextView resignFirstResponder];
        }
            break;
        case JUContentInputTypeAduio:{
            _ju_btnRecord.hidden=YES;
            _ju_btnVoice.selected=NO;
        }
            break;
        case JUContentInputTypeMore:{
            _ju_btnMedia.selected=NO;
            [ju_chatMoreView juShowView:nil];
        }
            break;
        case JUContentInputTypeEmoji:
            _ju_btnEmoji.selected=NO;
            [ju_emojiView juShowView:nil];
            break;
    }
}

//按下
-(void)juRecordTouchDown{
    __weak typeof(self)     weakSelf = self;
    [self.ju_recordView juStartRecord:self.superview hanlde:^{
        [weakSelf.ju_btnRecord setTitle:@"松开发送" forState:UIControlStateNormal];
    }];
}

//松开录制完成
-(void)juRecordTouchUpInside{
    [_ju_btnRecord setTitle:@"按住说话" forState:UIControlStateNormal];
    [self.ju_recordView juStopRecord];
    if ([self.delegate respondsToSelector:@selector(juDidSendVoice:)]) {
        NSDictionary *dicM=[JuAudioManage sharedInstance].ju_mediaM;
        if (dicM) {
            [self.delegate juDidSendVoice:dicM];
            [JuAudioManage sharedInstance].ju_mediaM=nil;
        }
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
