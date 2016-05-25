//
//  IDUILabelVC.m
//  iOSDev
//
//  Created by Handy on 4/25/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "IDUILabelVC.h"
#import "NSString(TS_Attributed).h"
#import "BSLabel.h"

@interface IDUILabelVC ()

@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UILabel *label3;
@property (nonatomic, strong) UILabel *label4;
@property (nonatomic, strong) UILabel *labelBaseline;

@end

@implementation IDUILabelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self calculateMultiLine];
    [self testBaseline];
    [self testNumberOfLineAndParagraphStyle];
    
}

- (void)calculateMultiLine {
    self.label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.view.ts_width, self.view.ts_height)];
    self.label1.layer.borderColor = [UIColor redColor].CGColor;
    self.label1.layer.borderWidth = 1;
    self.label1.backgroundColor = [UIColor blackColor];
    self.label1.textColor = [UIColor greenColor];
    self.label1.numberOfLines = 0;
    [self.view addSubview:self.label1];
    
    NSString *text = @"动画间隔决定了动画的每秒帧数（FPS），一般的，FPS越高，动画就表现得越流畅，FPS偏低，动画就会不流畅、卡顿。JQuery中，动画间隔默认为13ms，也就是说理想状态下，动画的每秒帧数是70多。实际上，由于JS定时器精度问题，间隔不可能太小；在计算机资源占用比较大时，这个间隔也没办法得到保证；更为严重的是，新一点的浏览器在页面不可见时（例如切换到其他tab，浏览器被最小化），会自动提高定时器执行间隔，firefox5开始，setInterval的间隔在浏览器最小化之后至少被提高到1000ms。动画时长 = 播放总帧数 * 帧间隔平均值。由于帧间隔不可控，可能被提高到1000ms甚至更高，那么实现动画时面临两个选择：要保证播放总帧数，动画时长就会增加；要保证动画时长，就必须牺牲掉总帧数。实际上我们一般采用第二种方式，也就是丢帧保时的策略来实现动画，来看一个简单的例子";
    
    CGSize textSize = CGSizeZero;
    NSDictionary *attr = @{NSFontAttributeName : self.label1.font};
    NSAttributedString *attrText = [text getAttributedStringAndItsSize:attr lineSpace:0
                                                             breakMode:self.label1.lineBreakMode
                                                             alignment:self.label1.textAlignment
                                                       constrainedSize:CGSizeMake(self.view.bounds.size.width, 80)
                                                              textSize:&textSize];
    
    self.label1.attributedText = attrText;
    self.label1.frame = CGRectMake(self.label1.frame.origin.x, self.label1.frame.origin.y, textSize.width, textSize.height);
}

/**
 *  如果adjustsFontSizeToFitWidth属性设置为YES，这个属性就来控制文本基线的行为。
 *  UIBaselineAdjustmentAlignBaselines=0，默认，文本最上端与中线对齐。
 *  UIBaselineAdjustmentAlignCenters,   文本中线与label中线对齐。
 *  UIBaselineAdjustmentNone,  文本最低端与label中线对齐
 */
- (void)testBaseline {
    
    self.label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, self.label1.ts_bottom + 40, self.view.ts_width/3.0, 200)];
    self.label2.layer.borderColor = [UIColor redColor].CGColor;
    self.label2.layer.borderWidth = 1;
    self.label2.backgroundColor = [UIColor blackColor];
    self.label2.textColor = [UIColor greenColor];
    self.label2.adjustsFontSizeToFitWidth = YES;
    self.label2.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
    self.label2.text = @"动画间隔决定了动画间隔动画间隔决定了动1";
    [self.view addSubview:self.label2];
    
    self.label3 = [[UILabel alloc] initWithFrame:CGRectMake(self.label2.ts_right, self.label1.ts_bottom + 40, self.view.ts_width/3.0, 200)];
    self.label3.layer.borderColor = [UIColor redColor].CGColor;
    self.label3.layer.borderWidth = 1;
    self.label3.backgroundColor = [UIColor blackColor];
    self.label3.textColor = [UIColor greenColor];
    self.label3.adjustsFontSizeToFitWidth = YES;
    self.label3.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    self.label3.text = @"动画间隔决定了动画间隔动画间隔决定了动2";
    [self.view addSubview:self.label3];
    
    self.label4 = [[UILabel alloc] initWithFrame:CGRectMake(self.label3.ts_right, self.label1.ts_bottom + 40, self.view.ts_width/3.0, 200)];
    self.label4.layer.borderColor = [UIColor redColor].CGColor;
    self.label4.layer.borderWidth = 1;
    self.label4.backgroundColor = [UIColor blackColor];
    self.label4.textColor = [UIColor greenColor];
    self.label4.adjustsFontSizeToFitWidth = YES;
    self.label4.baselineAdjustment = UIBaselineAdjustmentNone;
    self.label4.text = @"动画间隔决定了动画间隔动画间隔决定了动3";
    [self.view addSubview:self.label4];
    
    self.labelBaseline = [[UILabel alloc] initWithFrame:CGRectMake(0, self.label2.ts_bottom-self.label2.ts_height/2.0f,
                                                                     self.view.ts_width, 1)];
    self.labelBaseline.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.labelBaseline];
}

/**
 *  设置了paragraph style那么numberOfLines必须为非1，这样才谈得上paragraph style；
 *  如果使用numberOfLines默认1，会导致UILabel中drawTextInRect永远把文本从(0,0)坐标点开始画
 */
- (void)testNumberOfLineAndParagraphStyle {
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.lineSpacing = 10;
    
    
    BSLabel *bsLabel = [[BSLabel alloc] initWithFrame:CGRectMake(0, 64, 200, 200)];
    bsLabel.backgroundColor = [UIColor redColor];
    bsLabel.layer.borderColor = [UIColor redColor].CGColor;
    bsLabel.layer.borderWidth = 1;
    bsLabel.numberOfLines = 0;
    bsLabel.attributedText = [[NSAttributedString alloc] initWithString:@"动画间隔决"
                                                             attributes:@{NSForegroundColorAttributeName:[UIColor blueColor],
                                                                          NSParagraphStyleAttributeName:style}];
    [self.view addSubview:bsLabel];
}

@end
