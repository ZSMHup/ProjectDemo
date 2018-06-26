//
//  CommenWebViewController.h
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/26.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "BaseViewController.h"

@interface CommenWebViewController : BaseViewController

@property (nonatomic, strong) NSString *webUrl;

@end

@interface WeakScriptMessageDelegate : NSObject <WKScriptMessageHandler>

@property (nonatomic, weak) id <WKScriptMessageHandler> scriptDelegate;

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate;

@end
