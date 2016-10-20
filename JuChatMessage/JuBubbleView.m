//
//  JuBubbleView.m
//  JuChatMessage
//
//  Created by Juvid on 2016/10/19.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import "JuBubbleView.h"
#import "JuMessageModel.h"
@implementation JuBubbleView
+(instancetype)juInit:(JuMessageModel *)juModel{
    JuBubbleView *bubbleView=[[JuBubbleView alloc]init];
    [bubbleView juInitView:juModel];
    return bubbleView;
}
-(void)juInitView:(JuMessageModel *)juModel{
    
    _ju_imgBubble=[[UIImageView alloc]init];
    [self addSubview:_ju_imgBubble];
    self.ju_imgBubble.juEdge(UIEdgeInsetsMake(0, 0, 0, 0));

    if (juModel.type==JUMessageBodyTypeText) {
        _ju_labMessage=[[UILabel alloc]init];
        [self addSubview:_ju_labMessage];
        _ju_labMessage.numberOfLines=0;
    }
    else if(juModel.type==JUMessageBodyTypeImage){
        _ju_imgMessage=[[JuBubbleImage alloc]init];
        [self addSubview:_ju_imgMessage];
        _ju_imgMessage.image=[UIImage imageNamed:@"timg.jpeg"];
    }
    else if(juModel.type==JUMessageBodyTypeVoice){
        _ju_imgVoice=[[UIImageView alloc]init];
        [self addSubview:_ju_imgVoice];
        _ju_labVoiceTime=[[UILabel alloc]init];
        [self addSubview:_ju_labVoiceTime];
        _ju_labVoiceTime.font=[UIFont systemFontOfSize:14];
        _ju_labVoiceTime.textColor=[UIColor darkGrayColor];
        _ju_labVoiceTime.text=@"1'22\"";
    }
    if (juModel.isSend) {
         [self juRightLayout];

    }else{
        [self juLeftLayout];
        if (_ju_imgMessage) _ju_imgMessage.isLeft=YES;///< 绘制气泡使用
    }

    if (_ju_imgVoice) {
        _ju_imgVoice.juCenterY.equal(0);
        _ju_imgVoice.juSize(CGSizeMake(20, 20));
        _ju_labVoiceTime.juCenterY.equal(0);
    }

}
-(void)juReSetLayout:(JuMessageModel *)juModel{
    if (_ju_imgMessage) {
        self.ju_imgMessage.juWidth.equal(150*juModel.ju_scale);
        self.ju_imgMessage.juAspectWH.multi(3.0/4.0).equal(0);
//        self.ju_imgMessage.juHeight.priority(750).equal(200*juModel.ju_scale);
    }
}
-(void)juLeftLayout{

    self.ju_imgBubble.image=[[UIImage imageNamed:@"consult_LeftBubble"] stretchableImageWithLeftCapWidth:20 topCapHeight:22];

    if (self.ju_labMessage) {
        self.ju_labMessage.juEdge(UIEdgeInsetsMake(10, 12, 10, 10));
    }
    if (self.ju_imgMessage) {
        self.ju_imgMessage.juEdge(UIEdgeInsetsMake(0, 0, 0, 0));
    }
    if (_ju_imgVoice) {
        _ju_imgVoice.image=[UIImage imageNamed:@"chatVoiceLeft"];
        _ju_imgVoice.juLead.equal(15);
        _ju_labVoiceTime.juTrail.equal(15);
    }
}

-(void)juRightLayout{

    self.ju_imgBubble.image=[[UIImage imageNamed:@"consult_RightBubble"] stretchableImageWithLeftCapWidth:15 topCapHeight:22];

    if (self.ju_labMessage) {
        self.ju_labMessage.juEdge(UIEdgeInsetsMake(10, 10, 10, 12));
    }
    if (self.ju_imgMessage) {
        self.ju_imgMessage.juEdge(UIEdgeInsetsMake(0, 0, 0, 0));

    }
    if (_ju_imgVoice) {
        _ju_imgVoice.image=[UIImage imageNamed:@"chatVoiceRight"];
        _ju_imgVoice.juTrail.equal(15);
        _ju_labVoiceTime.juLead.equal(15);
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
