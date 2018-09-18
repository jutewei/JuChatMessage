//
//  JuBubbleView+image.m
//  JuChatMessage
//
//  Created by Juvid on 2018/9/17.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import "JuBubbleView+image.h"

@implementation JuBubbleView (image)
-(void)shSetImageView:(BOOL)isLeft{
    self.ju_imgMessage=[[JuBubbleImage alloc]init];
    [self addSubview:self.ju_imgMessage];
    if (isLeft) {
        self.ju_imgMessage.juEdge(UIEdgeInsetsMake(0, 0, 0, 0));
    }else{
        self.ju_imgMessage.juEdge(UIEdgeInsetsMake(0, 0, 0, 0));
    }
}
-(void)juSetImageData:(JuMessageModel *)juModel{
    self.ju_imgMessage.image=[UIImage imageNamed:@"timg.jpeg"];
}
@end
