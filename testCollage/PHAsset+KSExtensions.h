//
//  PHAsset+KSExtensions.h
//  testCollage
//
//  Created by Serhii Kostiuk on 06.09.16.
//  Copyright © 2016 Serhii Kostiuk. All rights reserved.
//

#import <Photos/Photos.h>

@interface PHAsset (KSExtensions)

+(PHAsset*)getAssetFromlocalIdentifier:(NSString*)localIdentifier;

@end
