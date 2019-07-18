//
//  YOChatEmoticonTextParser.h
//  ChatHall
//
//  Created by Marvin on 2019/4/15.
//  Copyright © 2019 IAN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYText/YYText.h>

NS_ASSUME_NONNULL_BEGIN

#define YOChatEmoticonTextParserInstance [YOChatEmoticonTextParser sharedInstance]

@interface YOChatEmoticonTextParser : NSObject<YYTextParser>

@property (nonatomic, strong) UIFont *font;

+ (instancetype)sharedInstance;

- (NSMutableAttributedString *)getAttributedStringWith:(NSMutableAttributedString *)text;

@end

NS_ASSUME_NONNULL_END
