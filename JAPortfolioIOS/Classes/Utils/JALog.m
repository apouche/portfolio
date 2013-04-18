/* 
 * Copyright (C) 2009 Smart&Soft.
 * All rights reserved.
 *
 * The code hereby is the full property of Smart&Soft, SIREN 517 961 744.
 * http://www.smartnsoft.com - contact@smartnsoft.com
 * 
 * You are not allowed to use the source code or the resulting binary code, nor to modify the source code, without prior permission of the owner.
 *
 * This library is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 */

#import "JALog.h"
#import "JAUtils.h"

@implementation JALog

+ (void)logLogo
{
    
    NSString* l0 = @" _____        ______  __    __             ___";
    NSString* l1 = @"/\\___ \\      /\\  _  \\/\\ \\__/\\ \\__         /\\_ \\    __";
    NSString* l2 = @"\\/__/\\ \\     \\ \\ \\L\\ \\ \\ ,_\\ \\ ,_\\    __  \\//\\ \\  /\\_\\";
    NSString* l3 = @"   _\\ \\ \\     \\ \\  __ \\ \\ \\/\\ \\ \\/  /'__`\\  \\ \\ \\ \\/\\ \\";
    NSString* l4 = @"  /\\ \\_\\ \\__   \\ \\ \\/\\ \\ \\ \\_\\ \\ \\_/\\ \\L\\.\\_ \\_\\ \\_\\ \\ \\";
    NSString* l5 = @"  \\ \\____/\\_\\   \\ \\_\\ \\_\\ \\__\\\\ \\__\\ \\__/.\\_\\/\\____\\\\ \\_\\";
    NSString* l6 = @"   \\/___/\\/_/    \\/_/\\/_/\\/__/ \\/__/\\/__/\\/_/\\/____/ \\/_/";
	
	NSString* str = [[NSString alloc] initWithFormat:@"Powered by: \n\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n\n", l0, l1, l2, l3, l4, l5, l6];
	
	[self logString:str];
	
	[str release];

}

+ (void)logString:(NSString *)iStr
{
	// We'll log strings asynchrnously into a low priority quue
	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0); 
	
	// This will be used to make sure that the strings are logged 
	// in the same order they came in
	static NSString* _lock_ = nil;
	if (_lock_ == nil)
		_lock_ = [[NSString alloc] init];

	// log everything in the background especially because logging
	// into the file will be SLOW !
	dispatch_async(queue, ^{
		
		@synchronized(_lock_)
		{
			NSLog(@"%@", iStr);

#ifdef JA_LOG_FILE 
#if TARGET_IPHONE_SIMULATOR
			NSDate* aDate = [NSDate date];
			NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
			[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
			[self logString:[NSString stringWithFormat:@"%@ %@",[dateFormatter stringFromDate:aDate], iStr] toFile:[self logFilePath]];
			[dateFormatter release];
#endif
#endif
		}
	});
	

	
}

+ (NSString *)logFilePath
{
	NSString* filename = [[[NSProcessInfo processInfo] processName] stringByAppendingString:@".log"];
	
	filename = [filename stringByReplacingOccurrencesOfString:@" " withString:@"_"];
	
	NSString* filepath = [[JAUtils applicationCachesPath] stringByAppendingPathComponent:filename];
	
	
	return filepath;
}

+ (void)clearLogFile
{
	NSString* filepath = [self logFilePath];
	NSError* error = nil;
	NSFileManager* manager = [NSFileManager defaultManager];

	if ([manager fileExistsAtPath:filepath])
	{
		[manager removeItemAtPath:filepath error:&error];
		if (error != nil)
			JALogE(@"Failed to remove cache with reason %@", [error description]);
	}
	
	BOOL aIsFileCreated = [manager createFileAtPath:filepath contents:nil attributes:nil];
	
	if (!aIsFileCreated)
		JALogE(@"Failed to create log file at path %@", filepath);
}

+ (void)logString:(NSString *)iStr toFile:(NSString *)logFilePath
{
	NSString* aFilePath = [self logFilePath];
	
	iStr = [iStr stringByAppendingString:@"\n"];
	
	// Use a file handle to write at the end of the file
	NSFileHandle *manager = [NSFileHandle fileHandleForWritingAtPath:aFilePath];
	[manager seekToEndOfFile];
	[manager writeData:[iStr dataUsingEncoding:NSUTF8StringEncoding]];
	[manager closeFile];
	
}

+ (void) log:(char *)sourceFile 
  lineNumber:(int)lineNumber
	  method:(const char*)method
	logLevel:(JALogLevel)logLevel 
	  format:(NSString *)format, ...
{
	// We ignore the log the trigger does not match
#ifndef JA_LOG_LEVEL
	return;
#endif
	
	NSString * logLevelString;
	switch (logLevel)
	{
		case JALogLevelDebug:    
		default:
			logLevelString = @"DBG";
			break;
		case JALogLevelInfo:
			logLevelString = @"INF";
			break;
		case JALogLevelWarning:
			logLevelString = @"WRN";
			break;
		case JALogLevelError:
			logLevelString = @"ERR";
			break;
		case JALogLevelFatal:
			logLevelString = @"FTL";
			break;
	}
	
	NSString * filePath = [[NSString alloc] initWithBytes:sourceFile
                                                   length:strlen(sourceFile)
                                                 encoding:NSUTF8StringEncoding];
	
	va_list arguments;
	va_start(arguments, format);
	const NSString* str = [[NSString alloc] initWithFormat:format arguments:arguments];
	va_end(arguments);
	
	NSString* aStringToLog = [[NSString alloc] initWithFormat:@"{%@ - %s:%d %s} %@",
                              logLevelString,
                              [[filePath lastPathComponent] UTF8String],
                              lineNumber,
                              method,
                              str];
	
	[self logString:aStringToLog];
	
	[str release];
	[aStringToLog release];
	[filePath release];
}

+ (void) logWithStringLevel:(char *)sourceFile 
				 lineNumber:(int)lineNumber 
				   logLevel:(JALogLevel)logLevel 
			 logLevelString:(NSString *)logLevelString 
				  exception:(NSException *)exception
					 format:(NSString *)format, ...
{
#ifndef JA_LOG_LEVEL
	return;
#endif
	
	NSString * filePath = [[NSString alloc] initWithBytes:sourceFile length:strlen(sourceFile) encoding:NSUTF8StringEncoding];
	va_list arguments;
	va_start(arguments, format);
	const NSString * print = [[NSString alloc] initWithFormat:format arguments:arguments];
	// Taken from http://stackoverflow.com/questions/1282364/iphone-exception-handling
	// The reference discussion on Apple is under http://developer.apple.com/mac/library/documentation/Cocoa/Conceptual/Exceptions/Tasks/ControllingAppResponse.html#//apple_ref/doc/uid/20000473-DontLinkElementID_3
	const NSString * allPrint = [[NSString alloc] initWithFormat:@"%@\nException:%@\n%@",
                                 print,
                                 [exception reason],
                                 [exception callStackReturnAddresses]];
	va_end(arguments);
	
	NSString* aStringToLog = [[NSString alloc] initWithFormat:@"[%@ - %s:%d] %@",
                              logLevelString,
                              [[filePath lastPathComponent] UTF8String],
                              lineNumber,
                              allPrint];
	
	[self logString:aStringToLog];
	
	[allPrint release];
	[print release];
	[filePath release];  
	[aStringToLog release];
}

@end
