//
//  ViewController.m
//  YOChatEmoticon
//
//  Created by IAN on 2019/4/16.
//  Copyright © 2019 PPTV. All rights reserved.
//

#import "ViewController.h"
#import "YOChatEmoticonInputView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    YOChatEmoticonInputView *view = [YOChatEmoticonInputView sharedView];

    [self.view addSubview:view];
}


@end
