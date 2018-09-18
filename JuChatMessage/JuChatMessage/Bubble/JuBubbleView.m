//
//  JuBubbleView.m
//  JuChatMessage
//
//  Created by Juvid on 2016/10/19.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import "JuBubbleView.h"
#import "JuBubbleView+gif.h"
#import "JuBubbleView+text.h"
#import "JuBubbleView+image.h"
#import "JuBubbleView+Voice.h"

@implementation JuBubbleView
//+(instancetype)juInit:(JuMessageModel *)juModel{
//    JuBubbleView *bubbleView=[[JuBubbleView alloc]init];
//    return bubbleView;
//}

//初始化视图
-(void)juInitView:(JuMessageModel *)juModel{
    
    _ju_imgBubble=[[UIImageView alloc]init];
    [self addSubview:_ju_imgBubble];
    self.ju_imgBubble.juEdge(UIEdgeInsetsMake(0, 0, 0, 0));

    if (juModel.type==JUMessageBodyTypeText) {
        [self juSetTextView:juModel.isSend];
    }
    else if(juModel.type==JUMessageBodyTypeImage){
        [self juSetImageView:juModel.isSend];
    }
    else if(juModel.type==JUMessageBodyTypeVoice){
        [self juSetVoiceView:juModel.isSend];
    } else if(juModel.type==JUMessageBodyTypeGif){
        [self juSetGifView:juModel.isSend];
    }

    if (juModel.isSend) {
       self.ju_imgBubble.image=[[UIImage imageNamed:@"consult_RightBubble"] stretchableImageWithLeftCapWidth:15 topCapHeight:22];
    }else{
        self.ju_imgBubble.image=[[UIImage imageNamed:@"consult_LeftBubble"] stretchableImageWithLeftCapWidth:20 topCapHeight:22];
    }

    ///< 气泡约束
    self.juHeight.greaterEqual(44);
    self.juTop.equal(25);
    self.juBottom.equal(15);
}

//设置内容
-(void)juSetBubbleContent:(JuMessageModel *)juModel{
    if (juModel.type==JUMessageBodyTypeText) {
        [self juSetTextData:juModel];
    }
    else if(juModel.type==JUMessageBodyTypeImage){
        [self juSetImageData:juModel];
    }
    else if(juModel.type==JUMessageBodyTypeVoice){
        [self juSetVoiceData:juModel];
    }
    else if(juModel.type==JUMessageBodyTypeGif){
        [self juSetGifData:juModel];
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
