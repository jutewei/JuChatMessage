//
//  JuChatMessageCell.h
//  JuChatMessage
//
//  Created by Juvid on 2016/10/19.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JuLayoutFrame.h"
#import "JuMsgConfig.h"
#import "JuChatDataAdapter.h"
@protocol JuChatMessageDelegate;
@interface JuBaseMessageCell : UITableViewCell
@property (nonatomic,readonly) UIView *ju_viewBubble;///< 气泡父视图
@property (nonatomic,readonly) UILabel *ju_labName;///< 昵称
@property (nonatomic,readonly) UIImageView *ju_headImage;///< 头像
@property (nonatomic,readonly) UIActivityIndicatorView *ju_actStatus;///< 状态
@property (nonatomic,readonly) UIButton *ju_btnReSend;///< 重新发送
@property (nonatomic,readonly) UIView *ju_vieReadStatus;///< 读取状态
@property (weak, nonatomic) id<JuChatMessageDelegate> delegate;

- (id)initWithModel:(JuChatDataAdapter *)juModel reuseIdentifier:(NSString *)reuseIdentifier;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withModel:(JuChatDataAdapter *)juModel;

/**
 初始化气泡视图（子类必须实现方法）

 @param juModel 模型
 */
-(UIView *)juSetViewBubble:(JuChatDataAdapter *)juModel;

-(void)juSetLayout:(JuChatDataAdapter *)juModel;


@end

@protocol JuChatMessageDelegate <NSObject>
@optional

-(void)juSelectReSend:(UIButton *)sender;
-(void)juSelectHeadImage:(UIButton *)sender;
-(void)juSelectBubble:(id)sender;

@end
