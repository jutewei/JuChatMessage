//
//  JuChatMessageCell.m
//  JuChatMessage
//
//  Created by Juvid on 2018/9/18.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import "JuChatMessageCell.h"
#import "UIImageView+WebCache.h"
@implementation JuChatMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
//赋值
-(void)setJu_Model:(JuChatDataAdapter *)ju_Model{
    self.contentView.backgroundColor=JUMsgColor_BackGround;
    _ju_Model=ju_Model;

    if (ju_Model.sendeStatus==0) {
        [self.ju_actStatus startAnimating];
    }else {
        [self.ju_actStatus stopAnimating];
    }

    self.ju_btnReSend.hidden=(ju_Model.sendeStatus!=2);

    self.ju_vieReadStatus.hidden=!(ju_Model.ju_mesageType==JUMessageBodyTypeVoice&&!ju_Model.isRead);///语音未读才显示
    [self.ju_headImage sd_setImageWithURL:[NSURL URLWithString:ju_Model.ju_userHeadUrl] placeholderImage:[UIImage imageNamed:@"assistor_news0_03"]];
//    [self.ju_headImage setUserThumbImage:ju_Model.ju_userHeadUrl placeholderImage:@"default_chatHead"];
    [(JuBubbleView *)self.ju_viewBubble juSetBubbleContent:ju_Model];
}

/**初始化气泡*/
-(UIView *)juSetViewBubble:(JuChatDataAdapter *)juModel{
    JuBubbleView *viewBubble=[[JuBubbleView alloc]init];
    [viewBubble juInitView:juModel];
    return viewBubble;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
