//
//  JuBubbleImage.m
//  JuChatMessage
//
//  Created by Juvid on 2016/10/19.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import "JuBubbleImage.h"

@implementation JuBubbleImage
-(void)layoutSubviews{
    [super layoutSubviews];

    NSString *imgName=@"consult_RightBubble";
    if (_isLeft) {
        imgName=@"consult_LeftBubble";
    }
    UIImage *bubble = [UIImage imageNamed:imgName];
    UIImageView *imageBubble = [[UIImageView alloc] init];
    [imageBubble setFrame:self.frame];
    [imageBubble setImage:[bubble stretchableImageWithLeftCapWidth:15 topCapHeight:15]];
    CALayer *layer              = imageBubble.layer;
    layer.frame                 = (CGRect){{0,0},imageBubble.layer.frame.size};
    self.layer.mask = layer;
    [self setNeedsDisplay];
}
-(void)didMoveToWindow{
    [super didMoveToWindow];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
