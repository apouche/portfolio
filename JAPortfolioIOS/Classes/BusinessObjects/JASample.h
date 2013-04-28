//
//  JASample.h
//  JAPortfolioIOS
//
//  Created by Johan Attali on 4/27/13.
//  Copyright (c) 2013 Johan Attali. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JASample : NSObject
@property (nonatomic, retain) NSString* title;
@property (nonatomic, assign) SEL selector;

+ (id)sampleCollectionView;

@end
