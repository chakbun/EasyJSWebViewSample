//
//  EasyJSWebView.m
//  EasyJS
//
//  Created by Lau Alex on 19/1/13.
//  Copyright (c) 2013 Dukeland. All rights reserved.
//

#import "EasyJSWebView.h"

@implementation EasyJSWebView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
		[self initEasyJS];
    }
    return self;
}

- (instancetype)init {
	self = [super init];
    
    if (self) {
		[self initEasyJS];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	
	if (self){
		[self initEasyJS];
	}
	
	return self;
}

- (void)initEasyJS {
	_proxyDelegate = [[EasyJSWebViewProxyDelegate alloc] init];
	self.delegate =self.proxyDelegate;
}

- (void)setDelegate:(id<UIWebViewDelegate>)delegate {
	if (delegate != self.proxyDelegate){
		self.proxyDelegate.realDelegate = delegate;
	}else{
		[super setDelegate:delegate];
	}
}

- (void)addJavascriptInterfaces:(NSObject *)interface WithName:(NSString *)name {
	[self.proxyDelegate addJavascriptInterfaces:interface WithName:name];
}

- (void)dealloc {
	self.proxyDelegate = nil;
}

@end
