//
//  JuChatMsgTimeCell.h
//  SkinDoctor
//
//  Created by Juvid on 2019/6/10.
//  Copyright © 2019 meitu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JuChatDataAdapter.h"

NS_ASSUME_NONNULL_BEGIN

@interface JuChatMsgTimeCell : UITableViewCell
@property (nonatomic,readonly) UILabel *ju_labDesc;///< 时间

-(void)mtSetContent:(id)content;

+(UILabel *)mtTimeLable;

+(UIView *)mtTimeView:(id)content;

@end

NS_ASSUME_NONNULL_END
