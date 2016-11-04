//
//  PHAsset+KSExtensions.m
//  testCollage
//
//  Created by Serhii Kostiuk on 06.09.16.
//  Copyright © 2016 Serhii Kostiuk. All rights reserved.
//

#import "PHAsset+KSExtensions.h"

@implementation PHAsset (KSExtensions)


+(PHAsset*)getAssetFromlocalIdentifier:(NSString*)localIdentifier{
    if(localIdentifier == nil){
        NSLog(@"Cannot get asset from localID because it is nil");
        return nil;
    }
    PHFetchResult *result = [PHAsset fetchAssetsWithLocalIdentifiers:@[localIdentifier] options:nil];
    if(result.count){
        return result[0];
    }
    return nil;
}

@end
