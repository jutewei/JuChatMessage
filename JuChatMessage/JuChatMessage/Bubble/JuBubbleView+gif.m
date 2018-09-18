//
//  JuBubbleView+gif.m
//  JuChatMessage
//
//  Created by Juvid on 2018/9/17.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import "JuBubbleView+gif.h"
#import "CADisplayLineImageView.h"

@implementation JuBubbleView (gif)
-(void)juSetGifView:(BOOL)isRight{
    self.ju_imgMessage=(id)[[CADisplayLineImageView alloc]init];
    [self.ju_imgMessage setContentMode:UIViewContentModeScaleAspectFit];
    [self addSubview:self.ju_imgMessage];
    self.ju_imgMessage.juEdge(UIEdgeInsetsMake(0, 0, 0, 0));
    self.ju_imgBubble.hidden=YES;
}
-(void)juSetGifData:(JuMessageModel *)juModel{
    self.ju_imgMessage.juWidth.equal(MIN(100*juModel.ju_scale, 100));
    self.ju_imgMessage.juAspectWH.multi(1).equal(0);
    self.ju_imgMessage.image=[CADisplayLineImage imageGifNamed:@"emoti_000"];
}
@end
