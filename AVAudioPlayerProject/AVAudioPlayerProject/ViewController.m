//
//  ViewController.m
//  AVAudioPlayerProject
//
//  Created by Linyoung on 2017/7/28.
//  Copyright © 2017年 Linyoung. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ImageHelper.h"
#import "AudioTonesHelper.h"
#import "TonesHistogramView.h"

@interface ViewController ()

@property (strong, nonatomic) TonesHistogramView *histogramView;
@property (strong, nonatomic) UIButton *playBtn;
@property (strong, nonatomic) UIButton *pauseBtn;
@property (strong, nonatomic) UIButton *stopBtn;

@property (strong, nonatomic) AudioTonesHelper *audioHelper;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createSubViews];
    [self initializeAudio];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - private methords

- (void)createSubViews {
    float screenWidth = [UIScreen mainScreen].bounds.size.width;
    float btnWidth = 80;
    float btnHeight = 35;
    float horizontalSpacing = (screenWidth - 3*btnWidth)/4.0;
//    self.histogramView.frame = CGRectMake((screenWidth-300)/2.0, 50, 300, 250);
    self.pauseBtn.frame = CGRectMake(horizontalSpacing + (btnWidth+horizontalSpacing)*0, CGRectGetMaxY(self.histogramView.frame)+30, btnWidth, btnHeight);
    self.playBtn.frame = CGRectMake(horizontalSpacing + (btnWidth+horizontalSpacing)*1, CGRectGetMaxY(self.histogramView.frame)+30, btnWidth, btnHeight);
    self.stopBtn.frame = CGRectMake(horizontalSpacing + (btnWidth+horizontalSpacing)*2, CGRectGetMaxY(self.histogramView.frame)+30, btnWidth, btnHeight);
    
    [self.view addSubview:self.histogramView];
    [self.view addSubview:self.pauseBtn];
    [self.view addSubview:self.playBtn];
    [self.view addSubview:self.stopBtn];
}

- (void)initializeAudio {
    
    __weak __typeof(&*self)weakSelf = self;
    NSString *audioPath = [[NSBundle mainBundle] pathForResource:@"一千个伤心的理由" ofType:@"mp3"];
    self.audioHelper = [[AudioTonesHelper alloc] initWithUrl:audioPath tonesBlock:^(float tones) {
        NSLog(@"###%f####",tones);
        [weakSelf.histogramView updateHistogramHeight:tones];
    }];
    self.audioHelper.captureFrequency = 0.3;
}


#pragma mark - event response

- (void)playAction:(UIButton *)sender {
    //播放
    [self.audioHelper play];
}

- (void)pauseAction:(UIButton *)sender {
    //暂停
    [self.audioHelper pause];
}

- (void)stopAction:(UIButton *)sender {
    //停止
    [self.audioHelper stop];
}

#pragma mark - set and get

- (TonesHistogramView *)histogramView {
    if (_histogramView == nil) {
        _histogramView = [[TonesHistogramView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-300)/2.0, 50, 300, 250) pillarsNumber:20 pillarsWidth:10 pillarsColor:[UIColor colorWithRed:141.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1] animationDelay:0.3];
        _histogramView.backgroundColor = [UIColor yellowColor];
    }
    return _histogramView;
}

- (UIButton *)playBtn {
    if (_playBtn == nil) {
        _playBtn = [[UIButton alloc] init];
        _playBtn.layer.cornerRadius = 5;
        _playBtn.layer.masksToBounds = YES;
        [_playBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [_playBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        [_playBtn setTitle:@"播放" forState:UIControlStateNormal];
        [_playBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _playBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_playBtn setBackgroundImage:[ImageHelper drawImageWithColor:[UIColor colorWithRed:255.0/255.0 green:215.0/255.0 blue:0 alpha:1]] forState:UIControlStateNormal];
        [_playBtn addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}

- (UIButton *)pauseBtn {
    if (_pauseBtn == nil) {
        _pauseBtn = [[UIButton alloc] init];
        _pauseBtn.layer.cornerRadius = 5;
        _pauseBtn.layer.masksToBounds = YES;
        [_pauseBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [_pauseBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        [_pauseBtn setTitle:@"暂停" forState:UIControlStateNormal];
        [_pauseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _pauseBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_pauseBtn setBackgroundImage:[ImageHelper drawImageWithColor:[UIColor colorWithRed:255.0/255.0 green:215.0/255.0 blue:0 alpha:1]] forState:UIControlStateNormal];        [_pauseBtn addTarget:self action:@selector(pauseAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pauseBtn;
}

- (UIButton *)stopBtn {
    if (_stopBtn == nil) {
        _stopBtn = [[UIButton alloc] init];
        _stopBtn.layer.cornerRadius = 5;
        _stopBtn.layer.masksToBounds = YES;
        [_stopBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [_stopBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        [_stopBtn setTitle:@"停止" forState:UIControlStateNormal];
        [_stopBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _stopBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_stopBtn setBackgroundImage:[ImageHelper drawImageWithColor:[UIColor colorWithRed:255.0/255.0 green:215.0/255.0 blue:0 alpha:1]] forState:UIControlStateNormal];
        [_stopBtn addTarget:self action:@selector(stopAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _stopBtn;
}

@end















