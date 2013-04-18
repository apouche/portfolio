//
//  FlickrAbstractObject.h
//  JAPortfolioIOS
//
//  Created by Johan Attali on 4/18/13.
//  Copyright (c) 2013 Johan Attali. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlickrAbstractObject : NSObject
{
    
}
@property (nonatomic, retain) NSString* mainId;

- (id)initWithJSONDictionary:(NSDictionary*)dic;

@end
