//
//  JuBubbleView+text.m
//  JuChatMessage
//
//  Created by Juvid on 2018/9/17.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import "JuBubbleView+text.h"

@implementation JuBubbleView (text)
-(void)juSetTextView:(BOOL)isRight{
    self.ju_labMessage=[[UILabel alloc]init];
    self.ju_labMessage.font=[UIFont systemFontOfSize:14];
    [self addSubview:self.ju_labMessage];
    self.ju_labMessage.numberOfLines=0;
    if (isRight) {
        self.ju_labMessage.juEdge(UIEdgeInsetsMake(10, 12, 10, 12));
    }else{
        self.ju_labMessage.juEdge(UIEdgeInsetsMake(10, 12, 10, 12));
    }
}

-(void)juSetTextData:(JuChatDataAdapter *)juModel{
    
    if (juModel.ju_attributeText) {
        self.ju_labMessage.attributedText=juModel.ju_attributeText;
    }else{
        self.ju_labMessage.text=juModel.ju_messageText;
    }

    if (juModel.isSend) {
        self.ju_labMessage.textColor=JUMsgColor_ChatText;
    }else{
        self.ju_labMessage.textColor=JUMsgColor_ChatText;
    }
}

@end
