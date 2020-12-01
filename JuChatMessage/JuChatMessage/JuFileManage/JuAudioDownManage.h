//
//  JuAudioDownManage.h
//  MTSkinPublic
//
//  Created by Juvid on 2019/6/10.
//  Copyright © 2019 Juvid. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^__nullable JuAudioHandle)(id _Nullable result);             //下步操作后有跟新数据

@interface JuAudioDownManage : NSObject
+ (instancetype) sharedInstance;

-(void)mtDownDataURL:(NSString *)urls handle:(JuAudioHandle)handle;

+(NSString *)mtGetExistFile:(NSString *)url;
@end

NS_ASSUME_NONNULL_END
