//
//  ViewController.h
//  testCollage
//
//  Created by Serhii Kostiuk on 02.09.16.
//  Copyright © 2016 Serhii Kostiuk. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "SAMultisectorControl.h"
#import "CustomSlider.h"


@interface ViewController : UIViewController
//@property (weak, nonatomic) IBOutlet SAMultisectorControl *multisectorControl;
@property (weak, nonatomic) IBOutlet CustomSlider *slider;

@property (weak, nonatomic) IBOutlet UILabel *priceStartLable;
@property (weak, nonatomic) IBOutlet UILabel *priceEndLable;
@property (weak, nonatomic) IBOutlet UILabel *distanceStartLable;
@property (weak, nonatomic) IBOutlet UILabel *distanceEndLable;
@property (weak, nonatomic) IBOutlet UILabel *waitStartLable;
@property (weak, nonatomic) IBOutlet UILabel *waitEndLable;

@end

