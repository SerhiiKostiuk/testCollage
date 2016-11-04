//
//  CustomSlider.m
//  testCollage
//
//  Created by Serhii Kostiuk on 26.09.16.
//  Copyright © 2016 Serhii Kostiuk. All rights reserved.
//

#import "CustomSlider.h"
#import "UIImage+GradientImageExtensions.h"


@implementation CustomSlider

- (CGRect)trackRectForBounds:(CGRect)bounds {
    CGRect rect = CGRectMake(0, 0, bounds.size.width, 10);//change it to any size you want
    return rect;
}

- (void)setGradientBackgroundWithColors:(NSArray *)colors {
    CAGradientLayer *trackGradientLayer = [CAGradientLayer layer];
    CGRect frame = self.frame;
    frame.size.height = 10.0; //set the height of slider
    trackGradientLayer.frame = frame;
    trackGradientLayer.colors = colors;
    //setting gradient as horizontal
    trackGradientLayer.startPoint = CGPointMake(0.0, 0.5);
    trackGradientLayer.endPoint = CGPointMake(self.value/10, 0.5);
    
    UIImage *trackImage = [[UIImage imageFromLayer:trackGradientLayer] resizableImageWithCapInsets:UIEdgeInsetsZero];
    [self setMinimumTrackImage:trackImage forState:UIControlStateNormal];
//    [self setMaximumTrackImage:trackImage forState:UIControlStateNormal];
}


@end
