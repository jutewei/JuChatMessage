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
@protocol JuChatMessageDelegate;
@interface JuBaseMessageCell : UITableViewCell
@property (nonatomic,readonly) JuBubbleView *ju_viewBubble;///< 气泡父视图
@property (nonatomic,readonly) UILabel *ju_labName;///< 昵称
@property (nonatomic,readonly) UIButton *ju_headImage;///< 头像
@property (nonatomic,copy) JuMessageModel *ju_Model;
@property (nonatomic,readonly) UIActivityIndicatorView *ju_actStatus;///< 状态
@property (nonatomic,readonly) UIButton *ju_btnReSend;///< 重新发送

@property (weak, nonatomic) id<JuChatMessageDelegate> delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withModel:(JuMessageModel *)juModel;

@end

@protocol JuChatMessageDelegate <NSObject>
@optional
-(void)juSelectReSend:(UIButton *)sender;
-(void)juSelectHeadImage:(UIButton *)sender;
-(void)juSelectBubble:(id)sender;

@end
