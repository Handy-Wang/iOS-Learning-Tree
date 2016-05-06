//
//  BSUITestVC.m
//  UI
//
//  Created by Handy on 4/18/16.
//  Copyright © 2016 Handy. All rights reserved.
//

#import "BSUITestVC.h"
#import "BSTextView.h"
#import "BSTextField.h"

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
#define kTextFieldFrameL    (CGRectMake(0, kTetxtFieldTop+3*kTextFieldHeight, self.view.bounds.size.width/3.0f, kTextFieldHeight))

@interface BSUITestVC () {
    UILabel *_textViewsTitleLabel;
    
    BSTextView *_textViewLT;
    BSTextView *_textViewCT;
    BSTextView *_textViewRT;
    
    BSTextView *_textViewLC;
    BSTextView *_textViewC;
    BSTextView *_textViewRC;
    
    BSTextView *_textViewLB;
    BSTextView *_textViewCB;
    BSTextView *_textViewRB;
    
    //-------------------------------------------------
    
    UILabel *_textFieldsLabel;
    
    BSTextField *_textFiledLT;
    BSTextField *_textFiledCT;
    BSTextField *_textFiledRT;
    
    BSTextField *_textFiledLC;
    BSTextField *_textFiledC;
    BSTextField *_textFiledRC;
    
    BSTextField *_textFiledLB;
    BSTextField *_textFiledCB;
    BSTextField *_textFiledRB;
    
    UITextField *_textFiledLast;
}

@end

@implementation BSUITestVC

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
    
    NSString *textStr = @"以前，如果我们想实现复杂的文本排版，例如以前，如果我们想实现复杂的文本排版以前，如果我们想实现复杂的文本排版，例如以前，如果我们想实现复杂的文本排版以前，如果我们想实现复杂的文本排版，例如以前，如果我们想实现复杂的文本排版以前，如果我们想实现复杂的文本排版，例如以前，如果我们想实现复杂的文本排版";
    
    _textViewLT = [[BSTextView alloc] initWithFrame:kTextViewFrameLT];
    _textViewLT.backgroundColor = [UIColor whiteColor];
    _textViewLT.text9PointAlignment = BSTextAlignmentLeftTop;
    _textViewLT.layer.borderColor = [UIColor redColor].CGColor;
    _textViewLT.layer.borderWidth = 1;
    _textViewLT.text = textStr;
    [self.view addSubview:_textViewLT];
    
    _textViewCT = [[BSTextView alloc] initWithFrame:kTextViewFrameCT];
    _textViewCT.backgroundColor = [UIColor whiteColor];
    _textViewCT.text9PointAlignment = BSTextAlignmentCenterTop;
    _textViewCT.layer.borderColor = [UIColor redColor].CGColor;
    _textViewCT.layer.borderWidth = 1;
    _textViewCT.text = textStr;
    [self.view addSubview:_textViewCT];
    
    _textViewRT = [[BSTextView alloc] initWithFrame:kTextViewFrameRT];
    _textViewRT.backgroundColor = [UIColor whiteColor];
    _textViewRT.text9PointAlignment = BSTextAlignmentRightTop;
    _textViewRT.layer.borderColor = [UIColor redColor].CGColor;
    _textViewRT.layer.borderWidth = 1;
    _textViewRT.text = textStr;
    [self.view addSubview:_textViewRT];
    
    //----------------------------------------------------------------
    
    _textViewLC = [[BSTextView alloc] initWithFrame:kTextViewFrameLC];
    _textViewLC.backgroundColor = [UIColor whiteColor];
    _textViewLC.text9PointAlignment = BSTextAlignmentLeftCenter;
    _textViewLC.layer.borderColor = [UIColor redColor].CGColor;
    _textViewLC.layer.borderWidth = 1;
    _textViewLC.text = textStr;
    [self.view addSubview:_textViewLC];
    
    _textViewC = [[BSTextView alloc] initWithFrame:kTextViewFrameC];
    _textViewC.backgroundColor = [UIColor whiteColor];
    _textViewC.text9PointAlignment = BSTextAlignmentCenter;
    _textViewC.layer.borderColor = [UIColor redColor].CGColor;
    _textViewC.layer.borderWidth = 1;
    _textViewC.text = textStr;
    [self.view addSubview:_textViewC];
    
    _textViewRC = [[BSTextView alloc] initWithFrame:kTextViewFrameRC];
    _textViewRC.backgroundColor = [UIColor whiteColor];
    _textViewRC.text9PointAlignment = BSTextAlignmentRightCenter;
    _textViewRC.layer.borderColor = [UIColor redColor].CGColor;
    _textViewRC.layer.borderWidth = 1;
    _textViewRC.text = textStr;
    [self.view addSubview:_textViewRC];
    
    //----------------------------------------------------------------
    
    _textViewLB = [[BSTextView alloc] initWithFrame:kTextViewFrameLB];
    _textViewLB.backgroundColor = [UIColor whiteColor];
    _textViewLB.text9PointAlignment = BSTextAlignmentLeftBottom;
    _textViewLB.layer.borderColor = [UIColor redColor].CGColor;
    _textViewLB.layer.borderWidth = 1;
    _textViewLB.text = textStr;
    [self.view addSubview:_textViewLB];
    
    _textViewCB = [[BSTextView alloc] initWithFrame:kTextViewFrameCB];
    _textViewCB.backgroundColor = [UIColor whiteColor];
    _textViewCB.text9PointAlignment = BSTextAlignmentCenterBottom;
    _textViewCB.layer.borderColor = [UIColor redColor].CGColor;
    _textViewCB.layer.borderWidth = 1;
    _textViewCB.text = textStr;
    [self.view addSubview:_textViewCB];
    
    _textViewRB = [[BSTextView alloc] initWithFrame:kTextViewFrameRB];
    _textViewRB.backgroundColor = [UIColor whiteColor];
    _textViewRB.text9PointAlignment = BSTextAlignmentRightBottom;
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
    
    NSString *textPlaceholderStr = @"请输入";
//    NSString *textStr = @"";
    
    _textFiledLT = [[BSTextField alloc] initWithFrame:kTextFieldFrameLT];
    _textFiledLT.backgroundColor = [UIColor whiteColor];
    _textFiledLT.textColor = [UIColor blackColor];
    _textFiledLT.layer.borderColor = [UIColor redColor].CGColor;
    _textFiledLT.layer.borderWidth = 1;
    _textFiledLT.placeholder = textPlaceholderStr;
//    _textFiledLT.text = textStr;
    _textFiledLT.text9PointAlignment = BSTextAlignmentLeftTop;
    [self.view addSubview:_textFiledLT];
    
    _textFiledCT = [[BSTextField alloc] initWithFrame:kTextFieldFrameCT];
    _textFiledCT.backgroundColor = [UIColor whiteColor];
    _textFiledCT.textColor = [UIColor blackColor];
    _textFiledCT.layer.borderColor = [UIColor redColor].CGColor;
    _textFiledCT.layer.borderWidth = 1;
    _textFiledCT.placeholder = textPlaceholderStr;
//    _textFiledCT.text = textStr;
    _textFiledCT.text9PointAlignment = BSTextAlignmentCenterTop;
    [self.view addSubview:_textFiledCT];
    
    _textFiledRT = [[BSTextField alloc] initWithFrame:kTextFieldFrameRT];
    _textFiledRT.backgroundColor = [UIColor whiteColor];
    _textFiledRT.textColor = [UIColor blackColor];
    _textFiledRT.layer.borderColor = [UIColor redColor].CGColor;
    _textFiledRT.layer.borderWidth = 1;
    _textFiledRT.placeholder = textPlaceholderStr;
//    _textFiledRT.text = textStr;
    _textFiledRT.text9PointAlignment = BSTextAlignmentRightTop;
    [self.view addSubview:_textFiledRT];
    
    //----------------------------------------------------------------------
    
    _textFiledLC = [[BSTextField alloc] initWithFrame:kTextFieldFrameLC];
    _textFiledLC.backgroundColor = [UIColor whiteColor];
    _textFiledLC.textColor = [UIColor blackColor];
    _textFiledLC.layer.borderColor = [UIColor redColor].CGColor;
    _textFiledLC.layer.borderWidth = 1;
    _textFiledLC.placeholder = textPlaceholderStr;
//    _textFiledLC.text = textStr;
    _textFiledLC.text9PointAlignment = BSTextAlignmentLeftCenter;
    [self.view addSubview:_textFiledLC];
    
    _textFiledC = [[BSTextField alloc] initWithFrame:kTextFieldFrameC];
    _textFiledC.backgroundColor = [UIColor whiteColor];
    _textFiledC.textColor = [UIColor blackColor];
    _textFiledC.layer.borderColor = [UIColor redColor].CGColor;
    _textFiledC.layer.borderWidth = 1;
    _textFiledC.placeholder = textPlaceholderStr;
//    _textFiledC.text = textStr;
    _textFiledC.text9PointAlignment = BSTextAlignmentCenter;
    [self.view addSubview:_textFiledC];
    
    _textFiledRC = [[BSTextField alloc] initWithFrame:kTextFieldFrameRC];
    _textFiledRC.backgroundColor = [UIColor whiteColor];
    _textFiledRC.textColor = [UIColor blackColor];
    _textFiledRC.layer.borderColor = [UIColor redColor].CGColor;
    _textFiledRC.layer.borderWidth = 1;
    _textFiledRC.placeholder = textPlaceholderStr;
//    _textFiledRC.text = textStr;
    _textFiledRC.text9PointAlignment = BSTextAlignmentRightCenter;
    [self.view addSubview:_textFiledRC];
    
    //----------------------------------------------------------------------
    
    _textFiledLB = [[BSTextField alloc] initWithFrame:kTextFieldFrameLB];
    _textFiledLB.backgroundColor = [UIColor whiteColor];
    _textFiledLB.textColor = [UIColor blackColor];
    _textFiledLB.layer.borderColor = [UIColor redColor].CGColor;
    _textFiledLB.layer.borderWidth = 1;
    _textFiledLB.placeholder = textPlaceholderStr;
//    _textFiledLB.text = textStr;
    _textFiledLB.text9PointAlignment = BSTextAlignmentLeftBottom;
    [self.view addSubview:_textFiledLB];
    
    _textFiledCB = [[BSTextField alloc] initWithFrame:kTextFieldFrameCB];
    _textFiledCB.backgroundColor = [UIColor whiteColor];
    _textFiledCB.textColor = [UIColor blackColor];
    _textFiledCB.layer.borderColor = [UIColor redColor].CGColor;
    _textFiledCB.layer.borderWidth = 1;
    _textFiledCB.placeholder = textPlaceholderStr;
//    _textFiledCB.text = textStr;
    _textFiledCB.text9PointAlignment = BSTextAlignmentCenterBottom;
    [self.view addSubview:_textFiledCB];
    
    _textFiledRB = [[BSTextField alloc] initWithFrame:kTextFieldFrameRB];
    _textFiledRB.backgroundColor = [UIColor whiteColor];
    _textFiledRB.textColor = [UIColor blackColor];
    _textFiledRB.layer.borderColor = [UIColor redColor].CGColor;
    _textFiledRB.layer.borderWidth = 1;
    _textFiledRB.placeholder = textPlaceholderStr;
//    _textFiledRB.text = textStr;
    _textFiledRB.text9PointAlignment = BSTextAlignmentRightBottom;
    [self.view addSubview:_textFiledRB];
    
    _textFiledLast = [[UITextField alloc] initWithFrame:kTextFieldFrameL];
    _textFiledLast.backgroundColor = [UIColor whiteColor];
    _textFiledLast.textColor = [UIColor blackColor];
    _textFiledLast.layer.borderColor = [UIColor redColor].CGColor;
    _textFiledLast.layer.borderWidth = 1;
    _textFiledLast.textAlignment = NSTextAlignmentCenter;
    _textFiledLast.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    _textFiledLast.placeholder = @"请输入姓名";
    [self.view addSubview:_textFiledLast];
}

@end
