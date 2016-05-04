//
//  AUITestVC.m
//  AUI
//
//  Created by Handy on 4/18/16.
//  Copyright © 2016 Handy. All rights reserved.
//

#import "AUITestVC.h"
#import "AUITextView.h"
#import "AUITextField.h"

#define kTextViewsLabelTop      (64.0f)
#define kTextViewsLabelHeight   (44.0f)

#define kTextViewTop        (kTextViewsLabelTop + kTextViewsLabelHeight)
#define kTextViewHeight     (100.0f)

#define kTextViewFrameLT    (CGRectMake(0, kTextViewTop, self.view.bounds.size.width/3.0f, kTextViewHeight))
#define kTextViewFrameCT    (CGRectMake(self.view.bounds.size.width/3.0f, kTextViewTop, self.view.bounds.size.width/3.0f, kTextViewHeight))
#define kTextViewFrameRT    (CGRectMake(self.view.bounds.size.width*2.0f/3.0f, kTextViewTop, self.view.bounds.size.width/3.0f, kTextViewHeight))

#define kTextViewFrameLC    (CGRectMake(0, kTextViewTop+kTextViewHeight, self.view.bounds.size.width/3.0f, kTextViewHeight))
#define kTextViewFrameC     (CGRectMake(self.view.bounds.size.width/3.0f, kTextViewTop+kTextViewHeight, self.view.bounds.size.width/3.0f, kTextViewHeight))
#define kTextViewFrameRC    (CGRectMake(self.view.bounds.size.width*2.0f/3.0f, kTextViewTop+kTextViewHeight, self.view.bounds.size.width/3.0f, kTextViewHeight))

#define kTextViewFrameLB    (CGRectMake(0, kTextViewTop+2*kTextViewHeight, self.view.bounds.size.width/3.0f, kTextViewHeight))
#define kTextViewFrameCB    (CGRectMake(self.view.bounds.size.width/3.0f, kTextViewTop+2*kTextViewHeight, self.view.bounds.size.width/3.0f, kTextViewHeight))
#define kTextViewFrameRB    (CGRectMake(self.view.bounds.size.width*2.0f/3.0f, kTextViewTop+2*kTextViewHeight, self.view.bounds.size.width/3.0f, kTextViewHeight))

//--------------------------------------------------

#define kTextFieldsLabelTop     (kTextViewFrameRB.origin.y + kTextViewFrameRB.size.height + 20)
#define kTextFieldsLabelHeight  (44.0f)

#define kTetxtFieldTop      (kTextFieldsLabelTop + kTextFieldsLabelHeight)
#define kTextFieldHeight    (50.0f)

#define kTextFieldFrameLT   (CGRectMake(0, kTetxtFieldTop, self.view.bounds.size.width/3.0f, kTextFieldHeight))
#define kTextFieldFrameCT   (CGRectMake(self.view.bounds.size.width/3.0f, kTetxtFieldTop, self.view.bounds.size.width/3.0f, kTextFieldHeight))
#define kTextFieldFrameRT   (CGRectMake(self.view.bounds.size.width*2.0f/3.0f, kTetxtFieldTop, self.view.bounds.size.width/3.0f, kTextFieldHeight))

#define kTextFieldFrameLC   (CGRectMake(0, kTetxtFieldTop+kTextFieldHeight, self.view.bounds.size.width/3.0f, kTextFieldHeight))
#define kTextFieldFrameC    (CGRectMake(self.view.bounds.size.width/3.0f, kTetxtFieldTop+kTextFieldHeight, self.view.bounds.size.width/3.0f, kTextFieldHeight))
#define kTextFieldFrameRC   (CGRectMake(self.view.bounds.size.width*2.0f/3.0f, kTetxtFieldTop+kTextFieldHeight, self.view.bounds.size.width/3.0f, kTextFieldHeight))

#define kTextFieldFrameLB   (CGRectMake(0, kTetxtFieldTop+2*kTextFieldHeight, self.view.bounds.size.width/3.0f, kTextFieldHeight))
#define kTextFieldFrameCB   (CGRectMake(self.view.bounds.size.width/3.0f, kTetxtFieldTop+2*kTextFieldHeight, self.view.bounds.size.width/3.0f, kTextFieldHeight))
#define kTextFieldFrameRB   (CGRectMake(self.view.bounds.size.width*2.0f/3.0f, kTetxtFieldTop+2*kTextFieldHeight, self.view.bounds.size.width/3.0f, kTextFieldHeight))

@interface AUITestVC () {
    UILabel *_textViewsTitleLabel;
    
    AUITextView *_textViewLT;
    AUITextView *_textViewCT;
    AUITextView *_textViewRT;
    
    AUITextView *_textViewLC;
    AUITextView *_textViewC;
    AUITextView *_textViewRC;
    
    AUITextView *_textViewLB;
    AUITextView *_textViewCB;
    AUITextView *_textViewRB;
    
    //-------------------------------------------------
    
    UILabel *_textFieldsLabel;
    
    AUITextField *_textFiledLT;
    AUITextField *_textFiledCT;
    AUITextField *_textFiledRT;
    
    AUITextField *_textFiledLC;
    AUITextField *_textFiledC;
    AUITextField *_textFiledRC;
    
    AUITextField *_textFiledLB;
    AUITextField *_textFiledCB;
    AUITextField *_textFiledRB;
}

@end

@implementation AUITestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    [self layoutTextViews];
    [self lauoutTextFields];
}

- (void)layoutTextViews {
    _textViewsTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kTextViewsLabelTop, self.view.frame.size.width, kTextViewsLabelHeight)];
    _textViewsTitleLabel.backgroundColor = [UIColor blackColor];
    _textViewsTitleLabel.textColor = [UIColor whiteColor];
    _textViewsTitleLabel.text = @"TextViews";
    _textViewsTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_textViewsTitleLabel];
    
    NSString *textStr = @"以前，如果我们想实现复杂的文本排版，例如以前，如果我们想实现复杂的文本排版";
    
    _textViewLT = [[AUITextView alloc] initWithFrame:kTextViewFrameLT];
    _textViewLT.backgroundColor = [UIColor whiteColor];
    _textViewLT.text9PointAlignment = AUITextAlignmentLeftTop;
    _textViewLT.layer.borderColor = [UIColor redColor].CGColor;
    _textViewLT.layer.borderWidth = 1;
    _textViewLT.text = textStr;
    [self.view addSubview:_textViewLT];
    
    _textViewCT = [[AUITextView alloc] initWithFrame:kTextViewFrameCT];
    _textViewCT.backgroundColor = [UIColor whiteColor];
    _textViewCT.text9PointAlignment = AUITextAlignmentCenterTop;
    _textViewCT.layer.borderColor = [UIColor redColor].CGColor;
    _textViewCT.layer.borderWidth = 1;
    _textViewCT.text = textStr;
    [self.view addSubview:_textViewCT];
    
    _textViewRT = [[AUITextView alloc] initWithFrame:kTextViewFrameRT];
    _textViewRT.backgroundColor = [UIColor whiteColor];
    _textViewRT.text9PointAlignment = AUITextAlignmentRightTop;
    _textViewRT.layer.borderColor = [UIColor redColor].CGColor;
    _textViewRT.layer.borderWidth = 1;
    _textViewRT.text = textStr;
    [self.view addSubview:_textViewRT];
    
    //----------------------------------------------------------------
    
    _textViewLC = [[AUITextView alloc] initWithFrame:kTextViewFrameLC];
    _textViewLC.backgroundColor = [UIColor whiteColor];
    _textViewLC.text9PointAlignment = AUITextAlignmentLeftCenter;
    _textViewLC.layer.borderColor = [UIColor redColor].CGColor;
    _textViewLC.layer.borderWidth = 1;
    _textViewLC.text = textStr;
    [self.view addSubview:_textViewLC];
    
    _textViewC = [[AUITextView alloc] initWithFrame:kTextViewFrameC];
    _textViewC.backgroundColor = [UIColor whiteColor];
    _textViewC.text9PointAlignment = AUITextAlignmentCenter;
    _textViewC.layer.borderColor = [UIColor redColor].CGColor;
    _textViewC.layer.borderWidth = 1;
    _textViewC.text = textStr;
    [self.view addSubview:_textViewC];
    
    _textViewRC = [[AUITextView alloc] initWithFrame:kTextViewFrameRC];
    _textViewRC.backgroundColor = [UIColor whiteColor];
    _textViewRC.text9PointAlignment = AUITextAlignmentRightCenter;
    _textViewRC.layer.borderColor = [UIColor redColor].CGColor;
    _textViewRC.layer.borderWidth = 1;
    _textViewRC.text = textStr;
    [self.view addSubview:_textViewRC];
    
    //----------------------------------------------------------------
    
    _textViewLB = [[AUITextView alloc] initWithFrame:kTextViewFrameLB];
    _textViewLB.backgroundColor = [UIColor whiteColor];
    _textViewLB.text9PointAlignment = AUITextAlignmentLeftBottom;
    _textViewLB.layer.borderColor = [UIColor redColor].CGColor;
    _textViewLB.layer.borderWidth = 1;
    _textViewLB.text = textStr;
    [self.view addSubview:_textViewLB];
    
    _textViewCB = [[AUITextView alloc] initWithFrame:kTextViewFrameCB];
    _textViewCB.backgroundColor = [UIColor whiteColor];
    _textViewCB.text9PointAlignment = AUITextAlignmentCenterBottom;
    _textViewCB.layer.borderColor = [UIColor redColor].CGColor;
    _textViewCB.layer.borderWidth = 1;
    _textViewCB.text = textStr;
    [self.view addSubview:_textViewCB];
    
    _textViewRB = [[AUITextView alloc] initWithFrame:kTextViewFrameRB];
    _textViewRB.backgroundColor = [UIColor whiteColor];
    _textViewRB.text9PointAlignment = AUITextAlignmentRightBottom;
    _textViewRB.layer.borderColor = [UIColor redColor].CGColor;
    _textViewRB.layer.borderWidth = 1;
    _textViewRB.text = textStr;
    [self.view addSubview:_textViewRB];
}

- (void)lauoutTextFields {
    _textFieldsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kTextFieldsLabelTop, self.view.frame.size.width, kTextFieldsLabelHeight)];
    _textFieldsLabel.backgroundColor = [UIColor blackColor];
    _textFieldsLabel.textColor = [UIColor whiteColor];
    _textFieldsLabel.text = @"TextFields";
    _textFieldsLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_textFieldsLabel];
    
    NSString *textStr = @"如果我们";
    
    _textFiledLT = [[AUITextField alloc] initWithFrame:kTextFieldFrameLT];
    _textFiledLT.backgroundColor = [UIColor whiteColor];
    _textFiledLT.textColor = [UIColor blackColor];
    _textFiledLT.layer.borderColor = [UIColor redColor].CGColor;
    _textFiledLT.layer.borderWidth = 1;
    _textFiledLT.text = textStr;
    _textFiledLT.text9PointAlignment = AUITextAlignmentLeftTop;
    [self.view addSubview:_textFiledLT];
    
    _textFiledCT = [[AUITextField alloc] initWithFrame:kTextFieldFrameCT];
    _textFiledCT.backgroundColor = [UIColor whiteColor];
    _textFiledCT.textColor = [UIColor blackColor];
    _textFiledCT.layer.borderColor = [UIColor redColor].CGColor;
    _textFiledCT.layer.borderWidth = 1;
    _textFiledCT.text = textStr;
    _textFiledCT.text9PointAlignment = AUITextAlignmentCenterTop;
    [self.view addSubview:_textFiledCT];
    
    _textFiledRT = [[AUITextField alloc] initWithFrame:kTextFieldFrameRT];
    _textFiledRT.backgroundColor = [UIColor whiteColor];
    _textFiledRT.textColor = [UIColor blackColor];
    _textFiledRT.layer.borderColor = [UIColor redColor].CGColor;
    _textFiledRT.layer.borderWidth = 1;
    _textFiledRT.text = textStr;
    _textFiledRT.text9PointAlignment = AUITextAlignmentRightTop;
    [self.view addSubview:_textFiledRT];
    
    //----------------------------------------------------------------------
    
    _textFiledLC = [[AUITextField alloc] initWithFrame:kTextFieldFrameLC];
    _textFiledLC.backgroundColor = [UIColor whiteColor];
    _textFiledLC.textColor = [UIColor blackColor];
    _textFiledLC.layer.borderColor = [UIColor redColor].CGColor;
    _textFiledLC.layer.borderWidth = 1;
    _textFiledLC.text = textStr;
    _textFiledLC.text9PointAlignment = AUITextAlignmentLeftCenter;
    [self.view addSubview:_textFiledLC];
    
    _textFiledC = [[AUITextField alloc] initWithFrame:kTextFieldFrameC];
    _textFiledC.backgroundColor = [UIColor whiteColor];
    _textFiledC.textColor = [UIColor blackColor];
    _textFiledC.layer.borderColor = [UIColor redColor].CGColor;
    _textFiledC.layer.borderWidth = 1;
    _textFiledC.text = textStr;
    _textFiledC.text9PointAlignment = AUITextAlignmentCenter;
    [self.view addSubview:_textFiledC];
    
    _textFiledRC = [[AUITextField alloc] initWithFrame:kTextFieldFrameRC];
    _textFiledRC.backgroundColor = [UIColor whiteColor];
    _textFiledRC.textColor = [UIColor blackColor];
    _textFiledRC.layer.borderColor = [UIColor redColor].CGColor;
    _textFiledRC.layer.borderWidth = 1;
    _textFiledRC.text = textStr;
    _textFiledRC.text9PointAlignment = AUITextAlignmentRightCenter;
    [self.view addSubview:_textFiledRC];
    
    //----------------------------------------------------------------------
    
    _textFiledLB = [[AUITextField alloc] initWithFrame:kTextFieldFrameLB];
    _textFiledLB.backgroundColor = [UIColor whiteColor];
    _textFiledLB.textColor = [UIColor blackColor];
    _textFiledLB.layer.borderColor = [UIColor redColor].CGColor;
    _textFiledLB.layer.borderWidth = 1;
    _textFiledLB.text = textStr;
    _textFiledLB.text9PointAlignment = AUITextAlignmentLeftBottom;
    [self.view addSubview:_textFiledLB];
    
    _textFiledCB = [[AUITextField alloc] initWithFrame:kTextFieldFrameCB];
    _textFiledCB.backgroundColor = [UIColor whiteColor];
    _textFiledCB.textColor = [UIColor blackColor];
    _textFiledCB.layer.borderColor = [UIColor redColor].CGColor;
    _textFiledCB.layer.borderWidth = 1;
    _textFiledCB.text = textStr;
    _textFiledCB.text9PointAlignment = AUITextAlignmentCenterBottom;
    [self.view addSubview:_textFiledCB];
    
    _textFiledRB = [[AUITextField alloc] initWithFrame:kTextFieldFrameRB];
    _textFiledRB.backgroundColor = [UIColor whiteColor];
    _textFiledRB.textColor = [UIColor blackColor];
    _textFiledRB.layer.borderColor = [UIColor redColor].CGColor;
    _textFiledRB.layer.borderWidth = 1;
    _textFiledRB.text = textStr;
    _textFiledRB.text9PointAlignment = AUITextAlignmentRightBottom;
    [self.view addSubview:_textFiledRB];
}

#pragma mark - UITextViewDelegate

//- (void)textContainerInset1 {
//    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
//    CGSize textStrSize = [_textViewLT.attributedText boundingRectWithSize:kTextViewFrame.size options:options context:nil].size;
//    CGFloat insetTopAndBottom = (_textViewLT.frame.size.height - textStrSize.height) / 2.0f;
//    insetTopAndBottom = insetTopAndBottom <= 0 ? 0 : insetTopAndBottom;
//    insetTopAndBottom = insetTopAndBottom < _textViewLT.font.lineHeight ? 0 : insetTopAndBottom;
//    UIEdgeInsets textContainerInset = _textViewLT.textContainerInset;
//    _textViewLT.textContainerInset = UIEdgeInsetsMake(insetTopAndBottom, textContainerInset.left, insetTopAndBottom, textContainerInset.right);
//}
//
//- (void)textContainerInset2 {
//    (void) [_textViewLT.layoutManager glyphRangeForTextContainer:_textViewLT.textContainer];
//    CGSize textStrSize = [_textViewLT.layoutManager usedRectForTextContainer:_textViewLT.textContainer].size;
//    CGFloat insetTopAndBottom = (_textViewLT.frame.size.height - textStrSize.height) / 2.0f;
//    insetTopAndBottom = insetTopAndBottom <= 0 ? 0 : insetTopAndBottom;
//    UIEdgeInsets textContainerInset = _textViewLT.textContainerInset;
//    _textViewLT.textContainerInset = UIEdgeInsetsMake(insetTopAndBottom, textContainerInset.left, insetTopAndBottom, textContainerInset.right);
//}

#pragma mark - Other

//- (void)test1 {
//    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 333, 360, 200)];
//    textView.layer.borderColor = [UIColor redColor].CGColor;
//    textView.layer.borderWidth = 1;
//    textView.text = @"asddsaadasddsasdasdjsdhfjkdhkjdhfgjkldhsgfjlkhfdsgjklhdfsljkghdklfjgshdgjklfshdfgjklhfglkjdshjklgfdshjklgdfshkljfdsghfjkldghlkjfdghskljgdfhslkjgdfshjklgfdshjkgfdshlkjgdfhskljdgfhsjklgdhsjklfgdshjkglfdshjklgfdshlkjfgdhjklgdfshjdfkslghkjfdlsg";
//    [self.view addSubview:textView];
//    
//    UIView *view = [[UIView alloc] init];
//    view.frame = CGRectMake(0, 0, 200, 50);
//    view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
//    [textView addSubview:view];
//    CGRect relativeRect = [textView convertRect:view.bounds fromView:view];
//    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:relativeRect];
//    textView.textContainer.exclusionPaths = @[bezierPath];
//}
//
//- (void)centerText {
//    NSTextContainer *container = _textViewLT.textContainer;
//    NSLayoutManager *layoutManager = container.layoutManager;
//    
//    CGRect textRect = [layoutManager usedRectForTextContainer:container];
//    
//    UIEdgeInsets inset = UIEdgeInsetsZero;
//    inset.top = _textViewLT.bounds.size.height / 2 - textRect.size.height / 2;
////    inset.left = _textView.bounds.size.width / 2 - textRect.size.width / 2;
//    
//    _textViewLT.textContainerInset = inset;
//}

//- (NSTextContainer *)textContainer:(NSString *)str {
//    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
//    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithString:str];
//    [textStorage addLayoutManager:layoutManager];
//    
//    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:kTextViewFrame.size];
//    [layoutManager addTextContainer:textContainer];
//    
//    return textContainer;
//}

@end
