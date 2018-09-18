//
//  JuBubbleView+image.m
//  JuChatMessage
//
//  Created by Juvid on 2018/9/17.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import "JuBubbleView+image.h"

@implementation JuBubbleView (image)
-(void)juSetImageView:(BOOL)isRight{
    self.ju_imgMessage=[[JuBubbleImage alloc]init];
    [self addSubview:self.ju_imgMessage];
    if (!isRight) {
        self.ju_imgMessage.isLeft=YES;
    }
//    if (isLeft) {
        self.ju_imgMessage.juEdge(UIEdgeInsetsMake(0, 0, 0, 0));
//    }else{
//        self.ju_imgMessage.juEdge(UIEdgeInsetsMake(0, 0, 0, 0));
//    }
}
-(void)juSetImageData:(JuMessageModel *)juModel{
    self.ju_imgMessage.juWidth.equal(MIN(100*juModel.ju_scale, 150));
    self.ju_imgMessage.juAspectWH.multi(600.0/891.0).equal(0);
    self.ju_imgMessage.image=[UIImage imageNamed:@"timg.jpeg"];
}
@end
