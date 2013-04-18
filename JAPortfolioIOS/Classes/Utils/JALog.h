/*
 * Copyright (C) 2009 Johan Attali.
 * All rights reserved.
 *
 * You are not allowed to use the source code or the resulting binary code,
 * nor to modify the source code, without prior permission of the owner.
 */

#import <Foundation/Foundation.h>

#if JA_LOG_LEVEL_DEBUG != 0
#	define JA_LOG_LEVEL 5
#endif

#if JA_LOG_LEVEL_INFO != 0
#	define JA_LOG_LEVEL 4
#endif

#if JA_LOG_LEVEL_WARN != 0
#	define JA_LOG_LEVEL 3
#endif

#if JA_LOG_LEVEL_ERROR != 0
#	define JA_LOG_LEVEL 2
#endif

#if JA_LOG_LEVEL_FATAL != 0
#	define JA_LOG_LEVEL 1
#endif

// JA starting logo

#define JALogLogo()	[JALog logLogo]

// Clear log file

#if JA_LOG_FILE != 0					
#	define JALogClear()		\
		[JALog clearLogFile]
#else
#	define JALogClear()
#endif


// No log level has been specified: in that case, we discard all logs

#if JA_LOG_LEVEL != 0
#	define JALog(theLogLevel, theFormat, ...)						\
		[JALog log:__FILE__										\
		 lineNumber:__LINE__										\
		   logLevel:(theLogLevel)									\
			 format:(theFormat), ##__VA_ARGS__]
#else
#	define JALog(theLogLevel, theFormat, ...)
#endif

#if JA_LOG_LEVEL >= 5
#	define JALogD(theFormat, ...)									\
		[JALog log:__FILE__										\
		 lineNumber:__LINE__										\
			 method:__FUNCTION__									\
	       logLevel:JALogLevelDebug								\
			 format:(theFormat), ##__VA_ARGS__]
#else
#	define JALogD(theFormat, ...)
#endif

#if JA_LOG_LEVEL >= 4
#	define JALogI(theFormat, ...)									\
		[JALog log:__FILE__										\
		 lineNumber:__LINE__										\
			 method:__FUNCTION__									\
		   logLevel:JALogLevelInfo									\
			 format:(theFormat), ##__VA_ARGS__]
#else
#	define JALogI(theFormat, ...)
#endif

#if JA_LOG_LEVEL >= 3
#	define JALogW(theFormat, ...)									\
		[JALog log:__FILE__										\
		 lineNumber:__LINE__										\
			 method:__FUNCTION__									\
		   logLevel:JALogLevelWarning								\
			 format:(theFormat), ##__VA_ARGS__]

#	define JALogEW(theException, theFormat, ...)					\
		[JALog logWithStringLevel:__FILE__							\
						lineNumber:__LINE__							\
						  logLevel:JALogLevelWarning				\
					logLevelString:@"WARN"							\
						 exception:(theException)					\
							format:(theFormat), ##__VA_ARGS__]
#else
#	define JALogW(theFormat, ...)
#	define JALogEW(theException, theFormat, ...)
#endif

#if JA_LOG_LEVEL >= 2
# define JALogE(theFormat, ...)									\
		[JALog log:__FILE__										\
		 lineNumber:__LINE__										\
		 	 method:__FUNCTION__									\
		   logLevel:JALogLevelError								\
			 format:(theFormat), ##__VA_ARGS__]

#	define JALogEE(theException, theFormat, ...)					\
		[JALog logWithStringLevel:__FILE__							\
						lineNumber:__LINE__							\
						  logLevel:JALogLevelError					\
					logLevelString:@"ERROR"							\
						 exception:(theException)					\
							format:(theFormat), ##__VA_ARGS__]
#else
#	define JALogE(theFormat, ...)
#	define JALogEE(theException, theFormat, ...)
#endif

#if JA_LOG_LEVEL >= 1
#	define JALogF(theFormat, ...)									\
		[JALog log:__FILE__										\
		 lineNumber:__LINE__										\
			 method:__FUNCTION__									\
		   logLevel:JALogLevelFatal								\
			 format:(theFormat), ##__VA_ARGS__]

#	define JALogEF(theException, theFormat, ...)					\
		[JALog logWithStringLevel:__FILE__							\
						lineNumber:__LINE__							\
						  logLevel:JALogLevelFatal					\
					logLevelString:@"FATAL"							\
						 exception:(theException)					\
							format:(theFormat), ##__VA_ARGS__]
#else
#	define JALogF(theFormat, ...)
#	define JALogFF(theException, theFormat, ...)
#endif

/**
 * Indicates the log level.
 */
typedef enum
{
  JALogLevelDebug		= 5,
  JALogLevelInfo		= 4,
  JALogLevelWarning	= 3,
  JALogLevelError		= 2,
  JALogLevelFatal		= 1,
}
JALogLevel;

/**
 * Defines some helper functions and macros for logging.
 *
 * The log helpers should be exclusively used from macros, so that some logs can be removed from the compilation process
 * for a production environment purpose. The <code>JALogD</code>, <code>JALogI</code>, <code>JALogW</code>,
 * <code>JALogE</code> and <code>JALogF</code> macros should be used, and not directly the static methods! 
 */
@interface JALog : NSObject
{
}

/**
 * Log the Smart&Soft logo in a nice Ascii Art
 * (http://goo.gl/Rcd42)
 */
+ (void)logLogo;

/** 
 * This is the main method to log anything with the JA Framework.
 * If logging on file is activated than it also handled here.
 * @param iStr	The NSString to log
 */
+ (void)logString:(NSString*)iStr;

+ (NSString*)logFilePath;

+ (void)clearLogFile;

/** 
 * Logs a specified string into the application specified log file
 * @param iStr	The NSString to log
 * @param logFilePath The path for the file to log the string in
 */
+ (void)logString:(NSString*)iStr toFile:(NSString*)logFilePath;

/**
 * Do not use, use the macros instead!
 */
+ (void) log:(char *)sourceFile 
  lineNumber:(int)lineNumber 
	  method:(const char*)method
	logLevel:(JALogLevel)logLevel 
	  format:(NSString *)format, ...;

///**
// * Do not use, use the macros instead!
// */
//+ (void) logWithStringLevel:(char *)sourceFile 
//				 lineNumber:(int)lineNumber 
//				   logLevel:(JALogLevel)logLevel 
//			 logLevelString:(NSString *)logLevelString 
//					 format:(NSString *)format, ...;

/**
 * Do not use, use the macros instead!
 */
+ (void) logWithStringLevel:(char *)sourceFile 
				 lineNumber:(int)lineNumber 
				   logLevel:(JALogLevel)logLevel 
			 logLevelString:(NSString *)logLevelString 
				  exception:(NSException *)exception 
					 format:(NSString *)format, ...;

@end
