//
//  JuBubbleView+image.m
//  JuChatMessage
//
//  Created by Juvid on 2018/9/17.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import "JuBubbleView+image.h"
#import "UIImageView+WebCache.h"

@implementation JuBubbleView (image)
-(void)juSetImageView:(BOOL)isRight{
    self.ju_imgMessage=[[JuBubbleImage alloc]init];
    [self.ju_imgMessage setContentMode:UIViewContentModeScaleAspectFill];
    [self.ju_imgMessage setClipsToBounds:YES];

    [self.ju_imgMessage.layer setCornerRadius:8];
    
    [self addSubview:self.ju_imgMessage];
    if (!isRight) {
        self.ju_imgMessage.isLeft=YES;
    }
    self.ju_imgMessage.juEdge(UIEdgeInsetsMake(0, 0, 0, 0));
    self.ju_imgMessage.juWidth.equal(180);
//    self.ju_imgMessage.juHeight.equal(180);

}
-(void)juSetImageData:(JuChatDataAdapter *)juModel{
//    CGFloat width=MIN(100*(juModel.ju_scale+1), 220);
    self.ju_imgMessage.ju_Width.constant=juModel.ju_conSize.width;
//    self.ju_imgMessage.ju_Height.constant=width*juModel.ju_scale;
//    self.ju_imgMessage.juWidth.equal(MIN(120*juModel.ju_scale, 180));
//    self.ju_imgMessage.juAspectWH.multi(juModel.ju_scale).equal(0);
//    if (juModel.isSend) {
        if ([juModel.ju_messageUrl hasPrefix:@"http"]) {
            [self.ju_imgMessage sd_setImageWithURL:[NSURL URLWithString:juModel.ju_thumbUrl] placeholderImage:nil];
        }else{
            [self.ju_imgMessage sd_setImageWithURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@_mini",juModel.ju_messageUrl]]];
        }

}
@end
