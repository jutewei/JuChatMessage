//
//  JuDisplayLineImage.h
//  JuDisplay
//
//  Created by Juvid on 16/4/26.
//  Copyright © 2016年 zhutianwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JuDisplayLineImage : UIImage

@property (nonatomic,readonly) NSTimeInterval *frameDurations;
@property (nonatomic,readonly) NSUInteger loopCount;
@property (nonatomic,readonly) NSTimeInterval totalDuratoin;

-(UIImage *)getFrameWithIndex:(NSUInteger)idx;
+(UIImage *)imageGifNamed:(NSString *)name;
@end
