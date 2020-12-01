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
-(void)juInitView:(JuChatDataAdapter *)juModel{
    
    _ju_imgBubble=[[UIImageView alloc]init];
    [self addSubview:_ju_imgBubble];
    self.ju_imgBubble.juEdge(UIEdgeInsetsMake(0, 0, 0, 0));

    if (juModel.ju_mesageType==JUMessageBodyTypeText) {
        [self juSetTextView:juModel.isSend];
    }
    else if(juModel.ju_mesageType==JUMessageBodyTypeImage){
        [self juSetImageView:juModel.isSend];
    }
    else if(juModel.ju_mesageType==JUMessageBodyTypeVoice){
        [self juSetVoiceView:juModel.isSend];
    } else if(juModel.ju_mesageType==JUMessageBodyTypeGif){
        [self juSetGifView:juModel.isSend];
    }
    if (juModel.isSend) {
        [self.ju_imgBubble.layer setCornerRadius:8];
        self.ju_imgBubble.backgroundColor=JUMsgColor_BubbleRight;
//       self.ju_imgBubble.image=[JuChatImageName(@"consult_RightBubble") stretchableImageWithLeftCapWidth:15 topCapHeight:30];
    }else{
//        self.ju_imgBubble.image=[JuChatImageName(@"consult_LeftBubble") stretchableImageWithLeftCapWidth:15 topCapHeight:30];
        [self.ju_imgBubble.layer setCornerRadius:8];
        self.ju_imgBubble.backgroundColor=JUMsgColor_BubbleLeft;
    }

    ///< 气泡约束
    self.juHeight.greaterEqual(44);
    self.juTop.equal(25);
    self.juBottom.equal(15);
}

//设置内容
-(void)juSetBubbleContent:(JuChatDataAdapter *)juModel{
    if (juModel.ju_mesageType==JUMessageBodyTypeText) {
        [self juSetTextData:juModel];
    }
    else if(juModel.ju_mesageType==JUMessageBodyTypeImage){
        [self juSetImageData:juModel];
    }
    else if(juModel.ju_mesageType==JUMessageBodyTypeVoice){
        [self juSetVoiceData:juModel];
    }
    else if(juModel.ju_mesageType==JUMessageBodyTypeGif){
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
