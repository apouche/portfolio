//
//  JARemoteServices.h
//  JAPortfolioIOS
//
//  Created by Johan Attali on 4/18/13.
//  Copyright (c) 2013 Johan Attali. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^JABasicBlock)(id object, NSError* error);

@interface JARemoteManager : NSObject <NSXMLParserDelegate>

+ (JARemoteManager*)sharedManager;

- (void)handleJsonResult:(id)json withClass:(Class)iClass completion:(JABasicBlock)completion;

- (void)retrieveFlickrMostInteresting:(NSInteger)page completion:(JABasicBlock)completion;

@end
