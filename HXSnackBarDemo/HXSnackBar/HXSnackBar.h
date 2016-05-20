//
//  HXSnackBar.h
//  HXSnackBar
//
//  Created by hongxi on 16/5/17.
//  Copyright (c) 2016 hongxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@class HXSnackBar;

typedef void (^actionBlock)();

@interface HXSnackBarBuilder : NSObject

/** 在哪个ViewController中显示 */
@property (nonatomic, weak) UIViewController *containerViewController;

/** 是否从UINavigationBar下面滑出来 */
@property(nonatomic, assign) BOOL isSlideBelowNavigationBar;

/** 显示时长 < 0 为一直显示*/
@property(nonatomic, assign) NSTimeInterval duration;

@property (nonatomic, copy) UIColor *backgroundColor;

/** 提示文本字符串 */
@property(nonatomic, copy) NSString *noticeText;
/** 提示文本颜色 */
@property(nonatomic, copy) UIColor *noticeTextColor;
/** 提示文本字体 */
@property(nonatomic, copy) UIFont *noticeTextFont;

/** 动作文本字符串 */
@property(nonatomic, copy) NSString *actionText;
/** 动作文本颜色 */
@property(nonatomic, copy) UIColor *actionTextColor;
/** 动作文本字体 */
@property(nonatomic, copy) UIFont *actionTextFont;

/** 点击动作按钮的操作block */
@property(nonatomic, copy) actionBlock actionBlock;

- (HXSnackBar *)build;

@end

@interface HXSnackBar : UIView

/** 提示文本Label */
@property(nonatomic, strong) UILabel *noticeLabel;

/** 动作文本字符串 */
@property(nonatomic, strong) UIButton *actionButton;

+ (instancetype)snackBarWithBuilder:(void(^)(HXSnackBarBuilder *builder))block;

@property (nonatomic, strong) HXSnackBarBuilder *builder;

/**
 * 显示SnackBar
 */
- (void)show;

@end
