//
//  YOChatEmoticonInputView.h
//  ChatHall
//
//  Created by Marvin on 2019/4/15.
//  Copyright © 2019 IAN. All rights reserved.
//  表情输入键盘

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YOChatEmoticonInputViewDelegate <NSObject>

@optional
- (void)emoticonInputDidTapText:(NSString *)text;
- (void)emoticonInputDidTapBackspace;

@end

@interface YOChatEmoticonInputView : UIView

@property (nonatomic, weak) id<YOChatEmoticonInputViewDelegate> delegate;

+ (instancetype)sharedView;

@end

NS_ASSUME_NONNULL_END
