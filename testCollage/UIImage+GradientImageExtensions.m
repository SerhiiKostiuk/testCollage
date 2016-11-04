//
//  UIImage+GradientImageExtensions.m
//  testCollage
//
//  Created by Serhii Kostiuk on 26.09.16.
//  Copyright © 2016 Serhii Kostiuk. All rights reserved.
//

#import "UIImage+GradientImageExtensions.h"

@implementation UIImage (GradientImageExtensions)

+ (UIImage *)imageFromLayer:(CALayer *)layer {
    UIGraphicsBeginImageContextWithOptions(layer.frame.size, layer.opaque, 0.0);
    
    layer.cornerRadius = 5.f;
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return outputImage;
}

@end
