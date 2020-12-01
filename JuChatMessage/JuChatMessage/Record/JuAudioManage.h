//
//  JuRecordManage.h
//  MTIMKit_Example
//
//  Created by Juvid on 2019/6/4.
//  Copyright © 2019 美图. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface JuAudioManage : NSObject

@property (nonatomic,strong) NSString *ju_voicePath;//录音路径

@property (nonatomic,strong) NSDictionary * _Nullable ju_mediaM;//语音模型

+ (instancetype) sharedInstance;
/**开始录音**/
-(void)juStartRecordWithPath:(NSString *)path;

-(void)juEndRecord;

-(double)juGetVoiceMeters;

- (NSString *)convertAMRToWAV:(NSString *)amrFilePath;

- (NSString *)convertWAVToAMR:(NSString *)wavFilePath;

@end

NS_ASSUME_NONNULL_END
