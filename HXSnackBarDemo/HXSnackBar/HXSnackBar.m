//
//  HXSnackBar.m
//  HXSnackBar
//
//  Created by hongxi on 16/5/17.
//  Copyright (c) 2016 hongxi. All rights reserved.
//

#import "HXSnackBar.h"

#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define kSnackBarHeight 52

#define BACKGROUND_COLOR [UIColor colorWithRed:255.0f/255.0f green:68.0f/255.0f blue:68.0f/255.0f alpha:1.0f]
#define NOTICE_TEXT_COLOR [UIColor whiteColor]
#define NOTICE_TEXT_FONT [UIFont systemFontOfSize:15]
#define ACTION_TEXT_COLOR [UIColor whiteColor]
#define ACTION_TEXT_FONT [UIFont boldSystemFontOfSize:15]

#define SHOW_DURATION 2

#define ANIMATION_SHOW_DURATION 0.25
#define ANIMATION_FADE_DURATION 0.18


@interface HXSnackBar ()

@property(nonatomic, assign) CGRect hideFrame;

@property(nonatomic, assign) CGRect showFrame;

+ (instancetype)sharedSnackBar;

@end

@implementation HXSnackBar

#pragma mark - Custom Accessors

- (UILabel *)noticeLabel {
    if (!_noticeLabel) {
        _noticeLabel = [[UILabel alloc] init];
        [self addSubview:_noticeLabel];
    }
    return _noticeLabel;
}

- (UIButton *)actionButton {
    if (!_actionButton) {
        _actionButton = [[UIButton alloc] init];
        [_actionButton addTarget:self action:@selector(onActionButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_actionButton];
    }
    return _actionButton;
}

+ (instancetype)snackBarWithBuilder:(void (^)(HXSnackBarBuilder *builder))block {
    NSParameterAssert(block);

    HXSnackBarBuilder *builder = [[HXSnackBarBuilder alloc] init];
    block(builder);
    return [builder build];
}

static HXSnackBar *instance = nil;

+ (instancetype)sharedSnackBar {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HXSnackBar alloc] init];
    });
    return instance;
}

- (void)show {
    [UIView animateWithDuration:ANIMATION_SHOW_DURATION
                     animations:^{
                         self.frame = self.showFrame;
                     }
                     completion:^(BOOL completed) {
                         if (completed) {
                             //判断是否要消失
                             if (self.builder.duration > 0) {
                                 [self performSelector:@selector(dismiss:) withObject:self.builder afterDelay:self.builder.duration];
                             }
                         }
                     }
    ];
}

- (void)dismiss:(id)object {
    if (object != self.builder) {
        return;
    }
    [UIView animateWithDuration:ANIMATION_FADE_DURATION
                     animations:^{
                         self.frame = self.hideFrame;
                     }
                     completion:^(BOOL completed) {
                         if (self.builder.actionBlock != nil)
                             self.builder.actionBlock();
                         [self removeFromSuperview];
                     }
    ];
}


- (void)onActionButtonTapped:(UIButton *)sender {
    [self dismiss:self.builder];
}

@end


/** ===================================== 我是Builder */

@implementation HXSnackBarBuilder

- (NSTimeInterval)duration {
    if (_duration == 0) {
        _duration = SHOW_DURATION;
    }
    return _duration;
}

- (UIColor *)backgroundColor {
    if (_backgroundColor == nil) {
        _backgroundColor = BACKGROUND_COLOR;
    }
    return _backgroundColor;
}

- (NSString *)noticeText {
    if (_noticeText == nil) {
        _noticeText = @"";
    }
    return _noticeText;
}

- (UIColor *)noticeTextColor {
    if (_noticeTextColor == nil) {
        _noticeTextColor = NOTICE_TEXT_COLOR;
    }
    return _noticeTextColor;
}

- (UIFont *)noticeTextFont {
    if (_noticeTextFont == nil) {
        _noticeTextFont = NOTICE_TEXT_FONT;
    }
    return _noticeTextFont;
}

- (NSString *)actionText {
    if (_actionText == nil) {
        _actionText = @"";
    }
    return _actionText;
}

- (UIColor *)actionTextColor {
    if (_actionTextColor == nil) {
        _actionTextColor = ACTION_TEXT_COLOR;
    }
    return _actionTextColor;
}

- (UIFont *)actionTextFont {
    if (_actionTextFont == nil) {
        _actionTextFont = ACTION_TEXT_FONT;
    }
    return _actionTextFont;
}

- (HXSnackBar *)build {
    HXSnackBar *snackBar = [HXSnackBar sharedSnackBar];
    snackBar.frame = snackBar.hideFrame;
    [snackBar removeFromSuperview];

    snackBar.builder = self;

    snackBar.backgroundColor = self.backgroundColor;
    snackBar.noticeLabel.text = self.noticeText;
    snackBar.noticeLabel.textColor = self.noticeTextColor;
    snackBar.noticeLabel.font = self.noticeTextFont;
    [snackBar.actionButton setTitle:self.actionText forState:UIControlStateNormal];
    [snackBar.actionButton setTitleColor:self.actionTextColor forState:UIControlStateNormal];
    snackBar.actionButton.titleLabel.font = self.actionTextFont;

    //确定SnackBar位置
    if (self.isSlideBelowNavigationBar) {
        //从NavigationBar下面滑出来
        [self.containerViewController.view.superview addSubview:snackBar];
        snackBar.frame = CGRectMake(0, 64 - kSnackBarHeight, kScreenWidth, kSnackBarHeight);
        snackBar.hideFrame = snackBar.frame;
        snackBar.showFrame = CGRectMake(0, 64, kScreenWidth, kSnackBarHeight);
    }
    else {
        //默认从底部滑出
        [self.containerViewController.view.superview addSubview:snackBar];

        snackBar.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kSnackBarHeight);
        snackBar.hideFrame = snackBar.frame;
        snackBar.showFrame = CGRectMake(0, kScreenHeight - kSnackBarHeight, kScreenWidth, kSnackBarHeight);
    }

    [snackBar.actionButton sizeToFit];
    CGFloat buttonWidth = snackBar.actionButton.bounds.size.width;
    snackBar.actionButton.frame = CGRectMake(kScreenWidth - buttonWidth - 32, 0, buttonWidth+32, kSnackBarHeight);
    snackBar.noticeLabel.frame = CGRectMake(16, 0, kScreenWidth - 16 - buttonWidth - 8, kSnackBarHeight);

    return snackBar;
}

@end