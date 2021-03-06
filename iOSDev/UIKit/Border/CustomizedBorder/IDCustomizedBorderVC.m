//
//  IDCustomizedBorderVC.m
//  iOSDev
//
//  Created by Handy on 5/23/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "IDCustomizedBorderVC.h"
#import "CALayer+AJXBorder.h"

#define kGroup1Left                 (0.0f)
#define kGroup1Top                  (84.0f)
#define kGroup1Size                 (self.view.frame.size.width/5.0f)

#define kView1Top                   (84.0f)
#define kView1Left                  (10.0f)
#define kView1Width                 (100.0f)
#define kView1Height                (100.0f)

@interface IDCustomizedBorderVC () {
    UILabel *_label1;
    UILabel *_label2;
    UILabel *_label3;
    UILabel *_label4;
    UILabel *_label5;
    UILabel *_label6;
    UILabel *_label7;
    UILabel *_label8;
    UILabel *_label9;
    UILabel *_label10;
    UILabel *_label11;
}
@end

@implementation IDCustomizedBorderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    //test cases
    
    //只有圆角
    CGRect group1Frame = CGRectMake(kGroup1Left, kGroup1Top, kGroup1Size, kGroup1Size);
    _label1 = [self labelWithFrame:group1Frame andText:@"左上有圆角"];
    [_label1.layer ajx_setCornerRadius:UIEdgeInsetsFromString(@"{20,0,0,0}")];
    
    _label2 = [self labelWithFrame:group1Frame andText:@"右上有圆角"];
    _label2.ts_left = _label1.ts_right;
    [_label2.layer ajx_setCornerRadius:UIEdgeInsetsFromString(@"{0,0,0,20}")];
    
    _label3 = [self labelWithFrame:group1Frame andText:@"右下有圆角"];
    _label3.ts_left = _label2.ts_right;
    [_label3.layer ajx_setCornerRadius:UIEdgeInsetsFromString(@"{0,0,20,0}")];
    
    _label4 = [self labelWithFrame:group1Frame andText:@"左下有圆角"];
    _label4.ts_left = _label3.ts_right;
    [_label4.layer ajx_setCornerRadius:UIEdgeInsetsFromString(@"{0,20,0,0}")];
    
    _label5 = [self labelWithFrame:group1Frame andText:@"全有圆角"];
    _label5.ts_left = _label4.ts_right;
    [_label5.layer ajx_setCornerRadius:UIEdgeInsetsFromString(@"{20,20,20,20}")];
    
    _label6 = [self labelWithFrame:group1Frame andText:@"顶则有圆角"];
    _label6.ts_left = 0;
    _label6.ts_top = _label1.ts_bottom;
    [_label6.layer ajx_setCornerRadius:UIEdgeInsetsFromString(@"{20,0,0,40}")];
    
    _label7 = [self labelWithFrame:group1Frame andText:@"右侧有圆角"];
    _label7.ts_left = _label6.ts_right;
    _label7.ts_top = _label1.ts_bottom;
    [_label7.layer ajx_setCornerRadius:UIEdgeInsetsFromString(@"{0,0,20,40}")];
    
    _label8 = [self labelWithFrame:group1Frame andText:@"底侧有圆角"];
    _label8.ts_left = _label7.ts_right;
    _label8.ts_top = _label1.ts_bottom;
    [_label8.layer ajx_setCornerRadius:UIEdgeInsetsFromString(@"{0,20,40,0}")];
    
    _label9 = [self labelWithFrame:group1Frame andText:@"左侧有圆角"];
    _label9.ts_left = _label8.ts_right;
    _label9.ts_top = _label1.ts_bottom;
    [_label9.layer ajx_setBorderWidth:4];
    [_label9.layer ajx_setCornerRadius:UIEdgeInsetsFromString(@"{20,40,0,0}")];
    
    _label10 = [self labelWithFrame:group1Frame andText:@"全有圆角"];
    _label10.ts_left = _label9.ts_right;
    _label10.ts_top = _label1.ts_bottom;
    [_label10.layer ajx_setBorderWidth:4];
    [_label10.layer ajx_setCornerRadius:UIEdgeInsetsFromString(@"{10,20,30,40}")];
    [_label10.layer ajx_setBorderColor:[UIColor greenColor].CGColor];

    
    //只有边框宽度
    _label11 = [self labelWithFrame:group1Frame andText:@"只有边框宽度、无颜色"];
    _label11.ts_left = 0;
    _label11.ts_top = _label6.ts_bottom;
    _label11.ts_width = self.view.ts_width;
    [_label11.layer ajx_setBorderWidth:4];
    
    //只有边框颜色
}

- (UILabel *)labelWithFrame:(CGRect)frame andText:(NSString *)text {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor whiteColor];
    label.textColor = [UIColor blackColor];
    label.text = text;
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    return label;
}

@end
