//
//  YOChatEmoticonTextParser.m
//  ChatHall
//
//  Created by Marvin on 2019/4/15.
//  Copyright © 2019 IAN. All rights reserved.
//

#import "YOChatEmoticonTextParser.h"
#import "YOChatBundle.h"

@implementation YOChatEmoticonTextParser

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static YOChatEmoticonTextParser *_textParser = nil;
    
    dispatch_once(&onceToken, ^{
        _textParser = [[YOChatEmoticonTextParser alloc] init];
    });
    return _textParser;
}

- (instancetype)init {
    self = [super init];
    if (self){
        self.font = [UIFont systemFontOfSize:15.f];
    }
    return self;
}

- (NSMutableAttributedString *)getAttributedStringWith:(NSMutableAttributedString *)text
{
    if(text != nil)
    {
        [text setYy_color:[UIColor colorWithRed:66/255.f green:66/255.f blue:66/255.f alpha:1.f]];
        [text setYy_font:self.font];
    }
    NSArray<NSTextCheckingResult *> *emoticonResults = [[YOChatBundle regexEmoticon] matchesInString:text.string options:kNilOptions range:text.yy_rangeOfAll];
    NSUInteger clipLength = 0;
    for (NSTextCheckingResult *emo in emoticonResults) {
        if (emo.range.location == NSNotFound && emo.range.length <= 1) continue;
        NSRange range = emo.range;
        range.location -= clipLength;
        if ([text yy_attribute:YYTextAttachmentAttributeName atIndex:range.location]) continue;
        NSString *emoString = [text.string substringWithRange:range];
        NSString *imagePath = [YOChatBundle emoticonDic][emoString];
        UIImage *image = [YOChatBundle imageWithPath:imagePath];
        if (!image) continue;

        __block BOOL containsBindingRange = NO;
        [text enumerateAttribute:YYTextBindingAttributeName inRange:range options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(id value, NSRange range, BOOL *stop) {
            if (value) {
                containsBindingRange = YES;
                *stop = YES;
            }
        }];
        if (containsBindingRange) continue;


        YYTextBackedString *backed = [YYTextBackedString stringWithString:emoString];
        NSMutableAttributedString *emoText = [NSAttributedString yy_attachmentStringWithEmojiImage:image fontSize:15.f];
        [emoText yy_setTextBackedString:backed range:NSMakeRange(0, emoText.length)];
        [emoText yy_setTextBinding:[YYTextBinding bindingWithDeleteConfirm:NO] range:NSMakeRange(0, emoText.length)];
        [text replaceCharactersInRange:range withAttributedString:emoText];
        clipLength += range.length - emoText.length;
    }
    return text;
}


- (BOOL)parseText:(NSMutableAttributedString *)text selectedRange:(NSRangePointer)selectedRange
{
    NSArray<NSTextCheckingResult *> *emoticonResults = [[YOChatBundle regexEmoticon] matchesInString:text.string options:kNilOptions range:text.yy_rangeOfAll];
    NSUInteger clipLength = 0;
    for (NSTextCheckingResult *emo in emoticonResults) {
        if (emo.range.location == NSNotFound && emo.range.length <= 1) continue;
        NSRange range = emo.range;
        range.location -= clipLength;
        if ([text yy_attribute:YYTextAttachmentAttributeName atIndex:range.location]) continue;
        NSString *emoString = [text.string substringWithRange:range];
        NSString *imagePath = [YOChatBundle emoticonDic][emoString];
        UIImage *image = [YOChatBundle imageWithPath:imagePath];
        if (!image) continue;

        __block BOOL containsBindingRange = NO;
        [text enumerateAttribute:YYTextBindingAttributeName inRange:range options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(id value, NSRange range, BOOL *stop) {
            if (value) {
                containsBindingRange = YES;
                *stop = YES;
            }
        }];
        if (containsBindingRange) continue;


        YYTextBackedString *backed = [YYTextBackedString stringWithString:emoString];


        NSMutableAttributedString *emoText = [NSAttributedString yy_attachmentStringWithEmojiImage:image fontSize:17.f];
        // original text, used for text copy
        [emoText yy_setTextBackedString:backed range:NSMakeRange(0, emoText.length)];
        [emoText yy_setTextBinding:[YYTextBinding bindingWithDeleteConfirm:NO] range:NSMakeRange(0, emoText.length)];

        [text replaceCharactersInRange:range withAttributedString:emoText];

        if (selectedRange) {
            *selectedRange = [self _replaceTextInRange:range withLength:emoText.length selectedRange:*selectedRange];
        }
        clipLength += range.length - emoText.length;
    }
    return YES;
}

// correct the selected range during text replacement
- (NSRange)_replaceTextInRange:(NSRange)range withLength:(NSUInteger)length selectedRange:(NSRange)selectedRange {
    // no change
    if (range.length == length) return selectedRange;
    // right
    if (range.location >= selectedRange.location + selectedRange.length) return selectedRange;
    // left
    if (selectedRange.location >= range.location + range.length) {
        selectedRange.location = selectedRange.location + length - range.length;
        return selectedRange;
    }
    // same
    if (NSEqualRanges(range, selectedRange)) {
        selectedRange.length = length;
        return selectedRange;
    }
    // one edge same
    if ((range.location == selectedRange.location && range.length < selectedRange.length) ||
        (range.location + range.length == selectedRange.location + selectedRange.length && range.length < selectedRange.length)) {
        selectedRange.length = selectedRange.length + length - range.length;
        return selectedRange;
    }
    selectedRange.location = range.location + length;
    selectedRange.length = 0;
    return selectedRange;
}

@end
