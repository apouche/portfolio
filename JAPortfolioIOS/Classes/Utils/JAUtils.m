/* 
 * Copyright (C) 2009 Johan Attali.
 * All rights reserved.
 * 
 * You are not allowed to use the source code or the resulting binary code,
 * nor to modify the source code, without prior permission of the owner.
 */

#import "JAUtils.h"


#pragma mark -
#pragma mark SnSUtils

@implementation JAUtils

+ (BOOL) isPad {
#ifdef UI_USER_INTERFACE_IDIOM
	return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
#else
	return NO;
#endif
}

+ (BOOL) emailIsValid:(NSString *)email
{
	
	NSString *emailRegEx = 
	@"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
	@"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
	@"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
	@"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
	@"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
	@"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
	@"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
	NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx] ;
	
	return [regExPredicate evaluateWithObject:[email lowercaseString]];
}

+ (NSString*)applicationDocumentsPath                                                                                     
{                                                                                                                       
    NSArray *aPaths			= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);          
    NSString *aWritablePath	= [aPaths objectAtIndex:0];                                                                 
    
    return aWritablePath;                                                                                               
}

+ (NSString*)applicationCachesPath
{                                                                                                                       
    NSArray *aPaths			= NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);          
    NSString *aWritablePath	= [aPaths objectAtIndex:0];                                                                 
    
    return aWritablePath;                                                                                               
}
@end




