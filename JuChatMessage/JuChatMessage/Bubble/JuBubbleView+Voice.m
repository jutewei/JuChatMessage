//
//  JuBubbleView+Voice.m
//  JuChatMessage
//
//  Created by Juvid on 2018/9/17.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import "JuBubbleView+Voice.h"

@implementation JuBubbleView (Voice)

-(void)juSetVoiceView:(BOOL)isRight{
    self.ju_imgVoice=[[UIImageView alloc]init];
    [self addSubview:self.ju_imgVoice];
    self.ju_labVoiceTime=[[UILabel alloc]init];
    [self addSubview:self.ju_labVoiceTime];
    self.ju_labVoiceTime.font=[UIFont systemFontOfSize:15];
    self.ju_labVoiceTime.textColor=[UIColor darkGrayColor];

    self.ju_imgVoice.juCenterY.equal(0);
    self.ju_imgVoice.juSize(CGSizeMake(20, 20));
    self.ju_labVoiceTime.juCenterY.equal(0);

    if (isRight) {
        self.ju_imgVoice.image=JuChatImageName(@"chatVoiceRight");
        self.ju_imgVoice.juTrail.equal(15);
        self.ju_labVoiceTime.juLead.equal(15);

    }else{
        self.ju_imgVoice.image=JuChatImageName(@"chatVoiceLeft");
        self.ju_imgVoice.juLead.equal(15);
        self.ju_labVoiceTime.juTrail.equal(15);
    }

}

-(void)juSetVoiceData:(JuChatDataAdapter *)juModel{
    
    if (!self.ju_Width) self.juWidth.equal(100);

    if (juModel.isSend) {
        self.ju_labVoiceTime.textColor=JUMsgColor_ChatText;
    }else{
        self.ju_labVoiceTime.textColor=JUMsgColor_ChatText;
    }
    if ([juModel.ju_duration intValue]>0) {
        NSInteger time=[juModel.ju_duration intValue];
        NSString *text;
        if (time%60>0) {
            text=[NSString stringWithFormat:@"%ld″",time%60];
        }
        if (time/60>0) {
            text=[NSString stringWithFormat:@"%ld′ %@",time/60,text];
        }
        self.ju_labVoiceTime.text=text;
        self.ju_Width.constant=MIN([UIScreen mainScreen].bounds.size.width-120, time*3+80);
    }else{
         self.ju_labVoiceTime.text=@"";
         self.ju_Width.constant=100;
    }

}
@end
