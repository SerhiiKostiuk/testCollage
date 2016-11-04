//
//  MGInstagram.m
//  MGInstagramDemo
//
//  Created by Mark Glagola on 10/20/12.
//  Copyright (c) 2012 Mark Glagola. All rights reserved.
//

#import "MGInstagram.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NSString+KSExtensions.h"
#import <Photos/Photos.h>
#import <AssetsLibrary/ALAssetsLibrary.h>
#import "PHAsset+KSExtensions.h"

@interface MGInstagram ()

@property (nonatomic, strong) UIDocumentInteractionController *documentInteractionController;

@end

@implementation MGInstagram

NSString* const kInstagramAppURLString = @"instagram://app";
NSString* const kInstagramOnlyPhotoFileName = @"tempinstgramphoto.ig";

- (instancetype)init {
    if (self = [super init]) {
        self.photoFileName = kInstagramOnlyPhotoFileName;
    }
    return self;
}

+ (BOOL)isAppInstalled {
    NSURL *appURL = [NSURL URLWithString:kInstagramAppURLString];
    return [[UIApplication sharedApplication] canOpenURL:appURL];
}



//Technically the instagram allows for photos to be published under the size of 612x612
//BUT if you want nice quality pictures, I recommend checking the image size.
+ (BOOL)isImageCorrectSize:(UIImage*)image {
    CGImageRef cgImage = [image CGImage];
    return (CGImageGetWidth(cgImage) >= 612 && CGImageGetHeight(cgImage) >= 612);
}

- (NSString*)photoFilePath {
    return [NSString stringWithFormat:@"%@/%@",[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"],self.photoFileName];
}

- (void)postImage:(UIImage*)image inView:(UIView*)view {
//    NSURL *fileURL = [NSURL fileURLWithPath:[self photoFilePath]];
    NSURL *instagramURL = [NSURL URLWithString:@"instagram://app"];
    if ([[UIApplication sharedApplication] canOpenURL:instagramURL])
    {

        
        
        
            
            if ([[UIApplication sharedApplication] canOpenURL:instagramURL]) {
                NSLog(@"open asset in instagram");
        
                PHFetchOptions *fetchOptions = [PHFetchOptions new];
                fetchOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
                PHFetchResult *fetchResult = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:fetchOptions];
                PHAsset *lastImageAsset = [fetchResult firstObject];
                
                
                NSString *localIdentifierEscaped = [lastImageAsset.localIdentifier stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
                NSURL *instagramShareURL   = [NSURL URLWithString:[NSString stringWithFormat:@"instagram://library?LocalIdentifier=%@", localIdentifierEscaped]];
                
                [[UIApplication sharedApplication] openURL:instagramShareURL];
            }
        
        
    }
    
    
//    [self postImage:image withCaption:nil inView:view];
}
    
- (void)postImage:(UIImage*)image withCaption:(NSString*)caption inView:(UIView*)view {
    [self postImage:image withCaption:caption inView:view delegate:nil];
}

- (void)postImage:(UIImage*)image withCaption:(NSString*)caption inView:(UIView*)view delegate:(id<UIDocumentInteractionControllerDelegate>)delegate {
    NSParameterAssert(image);
    
    if (!image) {
        return;
    }
    
    [UIImageJPEGRepresentation(image, 1.0) writeToFile:[self photoFilePath] atomically:YES];
    
    NSURL *fileURL = [NSURL fileURLWithPath:[self photoFilePath]];
    self.documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:fileURL];
    self.documentInteractionController.UTI = @"com.instagram.photo";
    self.documentInteractionController.delegate = delegate;
    
    NSString *escapedString   = [fileURL.absoluteString URLEncodedString];
    NSString *escapedCaption  = [@"CamStar" URLEncodedString];
    
    NSURL *instagramURL = [NSURL URLWithString:[NSString stringWithFormat:@"instagram://library?AssetPath=%@&InstagramCaption=%@",escapedString,escapedCaption]];
    
    if (caption) {
        self.documentInteractionController.annotation = @{@"InstagramCaption" : caption};

    }
    [[UIApplication sharedApplication] openURL:instagramURL];
    
    
   
//    [self.documentInteractionController presentOpenInMenuFromRect:CGRectZero inView:view animated:YES];
}


- (NSString*)urlencodedString:(NSString *)message{
    return [message stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet alphanumericCharacterSet]];
}

@end
