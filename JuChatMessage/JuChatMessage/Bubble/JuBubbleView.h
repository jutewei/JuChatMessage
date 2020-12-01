//
//  JuBubbleView.h
//  JuChatMessage
//
//  Created by Juvid on 2016/10/19.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JuBubbleImage.h"
#import "JuChatDataAdapter.h"
#import "JuLayoutFrame.h"
#import "JuMsgConfig.h"
@interface JuBubbleView : UIView

@property (nonatomic,strong) UIImageView *ju_imgBubble;///< 气泡

@property (nonatomic,strong) UILabel *ju_labMessage;///< 文字信息

@property (nonatomic,strong) JuBubbleImage *ju_imgMessage;///< 图片信息

@property (nonatomic,strong) UIImageView *ju_imgVoice;///< 语音信息
@property (nonatomic,strong) UILabel     *ju_labVoiceTime;///< 语音信息

-(void)juSetBubbleContent:(JuChatDataAdapter *)juModel;

-(void)juInitView:(JuChatDataAdapter *)juModel;
@end
