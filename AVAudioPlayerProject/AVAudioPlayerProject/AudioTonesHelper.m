//
//  AudioTonesHelper.m
//  AVAudioPlayerProject
//
//  Created by Linyoung on 2017/7/29.
//  Copyright © 2017年 Linyoung. All rights reserved.
//

#import "AudioTonesHelper.h"
#import <AVFoundation/AVFoundation.h>

@interface AudioTonesHelper ()<AVAudioPlayerDelegate>

@property (copy, nonatomic) NSString *audioUrl;
@property (strong, nonatomic) AVAudioPlayer *avAudioPlayer;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation AudioTonesHelper

- (id)initWithUrl:(NSString *)audioUrl
       tonesBlock:(TonesBlock)block {
    if (self = [super init]) {
        _audioUrl = audioUrl;
        _tonesBlock = block;
        _captureFrequency = 0.5;
    }
    return self;
}

- (id)initWithUrl:(NSString *)audioUrl {
   return [self initWithUrl:audioUrl tonesBlock:nil];
}

- (id)init {
    return [self initWithUrl:nil tonesBlock:nil];
}

#pragma mark - private methords

- (void)play {
    [self.timer setFireDate:[NSDate date]];
    [self.avAudioPlayer play];
}

- (void)pause {
    //暂停
    [self.timer setFireDate:[NSDate distantFuture]];
    [self.avAudioPlayer pause];
}

- (void)stop {
    [self.timer invalidate];
    self.timer = nil;
    [self.avAudioPlayer stop];
    self.avAudioPlayer = nil;
}

#pragma mark - event response

- (void)timerAction:(NSTimer *)timer {
    //定时器方法
    [self.avAudioPlayer updateMeters];
    CGFloat power = ([self.avAudioPlayer averagePowerForChannel:0] + [self.avAudioPlayer averagePowerForChannel:1])/2;
    if (self.tonesBlock) {
        self.tonesBlock(-power);
    }
    NSLog(@"########平均 = %f########",[self.avAudioPlayer averagePowerForChannel:0]);
    NSLog(@"########最高 = %f########",[self.avAudioPlayer averagePowerForChannel:1]);
    NSLog(@"########高度 = %f########",power);
}

#pragma mark - set and get

- (NSTimer *)timer {
    if (_timer == nil) {
        _timer = [NSTimer timerWithTimeInterval:_captureFrequency target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
        [self.timer setFireDate:[NSDate distantFuture]];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

- (AVAudioPlayer *)avAudioPlayer {
    if (_avAudioPlayer == nil) {
        NSURL *url = [NSURL fileURLWithPath:self.audioUrl];

        _avAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        _avAudioPlayer.delegate = self;
        _avAudioPlayer.volume = 1;
        _avAudioPlayer.numberOfLoops = -1;
        _avAudioPlayer.meteringEnabled = YES;//可以监控音量变化
    }
    return _avAudioPlayer;
}

- (void)setCaptureFrequency:(float)captureFrequency {
    _captureFrequency = captureFrequency;
    _timer = nil;
}


@end
