//
//  AudioTonesHelper.h
//  AVAudioPlayerProject
//
//  Created by Linyoung on 2017/7/29.
//  Copyright © 2017年 Linyoung. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^TonesBlock)(float tones);

@interface AudioTonesHelper : NSObject

@property (copy, nonatomic) TonesBlock tonesBlock;
@property (assign, nonatomic) float captureFrequency;//采集频率 默认0.5秒

/**
 * 该工具只能播放本地音乐
 **/
- (id)initWithUrl:(NSString *)audioUrl
       tonesBlock:(TonesBlock)block NS_DESIGNATED_INITIALIZER;

- (id)initWithUrl:(NSString *)audioUrl;

//播放
- (void)play;
//暂停
- (void)pause;
//停止
- (void)stop;

@end
