//
//  JuBubbleView+Voice.h
//  JuChatMessage
//
//  Created by Juvid on 2018/9/17.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import "JuBubbleView.h"

@interface JuBubbleView (Voice)
-(void)juSetVoiceView:(BOOL)isRight;
-(void)juSetVoiceData:(JuMessageModel *)juModel;
@end
