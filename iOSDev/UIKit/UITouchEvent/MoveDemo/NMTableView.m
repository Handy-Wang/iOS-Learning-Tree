//
//  NMTableView.m
//  iOSDev
//
//  Created by Handy on 9/22/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "NMTableView.h"
#import "NMTableViewCell.h"
#import "NMContainerView.h"

@interface NMTableView () <UITableViewDataSource, UITableViewDelegate>
{
    NSNumber *_cachedContentOffset;
}
@end

@implementation NMTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
    }
    
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (NMTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    
    NMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NMTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行", (long)indexPath.row];
    
    return cell;
}

//- (BOOL)touchesShouldBegin:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event inContentView:(UIView *)view
//{
//    return NO;
//}

//- (BOOL)touchesShouldCancelInContentView:(UIView *)view
//{
//    return NO;
//}

// called when a gesture recognizer attempts to transition out of UIGestureRecognizerStatePossible. returning NO causes it to transition to UIGestureRecognizerStateFailed
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
//{
//    NSLog(@"%@ - %@------------", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
//    return NO;
//}
//
//// called before touchesBegan:withEvent: is called on the gesture recognizer for a new touch. return NO to prevent the gesture recognizer from seeing this touch
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
//    NSLog(@"%@ - %@------------", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
//    return NO;
//}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!(_containerView.isTop)) {
        scrollView.contentOffset = CGPointMake(0, 0);
        
    } else {
        
    }
    
    
    
//    if (!_canScrollList) {
//        CGPoint contentOffset = scrollView.contentOffset;
//        
////        if (contentOffset.y <= 0) {
//            scrollView.contentOffset = CGPointMake(0, 0);
////        } else {
////            if (!_cachedContentOffset) {
////                _cachedContentOffset = @(contentOffset.y);
////                scrollView.contentOffset = CGPointMake(0, contentOffset.y);
////            }
////        }
//    } else {
//        _cachedContentOffset = nil;
//    }
    NSLog(@"%@ - %@------------", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@ - %@------------", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@ - %@------------", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
    [super touchesMoved:touches withEvent:event];
}

@end
