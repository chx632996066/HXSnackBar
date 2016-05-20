# HXSnackBar
一个很方便的提供消息提示和动作反馈的库

![](https://github.com/chx632996066/HXSnackBar/blob/master/HXSnackBarDemo/HXSnackBar.gif)


>用法

`
HXSnackBar *snackBar = [HXSnackBar snackBarWithBuilder:^(HXSnackBarBuilder *builder) {
                builder.containerViewController = self;
        builder.duration = -1;
        builder.noticeText = @"网络好像有点不稳定";
        builder.actionText = @"重新尝试";
        builder.actionBlock = ^{
            NSLog(@"666666");
        };
    }];
    [snackBar show];
 `

>HXSnackBarBuilder支持属性
`
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
`