//
//  JuRecordView.m
//  JuChatMessage
//
//  Created by Juvid on 2018/9/18.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import "JuRecordView.h"
#import "UIView+JuLayGroup.h"
@implementation JuRecordView{
    NSTimer *ju_timer;
    UIImageView *ju_imgAnimation;
    UIImageView *ju_imgVoice;
    UILabel *ju_textLabel;
}

-(instancetype)init{
    self=[super init];
    if (self) {
        self.ju_AnimationImages = @[@"RecordingSignal001",@"RecordingSignal002",@"RecordingSignal003",@"RecordingSignal004",@"RecordingSignal004",@"RecordingSignal006",@"RecordingSignal007",@"RecordingSignal008"];
        self.ju_upCancelText = @"向上滑动，取消发送";
        self.ju_loosenCancelText = @"松开手指，取消发送";
        [self juSetSubviews];
    }
    return self;
}
-(void)juSetSubviews{

    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;

    /**麦克风图标*/
    ju_imgVoice=[[UIImageView alloc]init];
    ju_imgVoice.contentMode = UIViewContentModeScaleAspectFit;
    ju_imgVoice.image=[UIImage imageNamed:@"RecordingBkg"];
    [self addSubview:ju_imgVoice];
    ju_imgVoice.juFrame(CGRectMake(10, 8, 60, 100));

    /**音量图标*/
    ju_imgAnimation = [[UIImageView alloc] init];
    ju_imgAnimation.image = [UIImage imageNamed:@"RecordingSignal001"];
    ju_imgAnimation.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:ju_imgAnimation];
    ju_imgAnimation.juFrame(CGRectMake(70, 8, 60, 100));

    ju_textLabel = [[UILabel alloc] init];
    ju_textLabel.textAlignment = NSTextAlignmentCenter;
    ju_textLabel.backgroundColor = [UIColor clearColor];
    ju_textLabel.text = self.ju_upCancelText;
    [self addSubview:ju_textLabel];
    ju_textLabel.juFrame(CGRectMake(0, -8, 125, 25));

    ju_textLabel.font = [UIFont systemFontOfSize:13];
    ju_textLabel.textColor = [UIColor whiteColor];
    ju_textLabel.layer.cornerRadius = 5;
    ju_textLabel.layer.borderColor = [[UIColor redColor] colorWithAlphaComponent:0.5].CGColor;
    ju_textLabel.layer.masksToBounds = YES;

}
-(void)juStartRecord:(UIView *)supView{
    [supView addSubview:self];
    self.juFrame(CGRectMake(0, 0, 140, 140));
    _ju_voiceMaxTime=60;
    [self juSetVoiceImage:NO];
    ju_timer = [NSTimer scheduledTimerWithTimeInterval:0.05
                                                target:self
                                              selector:@selector(juSetVoiceImage)
                                              userInfo:nil
                                               repeats:YES];
}
-(void)juStopRecord{
    [self removeFromSuperview];
    [ju_timer invalidate];
}
-(void)juSetVoiceImage:(BOOL)isReadyCancle{
    ju_imgAnimation.hidden=isReadyCancle;
    if (isReadyCancle) {
        ju_textLabel.backgroundColor = [UIColor redColor];
        ju_textLabel.text = _ju_loosenCancelText;
        ju_imgVoice.image=[UIImage imageNamed:@"RecordCancel"];
        ju_imgVoice.ju_Width.constant= 140-20;
    }else{
        ju_textLabel.backgroundColor = [UIColor clearColor];
        ju_textLabel.text = _ju_upCancelText;
        ju_imgVoice.image=[UIImage imageNamed:@"RecordingBkg"];
        ju_imgVoice.ju_Width.constant=140/2-10;
    }
}
-(void)juSetVoiceImage{

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
