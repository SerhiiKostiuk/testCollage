//
//  NSString+KSExtensions.m
//  testCollage
//
//  Created by Serhii Kostiuk on 06.09.16.
//  Copyright © 2016 Serhii Kostiuk. All rights reserved.
//

#import "NSString+KSExtensions.h"

@implementation NSString (KSExtensions)

- (NSString *)URLEncodedString
{
    return [self URLEncodedStringWithCFStringEncoding:kCFStringEncodingUTF8];
}

- (NSString *)URLEncodedStringWithCFStringEncoding:(CFStringEncoding)encoding
{
    return (NSString *) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)[self mutableCopy] , NULL, CFSTR("￼=,!$&'()*+;@?\n\"<>#\t :/"), encoding));
}

@end
