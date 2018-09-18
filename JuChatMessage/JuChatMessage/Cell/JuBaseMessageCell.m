//
//  JuChatMessageCell.m
//  JuChatMessage
//
//  Created by Juvid on 2016/10/19.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import "JuBaseMessageCell.h"
#import "UIView+JuLayGroup.h"
@implementation JuBaseMessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withModel:(JuMessageModel *)juModel{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self juInitView:juModel];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)juInitView:(JuMessageModel *)juModel{

    _ju_headImage=[[UIButton alloc]init];
    [_ju_headImage addTarget:self action:@selector(juTouchHead:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_ju_headImage];
    [_ju_headImage.layer setCornerRadius:20];
    [_ju_headImage setClipsToBounds:YES];

    _ju_viewBubble=[JuBubbleView juInit:juModel];
    [self.contentView addSubview:_ju_viewBubble];
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(juTouchBubbleView:)];
    [_ju_viewBubble addGestureRecognizer:tapRecognizer];

    _ju_btnReSend=[[UIButton alloc]init];
    [_ju_btnReSend addTarget:self action:@selector(juTouchReSend:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_ju_btnReSend];

    _ju_actStatus=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _ju_actStatus.hidesWhenStopped=YES;
    [self.contentView addSubview:_ju_actStatus];

    [self juSetLayout:juModel];
}



-(void)setJu_Model:(JuMessageModel *)ju_Model{
    _ju_Model=ju_Model;
    [_ju_viewBubble juReSetLayout:ju_Model];
    [_ju_actStatus startAnimating];
    _ju_viewBubble.ju_labMessage.text=ju_Model.ju_messageText;
    [_ju_headImage setBackgroundImage:[UIImage imageNamed:@"assistor_news0_03"] forState:UIControlStateNormal];
    [_ju_viewBubble juSetBubbleContent:ju_Model];
}

-(void)juSetLayout:(JuMessageModel *)juModel{
    if (juModel.isSend) {
        [self juRightLayout];
    }else{
        [self juLeftLayout];
    }
    ///< 气泡约束
    _ju_viewBubble.juHeight.greaterEqual(44);
    _ju_viewBubble.juTop.equal(25);
    _ju_viewBubble.juBottom.equal(15);

    if (juModel.type==JUMessageBodyTypeVoice) {
        _ju_viewBubble.juWidth.equal(150);
    }
    _ju_btnReSend.juSize(CGSizeMake(30, 30));
    _ju_btnReSend.juCenterY.toView(_ju_viewBubble).equal(0);

    _ju_actStatus.juCenterY.toView(_ju_viewBubble).equal(0);
}
-(void)juLeftLayout{
    _ju_headImage.juFrame(CGRectMake(10, 10, 40, 40));

    ///< 气泡约束
    _ju_viewBubble.juLeaSpace.toView(_ju_headImage).equal(8);
    _ju_viewBubble.juTrail.lessEqual(80);

    _ju_actStatus.juLeaSpace.toView(_ju_viewBubble).equal(10);

    _ju_btnReSend.juLeaSpace.toView(_ju_viewBubble).equal(10);

}

-(void)juRightLayout{
    _ju_headImage.juFrame(CGRectMake(-10, 10, 40, 40));
     ///< 气泡约束
    _ju_viewBubble.juTraSpace.toView(_ju_headImage).equal(-8);
    _ju_viewBubble.juLead.greaterEqual(80);

    _ju_actStatus.juTraSpace.toView(_ju_viewBubble).equal(-10);

    _ju_btnReSend.juTraSpace.toView(_ju_viewBubble).equal(-10);

}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
/**
 点击气泡

 @param tapRecognizer 手势
 */
- (void)juTouchBubbleView:(UITapGestureRecognizer *)tapRecognizer
{

    if (tapRecognizer.state == UIGestureRecognizerStateEnded) {
        if ([_delegate respondsToSelector:@selector(juSelectBubble:)]) {
            [_delegate juSelectBubble:_ju_Model];
        }
        NSLog(@"点击了气泡 ");
    }
}

/**
 消息重发

 @param sender button
 */
-(void)juTouchReSend:(UIButton *)sender{
    if ([_delegate respondsToSelector:@selector(juSelectReSend:)]) {
        [_delegate juSelectReSend:sender];
    }
    NSLog(@"重发消息");
}

/**
 点击头像

 @param sender 头像
 */
-(void)juTouchHead:(UIButton *)sender{
    if ([_delegate respondsToSelector:@selector(juSelectHeadImage:)]) {
        [_delegate juSelectHeadImage:sender];
    }
    NSLog(@"点击头像");

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end