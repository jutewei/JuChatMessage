//
//  JuChatMessageCell.m
//  JuChatMessage
//
//  Created by Juvid on 2016/10/19.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import "JuBaseMessageCell.h"
#import "JuLayoutFrame.h"
@implementation JuBaseMessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withModel:(JuChatDataAdapter *)juModel{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self juInitView:juModel];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (id)initWithModel:(JuChatDataAdapter *)juModel reuseIdentifier:(NSString *)reuseIdentifier{
    self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier withModel:juModel];
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)juInitView:(JuChatDataAdapter *)juModel{
    self.backgroundColor=JUMsgColor_BackGround;

    _ju_headImage=[[UIImageView alloc]init];
    [self.contentView addSubview:_ju_headImage];
    [_ju_headImage.layer setCornerRadius:20];
    _ju_headImage.userInteractionEnabled=YES;
    [_ju_headImage setClipsToBounds:YES];
    UITapGestureRecognizer *tapHead = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(juTouchHead:)];
    [_ju_headImage addGestureRecognizer:tapHead];

    _ju_viewBubble=[self juSetViewBubble:juModel];
    [self.contentView addSubview:_ju_viewBubble];

    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(juTouchBubbleView:)];
    [_ju_viewBubble addGestureRecognizer:tapRecognizer];


    if (juModel.isSend) {
        _ju_btnReSend=[[UIButton alloc]init];
        [_ju_btnReSend addTarget:self action:@selector(juTouchReSend:) forControlEvents:UIControlEventTouchUpInside];
        [_ju_btnReSend setImage:JuChatImageName(@"messageSendFail") forState:UIControlStateNormal];
        [self.contentView addSubview:_ju_btnReSend];

        _ju_actStatus=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _ju_actStatus.hidesWhenStopped=YES;
        [self.contentView addSubview:_ju_actStatus];

    }
    else{
        _ju_vieReadStatus=[[UIView alloc]init];
        _ju_vieReadStatus.backgroundColor=[UIColor redColor];
        [_ju_vieReadStatus.layer setCornerRadius:4.5];
        _ju_vieReadStatus.hidden=YES;
        [self.contentView addSubview:_ju_vieReadStatus];
    }
    [self juSetLayout:juModel];
}
//设置内容容器
-(UIView *)juSetViewBubble:(JuChatDataAdapter *)juModel{
    return nil;
}

-(void)juSetLayout:(JuChatDataAdapter *)juModel{

    CGFloat topEdge=8;

    if (juModel.isSend) {///右边
        _ju_headImage.juFrame(CGRectMake(-18, topEdge, 36, 36));
        ///< 气泡约束
        _ju_viewBubble.juTraSpace.toView(_ju_headImage).equal(8);
        _ju_viewBubble.juLead.greaterEqual(60);

        _ju_actStatus.juTraSpace.toView(_ju_viewBubble).equal(10);
        _ju_actStatus.juCenterY.toView(_ju_viewBubble).equal(0);

        _ju_btnReSend.juTraSpace.toView(_ju_viewBubble).equal(10);
        _ju_btnReSend.juSize(CGSizeMake(30, 30));
        _ju_btnReSend.juCenterY.toView(_ju_viewBubble).equal(0);

    }else{
        _ju_headImage.juFrame(CGRectMake(18, topEdge, 36, 36));
        ///< 气泡约束
        _ju_viewBubble.juLeaSpace.toView(_ju_headImage).equal(8);
        _ju_viewBubble.juTrail.greaterEqual(60);

        //        _ju_actStatus.juLeaSpace.toView(_ju_viewBubble).equal(10);
        _ju_vieReadStatus.juSize(CGSizeMake(9, 9));
        _ju_vieReadStatus.juLeaSpace.toView(_ju_viewBubble).equal(10);
        _ju_vieReadStatus.juCenterY.toView(_ju_viewBubble).equal(0);
        //        _ju_btnReSend.juLeaSpace.toView(_ju_viewBubble).equal(10);
    }
    ///< 气泡约束
    _ju_viewBubble.juHeight.greaterEqual(38);
    _ju_viewBubble.juTop.equal(topEdge);
    _ju_viewBubble.juBottom.equal(24);

    //    _ju_actStatus.juCenterY.toView(_ju_viewBubble).equal(0);
}


/**
 点击气泡

 @param tapRecognizer 手势
 */
- (void)juTouchBubbleView:(UITapGestureRecognizer *)tapRecognizer
{

    if (tapRecognizer.state == UIGestureRecognizerStateEnded) {
        if ([_delegate respondsToSelector:@selector(juSelectBubble:)]) {
            [_delegate juSelectBubble:self];
        }
//        NSLog(@"点击了气泡 ");
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
-(void)juTouchHead:(UITapGestureRecognizer *)sender{
    if ([_delegate respondsToSelector:@selector(juSelectHeadImage:)]) {
        [_delegate juSelectHeadImage:sender.view];
    }
    NSLog(@"点击头像");

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
