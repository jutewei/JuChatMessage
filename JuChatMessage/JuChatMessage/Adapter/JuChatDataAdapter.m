//
//  JuChatDataAdapter.m
//  MTIMKit_Example
//
//  Created by Juvid on 2019/6/4.
//  Copyright © 2019 美图. All rights reserved.
//

#import "JuChatDataAdapter.h"
#import "JuMessageModel.h"

@implementation JuChatDataAdapter

+ (instancetype)initWithData:(id)data {
    JuChatDataAdapter *adpter = [[[self class]alloc] init];
    if (adpter) {
        adpter.mtData = data;
    }
    return adpter;
}
-(JuMessageModel *)shM{
    return self.mtData;
}

- (NSString *)ju_messageText{
    return self.shM.ju_messageText;
}
- (NSString *)ju_messageUrl{
    return self.shM.ju_content[@"url"];
}
- (NSString *)ju_thumbUrl{
    return self.ju_messageUrl;
}
- (JUMessageBodyType )ju_mesageType{
    return self.shM.type;
}
- (CGSize )ju_conSize{
    if (self.shM.ju_scale==0) {
        return CGSizeMake(220, 220);
    }
    return CGSizeMake(30, self.shM.ju_scale);
}
- (BOOL )isSend{
    return self.shM.isSend;
}
- (NSString *)ju_duration{
    return nil;
}
-(NSString *)ju_identifier{
    NSArray *arrSend=@[@"left",@"right"];
    //    NSArray *arrType=@[@"text",@"image",@"voice"];
    return [NSString stringWithFormat:@"message%@%u",arrSend[self.isSend],self.ju_mesageType];
}
- (NSInteger )sendeStatus{
    return 0;
}
-(id)juData{
    return self.mtData;
}
- (NSString *)ju_msgTime{
    return @"09:00";
}
- (NSTimeInterval )ju_creatTime{
    return [[NSDate date] timeIntervalSince1970];
}
- (NSString *)ju_userHeadUrl{
    return @"";
}
- (NSString *)ju_userName{
    return @"assistor_news0_03";
}
- (BOOL)isRead{
    return NO;
}

- (nonnull id)juMsgExtM {
    return nil;
}
-(NSAttributedString *)ju_attributeText{
    return nil;
}
@end
