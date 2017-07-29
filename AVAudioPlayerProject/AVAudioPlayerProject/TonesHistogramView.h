//
//  TonesHistogramView.h
//  AVAudioPlayerProject
//
//  Created by Linyoung on 2017/7/29.
//  Copyright © 2017年 Linyoung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TonesHistogramView : UIView

/**
 * 初始化方法
 * pillarsNumber 设置圆柱个数 默认为20
 * pillarsWidth 设置圆柱宽度 默认5
 * pillarsColor 柱状图颜色
 * animationDelay 柱状图高度变化间隔时间
 */

- (id)initWithFrame:(CGRect)frame
      pillarsNumber:(int)pillarsNumber
       pillarsWidth:(CGFloat)pillarsWidth
       pillarsColor:(UIColor *)pillarsColor
     animationDelay:(CGFloat)animationDelay;

/**
 * 更新柱状图高度
 */
- (void)updateHistogramHeight:(CGFloat)height;


@end
