//
//  IDBorderTest1Cell.m
//  iOSDev
//
//  Created by Handy on 6/20/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "CALayer+AJXBorder.h"
#import "IDBorderTest1Cell.h"

@interface IDBorderTest1Cell () {
    UIView *_testView;
}
@end

@implementation IDBorderTest1Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.clipsToBounds = YES;
        [self testView];
    }
    
    return self;
}

- (void)updateSubViewFrame:(CGRect)frame indexPath:(NSIndexPath *)indexPath {
    NSLog(@"BEFORE: View frame is %@, bounds is %@, row %ld", NSStringFromCGRect(_testView.frame), NSStringFromCGRect(_testView.bounds), indexPath.row);
    NSLog(@"BEFORE: Layer frame is %@, bounds is %@, row %ld", NSStringFromCGRect(_testView.layer.frame), NSStringFromCGRect(_testView.layer.bounds), indexPath.row);
    [self testView].frame = frame;
    NSLog(@"AFTER: View frame is %@, bounds is %@, row %ld", NSStringFromCGRect(_testView.frame), NSStringFromCGRect(_testView.bounds), indexPath.row);
    NSLog(@"AFTER: Layer frame is %@, bounds is %@, row %ld", NSStringFromCGRect(_testView.layer.frame), NSStringFromCGRect(_testView.layer.bounds), indexPath.row);
}

- (UIView *)testView {
    if (!_testView) {
        _testView = [[UIView alloc] initWithFrame:self.bounds];
        _testView.backgroundColor = [UIColor greenColor];
        [self addSubview:_testView];
        
        [_testView.layer ajx_setBorderColor:[UIColor redColor].CGColor];
        [_testView.layer ajx_setBorderWidth:2.0f];
        [_testView.layer ajx_setCornerRadius:UIEdgeInsetsMake(10, 10, 10, 10)];
        
//        [_testView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew+NSKeyValueObservingOptionOld context:NULL];
//        [_testView addObserver:self forKeyPath:@"bounds" options:NSKeyValueObservingOptionNew+NSKeyValueObservingOptionOld context:NULL];
//        [_testView addObserver:self forKeyPath:@"layer.frame" options:NSKeyValueObservingOptionNew+NSKeyValueObservingOptionOld context:NULL];
//        [_testView addObserver:self forKeyPath:@"layer.bounds" options:NSKeyValueObservingOptionNew+NSKeyValueObservingOptionOld context:NULL];
    }
    
    return _testView;
}

//- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSString*, id> *)change context:(nullable void *)context
//{
//    NSLog(@"keyPath is %@", keyPath);
//}

@end
