//
//  YOChatEmoticonGroup.m
//  ChatHall
//
//  Created by Marvin on 2019/4/15.
//  Copyright © 2019 IAN. All rights reserved.
//

#import "YOChatEmoticonGroup.h"

@implementation YOChatEmoticon

+ (NSArray *)modelPropertyBlacklist {
    return @[@"group"];
}

@end

@implementation YOChatEmoticonGroup

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"groupID" : @"id",
             @"nameCN" : @"group_name_cn",
             @"nameEN" : @"group_name_en",
             @"nameTW" : @"group_name_tw",
             @"displayOnly" : @"display_only",
             @"groupType" : @"group_type"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"emoticons" : [YOChatEmoticon class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    [_emoticons enumerateObjectsUsingBlock:^(YOChatEmoticon *emoticon, NSUInteger idx, BOOL *stop) {
        emoticon.group = self;
    }];
    return YES;
}

@end
