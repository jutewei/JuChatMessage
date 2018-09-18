//
//  JuChatMessageCell.m
//  JuChatMessage
//
//  Created by Juvid on 2018/9/18.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import "JuChatMessageCell.h"

@implementation JuChatMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
//赋值
-(void)setJu_Model:(JuMessageModel *)ju_Model{
    _ju_Model=ju_Model;
    [self.ju_actStatus startAnimating];
    self.ju_viewBubble.ju_labMessage.text=ju_Model.ju_messageText;
    [self.ju_headImage setBackgroundImage:[UIImage imageNamed:@"assistor_news0_03"] forState:UIControlStateNormal];
    [self.ju_viewBubble juSetBubbleContent:ju_Model];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
