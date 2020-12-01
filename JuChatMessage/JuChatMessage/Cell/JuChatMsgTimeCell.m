//
//  JuChatMsgTimeCell.m
//  SkinDoctor
//
//  Created by Juvid on 2019/6/10.
//  Copyright © 2019 meitu. All rights reserved.
//

#import "JuChatMsgTimeCell.h"
#import "JuLayoutFrame.h"
#import "JuMsgConfig.h"

@implementation JuChatMsgTimeCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self juInitView];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)juInitView{
    self.contentView.backgroundColor=JUMsgColor_BackGround;
    UILabel *labTime=[JuChatMsgTimeCell mtTimeLable];
    [self.contentView addSubview:labTime];
    labTime.juOrigin(CGPointMake(0, 0));
    labTime.text=@"08:00";
    _ju_labDesc=labTime;
}
-(void)mtSetContent:(id)content{
    _ju_labDesc.text=content;
}

+(UILabel *)mtTimeLable{
    UILabel *labTime=[[UILabel alloc]init];
    labTime.font=[UIFont systemFontOfSize:11];
    labTime.textColor=JUMsgColor_TimeText;
    return labTime;
}
+(UIView *)mtTimeView:(id)content{
    UIView *view=[[UIView alloc]init];
    UILabel *labTime=[JuChatMsgTimeCell mtTimeLable];
    [view addSubview:labTime];
    labTime.juOrigin(CGPointMake(0, -.01));
    labTime.juWidth.greaterEqual(50);
    [view layoutIfNeeded];
    labTime.text=content;
    return view;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
