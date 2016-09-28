//
//  NMTableViewCell.m
//  iOSDev
//
//  Created by Handy on 9/22/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "NMTableViewCell.h"

@interface NMTableViewCellContentView : UIView

@end

@implementation NMTableViewCellContentView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@ - %@------------", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@ - %@------------", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
}

@end

@implementation NMTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        NMTableViewCellContentView *v = [[NMTableViewCellContentView alloc] initWithFrame:self.contentView.bounds];
        v.backgroundColor = [UIColor redColor];
//        [self.contentView addSubview:v];
    }
    return self;
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"%@ - %@------------", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
//}
//
//- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"%@ - %@------------", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
//}

@end
