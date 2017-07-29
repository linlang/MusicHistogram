//
//  TonesHistogramView.m
//  AVAudioPlayerProject
//
//  Created by Linyoung on 2017/7/29.
//  Copyright © 2017年 Linyoung. All rights reserved.
//

#import "TonesHistogramView.h"

@interface TonesHistogramView ()

@property (assign, nonatomic) int pillarsNumber;
@property (assign, nonatomic) CGFloat pillarsWidth;
@property (assign, nonatomic) CGFloat animationDelay;
@property (strong, nonatomic) UIColor *pillarsColor;

@property (strong, nonatomic) NSMutableArray *heights;
@property (strong, nonatomic) NSMutableArray *pillarsLayers;

@end

@implementation TonesHistogramView

- (id)initWithFrame:(CGRect)frame
      pillarsNumber:(int)pillarsNumber
       pillarsWidth:(CGFloat)pillarsWidth
       pillarsColor:(UIColor *)pillarsColor
     animationDelay:(CGFloat)animationDelay {
    if (self = [super initWithFrame:frame]) {
        if (pillarsNumber <= 0) {
            pillarsNumber = 20;
        }
        if (pillarsWidth <= 0) {
            pillarsWidth = 5;
        }
        if (_animationDelay <= 0) {
            _animationDelay = 0.5;
        }
        if (pillarsColor == nil) {
            pillarsColor = [UIColor blackColor];
        }
        _pillarsNumber = pillarsNumber;
        _pillarsWidth = pillarsWidth;
        _pillarsColor = pillarsColor;
        [self initializeHeights];
        [self createSubView];
    }
    return self;
}

- (id)init {
    return [self initWithFrame:CGRectZero pillarsNumber:0 pillarsWidth:0 pillarsColor:nil animationDelay:0];
}

- (id)initWithFrame:(CGRect)frame {
    return  [self initWithFrame:frame pillarsNumber:0 pillarsWidth:0 pillarsColor:nil animationDelay:0];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        _pillarsNumber = 20;
        _pillarsWidth = 5;
        _animationDelay = 0.5;
        _pillarsColor = [UIColor blackColor];
        [self initializeHeights];
        [self createSubView];
    }
    return self;
}


#pragma mark - private methords

- (void)createSubView {
    float height = 0;
    float bgWidth = CGRectGetWidth(self.bounds);
    float bgHeight = CGRectGetHeight(self.bounds);
    float horizontalSpace = (bgWidth-(_pillarsWidth*_pillarsNumber))/(_pillarsNumber+1);
    if (horizontalSpace < 0) {
        horizontalSpace = 0;
    }
    for (int i=0; i<_pillarsNumber; i++) {
        CALayer *pillarsLayer = [CALayer layer];
        pillarsLayer.backgroundColor = _pillarsColor.CGColor;
        pillarsLayer.frame = CGRectMake(horizontalSpace+(horizontalSpace + _pillarsWidth)*i, bgHeight-height, _pillarsWidth, height);
        [self.pillarsLayers addObject:pillarsLayer];
        [self.layer addSublayer:pillarsLayer];
    }
}

- (void)initializeHeights {
    for (int i=0;i<_pillarsNumber;i++) {
        [self.heights addObject:@(0)];
    }
}

- (void)updateHistogramHeight:(CGFloat)height {
    float bgWidth = CGRectGetWidth(self.bounds);
    float bgHeight = CGRectGetHeight(self.bounds);
    float horizontalSpace = (bgWidth-(_pillarsWidth*_pillarsNumber))/(_pillarsNumber+1);
    if (horizontalSpace < 0) {
        horizontalSpace = 0;
    }
    [self pushHeigt:height];
    for (int i=0; i<_pillarsNumber; i++) {
        float layerHeight = [self.heights[i] floatValue];
        CALayer *pillarsLayer = self.pillarsLayers[i];
        pillarsLayer.frame = CGRectMake(horizontalSpace+(horizontalSpace + _pillarsWidth)*i, bgHeight-layerHeight, _pillarsWidth, layerHeight);
    }
}

- (void)pushHeigt:(CGFloat)height {
    [self.heights removeObjectAtIndex:0];
    [self.heights addObject:@(height)];
}

#pragma mark - set and get

- (NSMutableArray *)heights {
    if (_heights == nil) {
        _heights = [[NSMutableArray alloc] init];
    }
    return _heights;
}

- (NSMutableArray *)pillarsLayers {
    if (_pillarsLayers == nil) {
        _pillarsLayers = [[NSMutableArray alloc] init];
    }
    return _pillarsLayers;
}

@end
