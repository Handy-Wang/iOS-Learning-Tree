//
//  IDUILabelVC.m
//  iOSDev
//
//  Created by Handy on 4/25/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "IDUILabelVC.h"
#import "NSString(TS_Attributed).h"

@interface IDUILabelVC ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation IDUILabelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.label.backgroundColor = [UIColor blackColor];
    self.label.textColor = [UIColor greenColor];
    self.label.numberOfLines = 0;
    [self.view addSubview:self.label];
    
    NSString *text = @"动画间隔决定了动画的每秒帧数（FPS），一般的，FPS越高，动画就表现得越流畅，FPS偏低，动画就会不流畅、卡顿。JQuery中，动画间隔默认为13ms，也就是说理想状态下，动画的每秒帧数是70多。实际上，由于JS定时器精度问题，间隔不可能太小；在计算机资源占用比较大时，这个间隔也没办法得到保证；更为严重的是，新一点的浏览器在页面不可见时（例如切换到其他tab，浏览器被最小化），会自动提高定时器执行间隔，firefox5开始，setInterval的间隔在浏览器最小化之后至少被提高到1000ms。动画时长 = 播放总帧数 * 帧间隔平均值。由于帧间隔不可控，可能被提高到1000ms甚至更高，那么实现动画时面临两个选择：要保证播放总帧数，动画时长就会增加；要保证动画时长，就必须牺牲掉总帧数。实际上我们一般采用第二种方式，也就是丢帧保时的策略来实现动画，来看一个简单的例子";
    
    CGSize textSize = CGSizeZero;
    NSDictionary *attr = @{NSFontAttributeName : self.label.font};
    NSAttributedString *attrText = [text getAttributedStringAndItsSize:attr lineSpace:0
                              breakMode:self.label.lineBreakMode
                              alignment:self.label.textAlignment
                        constrainedSize:CGSizeMake(self.view.bounds.size.width, 80)
                               textSize:&textSize];
    
    self.label.attributedText = attrText;
    self.label.frame = CGRectMake(self.label.frame.origin.x, self.label.frame.origin.y, textSize.width, textSize.height);
}

@end
