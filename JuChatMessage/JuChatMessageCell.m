//
//  JuChatMessageCell.m
//  JuChatMessage
//
//  Created by Juvid on 2016/10/19.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import "JuChatMessageCell.h"
#import "UIView+JuLayGroup.h"
@implementation JuChatMessageCell

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
    [self.contentView addSubview:_ju_headImage];
    [_ju_headImage.layer setCornerRadius:20];
    [_ju_headImage setClipsToBounds:YES];

    _ju_viewBubble=[JuBubbleView juInit:juModel];
    [self.contentView addSubview:_ju_viewBubble];

    _ju_sendStatus=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.contentView addSubview:_ju_sendStatus];
    [_ju_sendStatus startAnimating];

    _ju_btnReSend=[[UIButton alloc]init];
    [self.contentView addSubview:_ju_btnReSend];
//    _ju_btnReSend.backgroundColor=[UIColor redColor];

    [self juSetLayout:juModel];

}
-(void)setJu_Model:(JuMessageModel *)ju_Model{
    _ju_Model=ju_Model;
    _ju_viewBubble.ju_labMessage.text=ju_Model.ju_messageText;
    [_ju_headImage setBackgroundImage:[UIImage imageNamed:@"assistor_news0_03"] forState:UIControlStateNormal];
}
-(void)juLeftLayout{
    self.ju_headImage.juFrame(CGRectMake(10, 10, 40, 40));
    self.ju_viewBubble.juLeaSpace.toView(self.ju_headImage).equal(8);
    self.ju_viewBubble.juTrail.lessEqual(80);

    _ju_sendStatus.juLeaSpace.toView(_ju_viewBubble).equal(10);

    _ju_btnReSend.juLeaSpace.toView(_ju_viewBubble).equal(10);

}

-(void)juRightLayout{
    self.ju_headImage.juFrame(CGRectMake(-10, 10, 40, 40));
    self.ju_viewBubble.juTraSpace.toView(self.ju_headImage).equal(-8);
    self.ju_viewBubble.juLead.greaterEqual(80);
    _ju_sendStatus.juTraSpace.toView(_ju_viewBubble).equal(-10);

    _ju_btnReSend.juTraSpace.toView(_ju_viewBubble).equal(-10);

}
-(void)juSetLayout:(JuMessageModel *)juModel{
    if (juModel.isSend) {
        [self juRightLayout];
    }else{
        [self juLeftLayout];
    }

    _ju_viewBubble.juHeight.greaterEqual(44);
    self.ju_viewBubble.juTop.equal(25);
    self.ju_viewBubble.juBottom.equal(15);

    if (juModel.type==JUMessageBodyTypeVoice) {
        _ju_viewBubble.juWidth.equal(200);
    }
    _ju_btnReSend.juSize(CGSizeMake(30, 30));
    _ju_btnReSend.juCenterY.toView(_ju_viewBubble).equal(0);

    _ju_sendStatus.juCenterY.toView(_ju_viewBubble).equal(0);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
