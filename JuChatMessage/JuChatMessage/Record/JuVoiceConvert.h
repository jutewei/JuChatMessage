//
//  JuVoiceConvert.h
//  JuChatMessage
//
//  Created by Juvid on 2020/11/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JuVoiceConvert : NSObject
+ (void)wavToMp3:(NSString*)wavPath mp3SavePath:(NSString *)mp3Path;
@end

NS_ASSUME_NONNULL_END
