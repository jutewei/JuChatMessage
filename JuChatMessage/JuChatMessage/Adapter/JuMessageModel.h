//
//  JuMessageModel.h
//  JuChatMessage
//
//  Created by Juvid on 2016/10/19.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JuChatDataProtocol.h"

@interface JuMessageModel : NSObject
@property BOOL isSend;
@property (nonatomic, assign) JUMessageBodyType type;

@property (nonatomic, strong) NSDictionary *ju_content;
@property (nonatomic,strong) NSString *ju_messageText;
@property (nonatomic,assign) float ju_scale;


@end
