//
//  JuChatMessageCell.h
//  JuChatMessage
//
//  Created by Juvid on 2016/10/19.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+JuLayGroup.h"
#import "JuBubbleView.h"
#import "JuMessageModel.h"
@interface JuChatMessageCell : UITableViewCell
@property (nonatomic,strong) JuBubbleView *ju_viewBubble;///< 气泡父视图
@property (nonatomic,strong) UILabel *ju_labName;///< 昵称
@property (nonatomic,strong) UIButton *ju_headImage;///< 头像
@property (nonatomic,copy) JuMessageModel *ju_Model;
@property (nonatomic,strong) UIActivityIndicatorView *ju_sendStatus;///< 状态
@property (nonatomic,strong) UIButton *ju_btnReSend;///< 重新发送




- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withModel:(JuMessageModel *)juModel;

@end
