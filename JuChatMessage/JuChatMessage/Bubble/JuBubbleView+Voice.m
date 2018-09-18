//
//  JuBubbleView+Voice.m
//  JuChatMessage
//
//  Created by Juvid on 2018/9/17.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import "JuBubbleView+Voice.h"

@implementation JuBubbleView (Voice)
-(void)shSetVoiceView:(BOOL)isLeft{
    self.ju_imgVoice=[[UIImageView alloc]init];
    [self addSubview:self.ju_imgVoice];
    self.ju_labVoiceTime=[[UILabel alloc]init];
    [self addSubview:self.ju_labVoiceTime];
    self.ju_labVoiceTime.font=[UIFont systemFontOfSize:14];
    self.ju_labVoiceTime.textColor=[UIColor darkGrayColor];

    self.ju_imgVoice.juCenterY.equal(0);
    self.ju_imgVoice.juSize(CGSizeMake(20, 20));
    self.ju_labVoiceTime.juCenterY.equal(0);

    if (isLeft) {
        self.ju_imgVoice.image=[UIImage imageNamed:@"chatVoiceRight"];
        self.ju_imgVoice.juTrail.equal(15);
        self.ju_labVoiceTime.juLead.equal(15);

    }else{
        self.ju_imgVoice.image=[UIImage imageNamed:@"chatVoiceLeft"];
        self.ju_imgVoice.juLead.equal(15);
        self.ju_labVoiceTime.juTrail.equal(15);
    }
    self.juWidth.equal(150);
}

-(void)juSetVoiceData:(JuMessageModel *)juModel{
    self.ju_labVoiceTime.text=@"1'22\"";
}
@end
