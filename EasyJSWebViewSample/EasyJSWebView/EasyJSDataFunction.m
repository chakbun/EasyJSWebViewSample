//
//  EasyJSDataFunction.m
//  EasyJSWebViewSample
//
//  Created by Alex Lau on 21/1/13.
//  Copyright (c) 2013 Dukeland. All rights reserved.
//

#import "EasyJSDataFunction.h"

@implementation EasyJSDataFunction

- (instancetype)initWithWebView:(EasyJSWebView *)webView {
	self = [super init];
    if (self) {
		_webView = webView;
    }
    return self;
}

- (NSString *)execute{
	return [self executeWithParams:nil];
}

- (NSString *)executeWithParam:(NSString *)param {
	NSMutableArray *params = [[NSMutableArray alloc] initWithObjects:param,nil];
	return [self executeWithParams:params];
}

- (NSString *)executeWithParams:(NSArray *)params {
//	NSMutableString *injection = [[NSMutableString alloc] init];
    NSMutableString *injection = [NSMutableString string];
	
	[injection appendFormat:@"EasyJS.invokeCallback(\"%@\", %@", self.funcID, self.removeAfterExecute ? @"true" : @"false"];
	
	if (params){
		for (int i = 0, l = (int)params.count; i < l; i++){
			NSString *arg = params[i];
            NSString *encodedArg = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)arg, NULL, (CFStringRef) @"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8));
			[injection appendFormat:@", \"%@\"", encodedArg];
		}
	}
    
	[injection appendString:@");"];
	
	if (_webView){
		return [_webView stringByEvaluatingJavaScriptFromString:injection];
	}else{
		return nil;
	}
}

@end