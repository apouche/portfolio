/*
 * Copyright (C) 2009 Johan Attali.
 * All rights reserved.
 *
 * You are not allowed to use the source code or the resulting binary code,
 * nor to modify the source code, without prior permission of the owner.
 */

#import <UIKit/UIKit.h>

#pragma mark -
#pragma mark SnSUtils

@interface JAUtils : NSObject
{
    
}

/**
 * Use to detecte iPad device.
 */
+ (BOOL) isPad;
/**
 * Use to check validity of an email.
 **/
+ (BOOL) emailIsValid:(NSString *)email;

/**
 * Returns the Documents path of the application
 * @return: The Documents/ Path of the application
 */
+ (NSString*) applicationDocumentsPath;

/** 
 * Returns the Caches path of the application
 * Base from Apple documentation:
 * 
 * Only documents and other data that is user-generated, or that cannot 
 * otherwise be recreated by your application, should be stored in the 
 * <Application_Home>/Documents directory and will be automatically backed up by iCloud.
 *
 * Data that can be downloaded again or regenerated should be stored in the
 * <Application_Home>/Library/Caches directory. Examples of files you should
 * put in the Caches directory include database cache files and downloadable content,
 * such as that used by magazine, newspaper, and map applications.
 * @return: The Library/Caches Path of the application
 */
+ (NSString*) applicationCachesPath;

@end



