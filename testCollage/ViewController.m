//
//  ViewController.m
//  testCollage
//
//  Created by Serhii Kostiuk on 02.09.16.
//  Copyright © 2016 Serhii Kostiuk. All rights reserved.
//

#import "ViewController.h"
#import "MGInstagram.h"
#import <QuartzCore/QuartzCore.h>
#import "FillCaptionViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#include <CoreMedia/CMSampleBuffer.h>
#include <ImageIO/ImageIO.h>
#import <Photos/PHAsset.h>
#import <Photos/Photos.h>


static NSString * const kMIRatingTitle                  = @"Great job! \n \u2B50\u2B50\u2B50\u2B50\u2B50";//@"Do you enjoy using our application?";
static NSString * const kMIRatingMessage                = @"We think you're awesome!\n Would you mind taking a moment to leave your rating on iTunes ?";//@"Please take a minute to give us ratings/reviews so we can keep improving our application";


@interface ViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate>
@property (nonatomic, retain)   UIImagePickerController         *imagePickerController;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView  *imageView;
@property (nonatomic, strong) MGInstagram *instagram;
@property (nonatomic, strong) UIImage  *image;
//@property (nonatomic, strong) UIDocumentInteractionController *documentInteractionController;
@property (weak, nonatomic) IBOutlet UIButton *addCaptionButton;
@property (nonatomic, strong) CAShapeLayer *border;
@property (nonatomic,strong) UILabel *sliderValueLabel;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self setupDesign];
//    [self setupMultisectorControl];
    
    UIImage *thumbImage = [UIImage imageNamed:@"slider_handle"];
    [self.slider setThumbImage:thumbImage forState:UIControlStateNormal];
    
    [self.slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.slider setMinimumValue:1];
    [self.slider setMaximumValue:10];
    

    
//    UIImage *image = [UIImage imageNamed:@"preplay_start.png"];
//    UIImage *image = [UIImage imageNamed:@"1111"];

//    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0,10, 00, 0) resizingMode:UIImageResizingModeStretch];

//    [self.slider setMinimumTrackImage:image
//                             forState:UIControlStateNormal];
    
//    self.slider.contentMode = UIViewContentModeScaleAspectFit;
    
//    self.sliderValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];

//    [self.slider addSubview:self.sliderValueLabel];

    
    self.instagram = [[MGInstagram alloc] init];
    
    self.instagram.photoFileName = @"TempPhoto.png";
    //The following will only show Instagram as an option
    self.instagram.photoFileName = kInstagramOnlyPhotoFileName;
    

    
   _border = [CAShapeLayer layer];
    _border.strokeColor = [UIColor redColor].CGColor;
    _border.fillColor = nil;

    _border.lineDashPattern = @[@4, @2];
    [self.addCaptionButton.layer addSublayer:_border];
    
//    UIAlertController *alert= [UIAlertController
//                               alertControllerWithTitle:kMIRatingTitle
//                               message:kMIRatingMessage
//                               preferredStyle:UIAlertControllerStyleAlert];
//    
//    [self presentViewController:alert animated:YES completion:nil];

}

-(void)viewDidAppear:(BOOL)animated {
//    [self setGradientToSlider:self.slider WithColors:[NSArray arrayWithObjects:(id)[[UIColor redColor] CGColor],(id)[[UIColor orangeColor] CGColor], nil]];
    
    [self.slider setGradientBackgroundWithColors:[NSArray arrayWithObjects:
                                                  (id)[[UIColor colorWithRed:235.0/255.0 green:135.0/255.0 blue:57.0/255.0 alpha:1.0] CGColor],
                                                  (id)[[UIColor colorWithRed:235.0/255.0 green:128.0/255.0 blue:60.0/255.0 alpha:1.0] CGColor],
                                                  (id)[[UIColor colorWithRed:235.0/255.0 green:121.0/255.0 blue:64.0/255.0 alpha:1.0] CGColor],
                                                  (id)[[UIColor colorWithRed:235.0/255.0 green:115.0/255.0 blue:68.0/255.0 alpha:1.0] CGColor],
                                                  (id)[[UIColor colorWithRed:235.0/255.0 green:108.0/255.0 blue:71.0/255.0 alpha:1.0] CGColor],
                                                  
                                                  (id)[[UIColor colorWithRed:235.0/255.0 green:102.0/255.0 blue:75.0/255.0 alpha:1.0] CGColor],
                                                  (id)[[UIColor colorWithRed:235.0/255.0 green:95.0/255.0 blue:79.0/255.0 alpha:1.0] CGColor],
                                                  (id)[[UIColor colorWithRed:235.0/255.0 green:89.0/255.0 blue:82.0/255.0 alpha:1.0] CGColor],
                                                  (id)[[UIColor colorWithRed:235.0/255.0 green:82.0/255.0 blue:86.0/255.0 alpha:1.0] CGColor],
                                                  (id)[[UIColor colorWithRed:235.0/255.0 green:76.0/255.0 blue:90.0/255.0 alpha:1.0] CGColor],
                                                  nil]];
}


- (void)viewWillLayoutSubviews {
    _border.path = [UIBezierPath bezierPathWithRoundedRect:self.addCaptionButton.bounds cornerRadius:10.f].CGPath;
    _border.frame = self.addCaptionButton.bounds;
}

- (IBAction)showGallery:(id)sender {
    self.imagePickerController.delegate = self;
    [self.imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController presentViewController:self.imagePickerController animated:YES completion:nil];
}

- (IBAction)shareButton:(id)sender {

//    if ([MGInstagram isAppInstalled] && [MGInstagram isImageCorrectSize:self.image]) {
//        [self.instagram postImage:self.image inView:self.view];
//    }
//    else {
//        NSLog(@"Error Instagram is either not installed or image is incorrect size");
//    }
    
    UIImageWriteToSavedPhotosAlbum([self rasterizedImageInView:self.backgroundView atRect:self.backgroundView.frame], nil, nil, nil);
    
}
- (IBAction)fillCaption:(id)sender {
    FillCaptionViewController *captionView = [[FillCaptionViewController alloc] initWithNibName:@"FillCaptionViewController" bundle:nil];
    self.providesPresentationContextTransitionStyle = YES;
    self.definesPresentationContext = YES;
    [captionView setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    [self presentViewController:captionView animated:YES completion:nil];
    
}

- (UIImage *)rasterizedImageInView:(UIView *)view atRect:(CGRect)rect {
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


- (void)configureZoomScale{

    self.scrollView.alwaysBounceVertical = NO;
    self.scrollView.alwaysBounceHorizontal = NO;

    CGFloat xZoomScale = self.scrollView.bounds.size.width/self.imageView.bounds.size.width;
    CGFloat yZoomScale = self.scrollView.bounds.size.height/self.imageView.bounds.size.height;

    self.scrollView.maximumZoomScale = 4;
    
    self.scrollView.bounces = YES;
    
    if (self.imageView.bounds.size.width >= self.imageView.bounds.size.height) {
        self.scrollView.minimumZoomScale = yZoomScale;

        self.scrollView.zoomScale = yZoomScale;
        self.scrollView.alwaysBounceHorizontal = YES;
    } else {
        self.scrollView.minimumZoomScale = xZoomScale;

        self.scrollView.zoomScale = xZoomScale;
        self.scrollView.alwaysBounceVertical = YES;
    }
}


- (UIImagePickerController *)imagePickerController {
    if (nil == _imagePickerController) {
        self.imagePickerController = [UIImagePickerController new];
    }
    return _imagePickerController;
}

#pragma mark -
#pragma mark ImagePickerDelegate

//// Respond to the user accepting a newly-captured picture
//- (void) imagePickerController: (UIImagePickerController *) picker
// didFinishPickingMediaWithInfo: (NSDictionary *) info {
//    
//    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
//    UIImage *originalImage, *editedImage, *imageToSave;
//    
//    // Handle a still image capture
//    if (CFStringCompare ((CFStringRef) mediaType,(CFStringRef)mediaType, 0)
//        == kCFCompareEqualTo) {
//        
//        editedImage = (UIImage *) [info objectForKey:
//                                   UIImagePickerControllerEditedImage];
//        originalImage = (UIImage *) [info objectForKey:
//                                     UIImagePickerControllerOriginalImage];
//        
//        if (editedImage) {
//            imageToSave = editedImage;
//        } else {
//            imageToSave = originalImage;
//        }
//        
//        // Get the image metadata
//        UIImagePickerControllerSourceType pickerType = picker.sourceType;
//        if(pickerType == UIImagePickerControllerSourceTypeCamera)
//        {
//            NSDictionary *imageMetadata = [info objectForKey:
//                                           UIImagePickerControllerMediaMetadata];
//            // Get the assets library
//            ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
//            ALAssetsLibraryWriteImageCompletionBlock imageWriteCompletionBlock =
//            ^(NSURL *newURL, NSError *error) {
//                if (error) {
//                    NSLog( @"Error writing image with metadata to Photo Library: %@", error );
//                } else {
//                    NSLog( @"Wrote image with metadata to Photo Library");
//                }
//            };
//            
//            // Save the new image (original or edited) to the Camera Roll
//            [library writeImageToSavedPhotosAlbum:[imageToSave CGImage]
//                                         metadata:imageMetadata
//                                  completionBlock:imageWriteCompletionBlock];
//        }
//    }
//    
//    
//    [[picker parentViewController] dismissViewControllerAnimated:YES completion:nil];
////    [picker release];
//}
//
//+ (void)addMetadata:(NSDictionary *)metadataToAdd toImageDataSampleBuffer:(CMSampleBufferRef)imageDataSampleBuffer  {
//    // Grab metadata of image
//    CFDictionaryRef metadataDict = CMCopyDictionaryOfAttachments(NULL, imageDataSampleBuffer, kCMAttachmentMode_ShouldPropagate);
//    NSMutableDictionary *imageMetadata = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary *)metadataDict];
//    CFRelease(metadataDict);
//    
//    for( NSString *metadataName in metadataToAdd )
//    {
//        id metadata = [metadataToAdd valueForKey:metadataName];
//        
//        if( [metadata isKindOfClass:NSDictionary.class] )
//        {
//            NSMutableDictionary *subDict = [imageMetadata valueForKey:metadataName];
//            if( !subDict )
//            {
//                subDict = [NSMutableDictionary dictionary];
//                [imageMetadata setValue:subDict forKey:metadataName];
//            }
//            [subDict addEntriesFromDictionary:metadata];
//        }
//        else if( [metadata isKindOfClass:NSString.class] )
//            [imageMetadata setValue:metadata forKey:metadataName];
//        else if( [metadata isKindOfClass:NSValue.class] )
//            [imageMetadata setValue:metadata forKey:metadataName];
//    }
//    
//    // set the dictionary back to the buffer
//    CMSetAttachments(imageDataSampleBuffer, (CFMutableDictionaryRef)imageMetadata, kCMAttachmentMode_ShouldPropagate);
//}
//
//- (void)addMetaData {
//
//
//NSDictionary *iptc = @{
//                       (NSString *)kCGImagePropertyIPTCObjectTypeReference : @"kCGImagePropertyIPTCObjectTypeReference",
//                       (NSString *)kCGImagePropertyIPTCObjectAttributeReference : @"kCGImagePropertyIPTCObjectAttributeReference",
//                       (NSString *)kCGImagePropertyIPTCObjectName : @"kCGImagePropertyIPTCObjectName",
//                       (NSString *)kCGImagePropertyIPTCEditStatus : @"kCGImagePropertyIPTCEditStatus",
//                       (NSString *)kCGImagePropertyIPTCEditorialUpdate : @"kCGImagePropertyIPTCEditorialUpdate",
//                       (NSString *)kCGImagePropertyIPTCUrgency : @"kCGImagePropertyIPTCUrgency",
//                       (NSString *)kCGImagePropertyIPTCSubjectReference : @"kCGImagePropertyIPTCSubjectReference",
//                       (NSString *)kCGImagePropertyIPTCCategory : @"kCGImagePropertyIPTCCategory",
//                       (NSString *)kCGImagePropertyIPTCSupplementalCategory : @"kCGImagePropertyIPTCSupplementalCategory",
//                       (NSString *)kCGImagePropertyIPTCFixtureIdentifier : @"kCGImagePropertyIPTCFixtureIdentifier",
//                       (NSString *)kCGImagePropertyIPTCKeywords : @"kCGImagePropertyIPTCKeywords",
//                       (NSString *)kCGImagePropertyIPTCContentLocationCode : @"kCGImagePropertyIPTCContentLocationCode",
//                       (NSString *)kCGImagePropertyIPTCContentLocationName : @"kCGImagePropertyIPTCContentLocationName",
//                       (NSString *)kCGImagePropertyIPTCReleaseDate : @"kCGImagePropertyIPTCReleaseDate",
//                       (NSString *)kCGImagePropertyIPTCReleaseTime : @"kCGImagePropertyIPTCReleaseTime",
//                       (NSString *)kCGImagePropertyIPTCExpirationDate : @"kCGImagePropertyIPTCExpirationDate",
//                       (NSString *)kCGImagePropertyIPTCExpirationTime : @"kCGImagePropertyIPTCExpirationTime",
//                       (NSString *)kCGImagePropertyIPTCSpecialInstructions : @"kCGImagePropertyIPTCSpecialInstructions",
//                       (NSString *)kCGImagePropertyIPTCActionAdvised : @"kCGImagePropertyIPTCActionAdvised",
//                       (NSString *)kCGImagePropertyIPTCReferenceService : @"kCGImagePropertyIPTCReferenceService",
//                       (NSString *)kCGImagePropertyIPTCReferenceDate : @"kCGImagePropertyIPTCReferenceDate",
//                       (NSString *)kCGImagePropertyIPTCReferenceNumber : @"kCGImagePropertyIPTCReferenceNumber",
//                       (NSString *)kCGImagePropertyIPTCDateCreated : @"kCGImagePropertyIPTCDateCreated",
//                       (NSString *)kCGImagePropertyIPTCTimeCreated : @"kCGImagePropertyIPTCTimeCreated",
//                       (NSString *)kCGImagePropertyIPTCDigitalCreationDate : @"kCGImagePropertyIPTCDigitalCreationDate",
//                       (NSString *)kCGImagePropertyIPTCDigitalCreationTime : @"kCGImagePropertyIPTCDigitalCreationTime",
//                       (NSString *)kCGImagePropertyIPTCOriginatingProgram : <CFBundleName>,
//                       (NSString *)kCGImagePropertyIPTCProgramVersion : <CFBundleVersion>,
//                       (NSString *)kCGImagePropertyIPTCObjectCycle : @"kCGImagePropertyIPTCObjectCycle",
//                       (NSString *)kCGImagePropertyIPTCByline : @"kCGImagePropertyIPTCByline",
//                       (NSString *)kCGImagePropertyIPTCBylineTitle : @"kCGImagePropertyIPTCBylineTitle",
//                       (NSString *)kCGImagePropertyIPTCCity : @"kCGImagePropertyIPTCCity",
//                       (NSString *)kCGImagePropertyIPTCSubLocation : @"kCGImagePropertyIPTCSubLocation",
//                       (NSString *)kCGImagePropertyIPTCProvinceState : @"kCGImagePropertyIPTCProvinceState",
//                       (NSString *)kCGImagePropertyIPTCCountryPrimaryLocationCode : @"kCGImagePropertyIPTCCountryPrimaryLocationCode",
//                       (NSString *)kCGImagePropertyIPTCCountryPrimaryLocationName : @"kCGImagePropertyIPTCCountryPrimaryLocationName",
//                       (NSString *)kCGImagePropertyIPTCOriginalTransmissionReference : @"kCGImagePropertyIPTCOriginalTransmissionReference",
//                       //    (NSString *)kCGImagePropertyIPTCHeadline: : @"kCGImagePropertyIPTCHeadline",
//                       (NSString *)kCGImagePropertyIPTCCredit : @"kCGImagePropertyIPTCCredit",
//                       (NSString *)kCGImagePropertyIPTCSource : @"kCGImagePropertyIPTCSource",
//                       (NSString *)kCGImagePropertyIPTCCopyrightNotice : @"kCGImagePropertyIPTCCopyrightNotice",
//                       (NSString *)kCGImagePropertyIPTCContact : @"kCGImagePropertyIPTCContact",
//                       (NSString *)kCGImagePropertyIPTCCaptionAbstract : @"kCGImagePropertyIPTCCaptionAbstract",
//                       (NSString *)kCGImagePropertyIPTCWriterEditor : @"kCGImagePropertyIPTCWriterEditor",
//                       (NSString *)kCGImagePropertyIPTCImageType : @"kCGImagePropertyIPTCImageType",
//                       (NSString *)kCGImagePropertyIPTCImageOrientation : @"kCGImagePropertyIPTCImageOrientation",
//                       (NSString *)kCGImagePropertyIPTCLanguageIdentifier : @"kCGImagePropertyIPTCLanguageIdentifier",
//                       (NSString *)kCGImagePropertyIPTCStarRating : @"kCGImagePropertyIPTCStarRating",
//                       (NSString *)kCGImagePropertyIPTCCreatorContactInfo : @"kCGImagePropertyIPTCCreatorContactInfo",
//                       (NSString *)kCGImagePropertyIPTCRightsUsageTerms : @"kCGImagePropertyIPTCRightsUsageTerms",
//                       (NSString *)kCGImagePropertyIPTCScene : @"kCGImagePropertyIPTCScene",
//                       (NSString *)kCGImagePropertyIPTCContactInfoCity : @"kCGImagePropertyIPTCContactInfoCity",
//                       (NSString *)kCGImagePropertyIPTCContactInfoCountry : @"kCGImagePropertyIPTCContactInfoCountry",
//                       (NSString *)kCGImagePropertyIPTCContactInfoAddress : @"kCGImagePropertyIPTCContactInfoAddress",
//                       (NSString *)kCGImagePropertyIPTCContactInfoPostalCode : @"kCGImagePropertyIPTCContactInfoPostalCode",
//                       (NSString *)kCGImagePropertyIPTCContactInfoStateProvince : @"kCGImagePropertyIPTCContactInfoStateProvince",
//                       (NSString *)kCGImagePropertyIPTCContactInfoEmails : @"kCGImagePropertyIPTCContactInfoEmails",
//                       (NSString *)kCGImagePropertyIPTCContactInfoPhones : @"kCGImagePropertyIPTCContactInfoPhones",
//                       (NSString *)kCGImagePropertyIPTCContactInfoWebURLs : @"kCGImagePropertyIPTCContactInfoWebURLs" };
//
//
//NSDictionary<NSString *, NSNumber *> *orientation = @{(NSString *)kCGImagePropertyOrientation : <image orientation as NSNumber> };
//
//// Create a new mutable Dictionary and insert the IPTC sub-dictionary and the base orientation property.
//NSMutableDictionary *d = [NSMutableDictionary dictionary];
//d[(NSString *)kCGImagePropertyIPTCDictionary] = iptc;
//[d addEntriesFromDictionary:orientation];
//
//[MetadataClass addMetadata:d toImageDataSampleBuffer:imageDataSampleBuffer];
//
//}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self.imageView removeFromSuperview];

    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.image = image;
    self.imageView = [[UIImageView alloc] initWithImage:image];

    NSData *dataOfImageFromGallery = UIImageJPEGRepresentation (image,1.0);
    NSLog(@"Image length:  %lu", (unsigned long)[dataOfImageFromGallery length]);
    
    
    CGImageSourceRef source;
    source = CGImageSourceCreateWithData((CFDataRef)dataOfImageFromGallery, NULL);
    
    NSDictionary *metadata = (NSDictionary *) CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(source, 0, NULL));
    
    NSMutableDictionary *metadataAsMutable = [metadata mutableCopy];
//    [metadata release];
    
    NSMutableDictionary *EXIFDictionary = [[metadataAsMutable objectForKey:(NSString *)kCGImagePropertyExifDictionary]mutableCopy];
    NSMutableDictionary *IPTCDictionary = [[metadataAsMutable objectForKey:(NSString *)kCGImagePropertyIPTCDictionary]mutableCopy];
    

    
    self.scrollView.contentMode = UIViewContentModeScaleAspectFill;
    self.scrollView.contentOffset = CGPointZero;
    self.scrollView.contentInset = UIEdgeInsetsZero;

    [self.scrollView addSubview:self.imageView];
    
  
    self.scrollView.contentSize = self.imageView.frame.size;
    
    [self configureZoomScale];
    
//    UIView *subView = [self.scrollView.subviews objectAtIndex:0];
//    
//    CGFloat offsetX = MAX((self.scrollView.bounds.size.width - self.scrollView.contentSize.width) * 0.5, 0.0);
//    CGFloat offsetY = MAX((self.scrollView.bounds.size.height - self.scrollView.contentSize.height) * 0.5, 0.0);
//    
//    subView.center = CGPointMake(self.scrollView.contentSize.width * 0.5 + offsetX,
//                                 self.scrollView.contentSize.height * 0.5 + offsetY);
    
    [self.imagePickerController dismissViewControllerAnimated:YES completion:^{
        [self.navigationController.navigationBar setHidden:NO];
    }];
}


- (void) logMetaDataFromImage:(UIImage*)image {
    NSDictionary *iptc = @{
                           (NSString *)kCGImagePropertyIPTCObjectTypeReference : @"kCGImagePropertyIPTCObjectTypeReference",
                           (NSString *)kCGImagePropertyIPTCObjectAttributeReference : @"kCGImagePropertyIPTCObjectAttributeReference",
                           (NSString *)kCGImagePropertyIPTCObjectName : @"kCGImagePropertyIPTCObjectName",
                           (NSString *)kCGImagePropertyIPTCEditStatus : @"kCGImagePropertyIPTCEditStatus",
                           (NSString *)kCGImagePropertyIPTCEditorialUpdate : @"kCGImagePropertyIPTCEditorialUpdate",
                           (NSString *)kCGImagePropertyIPTCUrgency : @"kCGImagePropertyIPTCUrgency",
                           (NSString *)kCGImagePropertyIPTCSubjectReference : @"kCGImagePropertyIPTCSubjectReference",
                           (NSString *)kCGImagePropertyIPTCCategory : @"kCGImagePropertyIPTCCategory",
                           (NSString *)kCGImagePropertyIPTCSupplementalCategory : @"kCGImagePropertyIPTCSupplementalCategory",
                           (NSString *)kCGImagePropertyIPTCFixtureIdentifier : @"kCGImagePropertyIPTCFixtureIdentifier",
                           (NSString *)kCGImagePropertyIPTCKeywords : @"kCGImagePropertyIPTCKeywords",
                           (NSString *)kCGImagePropertyIPTCContentLocationCode : @"kCGImagePropertyIPTCContentLocationCode",
                           (NSString *)kCGImagePropertyIPTCContentLocationName : @"kCGImagePropertyIPTCContentLocationName",
                           (NSString *)kCGImagePropertyIPTCReleaseDate : @"kCGImagePropertyIPTCReleaseDate",
                           (NSString *)kCGImagePropertyIPTCReleaseTime : @"kCGImagePropertyIPTCReleaseTime",
                           (NSString *)kCGImagePropertyIPTCExpirationDate : @"kCGImagePropertyIPTCExpirationDate",
                           (NSString *)kCGImagePropertyIPTCExpirationTime : @"kCGImagePropertyIPTCExpirationTime",
                           (NSString *)kCGImagePropertyIPTCSpecialInstructions : @"kCGImagePropertyIPTCSpecialInstructions",
                           (NSString *)kCGImagePropertyIPTCActionAdvised : @"kCGImagePropertyIPTCActionAdvised",
                           (NSString *)kCGImagePropertyIPTCReferenceService : @"kCGImagePropertyIPTCReferenceService",
                           (NSString *)kCGImagePropertyIPTCReferenceDate : @"kCGImagePropertyIPTCReferenceDate",
                           (NSString *)kCGImagePropertyIPTCReferenceNumber : @"kCGImagePropertyIPTCReferenceNumber",
                           (NSString *)kCGImagePropertyIPTCDateCreated : @"kCGImagePropertyIPTCDateCreated",
                           (NSString *)kCGImagePropertyIPTCTimeCreated : @"kCGImagePropertyIPTCTimeCreated",
                           (NSString *)kCGImagePropertyIPTCDigitalCreationDate : @"kCGImagePropertyIPTCDigitalCreationDate",
                           (NSString *)kCGImagePropertyIPTCDigitalCreationTime : @"kCGImagePropertyIPTCDigitalCreationTime",
//                           (NSString *)kCGImagePropertyIPTCOriginatingProgram : <CFBundleName>,
//                           (NSString *)kCGImagePropertyIPTCProgramVersion : <CFBundleVersion>,
                           (NSString *)kCGImagePropertyIPTCObjectCycle : @"kCGImagePropertyIPTCObjectCycle",
                           (NSString *)kCGImagePropertyIPTCByline : @"kCGImagePropertyIPTCByline",
                           (NSString *)kCGImagePropertyIPTCBylineTitle : @"kCGImagePropertyIPTCBylineTitle",
                           (NSString *)kCGImagePropertyIPTCCity : @"kCGImagePropertyIPTCCity",
                           (NSString *)kCGImagePropertyIPTCSubLocation : @"kCGImagePropertyIPTCSubLocation",
                           (NSString *)kCGImagePropertyIPTCProvinceState : @"kCGImagePropertyIPTCProvinceState",
                           (NSString *)kCGImagePropertyIPTCCountryPrimaryLocationCode : @"kCGImagePropertyIPTCCountryPrimaryLocationCode",
                           (NSString *)kCGImagePropertyIPTCCountryPrimaryLocationName : @"kCGImagePropertyIPTCCountryPrimaryLocationName",
                           (NSString *)kCGImagePropertyIPTCOriginalTransmissionReference : @"kCGImagePropertyIPTCOriginalTransmissionReference",
                           //    (NSString *)kCGImagePropertyIPTCHeadline: : @"kCGImagePropertyIPTCHeadline",
                           (NSString *)kCGImagePropertyIPTCCredit : @"kCGImagePropertyIPTCCredit",
                           (NSString *)kCGImagePropertyIPTCSource : @"kCGImagePropertyIPTCSource",
                           (NSString *)kCGImagePropertyIPTCCopyrightNotice : @"kCGImagePropertyIPTCCopyrightNotice",
                           (NSString *)kCGImagePropertyIPTCContact : @"kCGImagePropertyIPTCContact",
                           (NSString *)kCGImagePropertyIPTCCaptionAbstract : @"kCGImagePropertyIPTCCaptionAbstract",
                           (NSString *)kCGImagePropertyIPTCWriterEditor : @"kCGImagePropertyIPTCWriterEditor",
                           (NSString *)kCGImagePropertyIPTCImageType : @"kCGImagePropertyIPTCImageType",
                           (NSString *)kCGImagePropertyIPTCImageOrientation : @"kCGImagePropertyIPTCImageOrientation",
                           (NSString *)kCGImagePropertyIPTCLanguageIdentifier : @"kCGImagePropertyIPTCLanguageIdentifier",
                           (NSString *)kCGImagePropertyIPTCStarRating : @"kCGImagePropertyIPTCStarRating",
                           (NSString *)kCGImagePropertyIPTCCreatorContactInfo : @"kCGImagePropertyIPTCCreatorContactInfo",
                           (NSString *)kCGImagePropertyIPTCRightsUsageTerms : @"kCGImagePropertyIPTCRightsUsageTerms",
                           (NSString *)kCGImagePropertyIPTCScene : @"kCGImagePropertyIPTCScene",
                           (NSString *)kCGImagePropertyIPTCContactInfoCity : @"kCGImagePropertyIPTCContactInfoCity",
                           (NSString *)kCGImagePropertyIPTCContactInfoCountry : @"kCGImagePropertyIPTCContactInfoCountry",
                           (NSString *)kCGImagePropertyIPTCContactInfoAddress : @"kCGImagePropertyIPTCContactInfoAddress",
                           (NSString *)kCGImagePropertyIPTCContactInfoPostalCode : @"kCGImagePropertyIPTCContactInfoPostalCode",
                           (NSString *)kCGImagePropertyIPTCContactInfoStateProvince : @"kCGImagePropertyIPTCContactInfoStateProvince",
                           (NSString *)kCGImagePropertyIPTCContactInfoEmails : @"kCGImagePropertyIPTCContactInfoEmails",
                           (NSString *)kCGImagePropertyIPTCContactInfoPhones : @"kCGImagePropertyIPTCContactInfoPhones",
                           (NSString *)kCGImagePropertyIPTCContactInfoWebURLs : @"kCGImagePropertyIPTCContactInfoWebURLs" };
    
    
    NSMutableDictionary *d = [NSMutableDictionary dictionary];
    d[(NSString *)kCGImagePropertyIPTCDictionary] = iptc;
    CFDictionaryRef iptcdic = (__bridge CFDictionaryRef)(d);
    
    
    
    
    NSLog(@" %@",NSStringFromSelector(_cmd));
    NSData *jpegData = UIImageJPEGRepresentation(image, 1.0);
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)jpegData, NULL);
    CFDictionaryRef imageMetaData = CGImageSourceCopyPropertiesAtIndex(source,0,iptcdic);
    NSLog (@"%@",imageMetaData);
}


- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGSize boundsSize = scrollView.bounds.size;
    CGRect frameToCenter = self.imageView.frame;
    
    // center horizontally
    if (frameToCenter.size.width < boundsSize.width)
    {
        frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2;
    } else {
        frameToCenter.origin.x = 0;
    }
    
    // center vertically
    if (frameToCenter.size.height < boundsSize.height)
    {
        frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2;
    } else {
        frameToCenter.origin.y = 0;
    }
    
    self.imageView.frame = frameToCenter;
}


-(UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (BOOL) continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    return YES;
}

- (void)sliderValueChanged:(id)sender{
//    [self updateDataView];
    
    [self sliderValueChanged];
}




//Call this method on Slider value change event

-(void)sliderValueChanged {
    UIImageView *handleView = [self.slider.subviews lastObject];
    [handleView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    UILabel *label = [[UILabel alloc] initWithFrame:handleView.bounds];
    label.text = [NSString stringWithFormat:@"%0.0f", self.slider.value];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    [handleView addSubview:label];
    
    [self.slider setGradientBackgroundWithColors:[NSArray arrayWithObjects:
                                                  (id)[[UIColor colorWithRed:235.0/255.0 green:135.0/255.0 blue:57.0/255.0 alpha:1.0] CGColor],
                                                  (id)[[UIColor colorWithRed:235.0/255.0 green:128.0/255.0 blue:60.0/255.0 alpha:1.0] CGColor],
                                                  (id)[[UIColor colorWithRed:235.0/255.0 green:121.0/255.0 blue:64.0/255.0 alpha:1.0] CGColor],
                                                  (id)[[UIColor colorWithRed:235.0/255.0 green:115.0/255.0 blue:68.0/255.0 alpha:1.0] CGColor],
                                                  (id)[[UIColor colorWithRed:235.0/255.0 green:108.0/255.0 blue:71.0/255.0 alpha:1.0] CGColor],
                                                  
                                                  (id)[[UIColor colorWithRed:235.0/255.0 green:102.0/255.0 blue:75.0/255.0 alpha:1.0] CGColor],
                                                  (id)[[UIColor colorWithRed:235.0/255.0 green:95.0/255.0 blue:79.0/255.0 alpha:1.0] CGColor],
                                                  (id)[[UIColor colorWithRed:235.0/255.0 green:89.0/255.0 blue:82.0/255.0 alpha:1.0] CGColor],
                                                  (id)[[UIColor colorWithRed:235.0/255.0 green:82.0/255.0 blue:86.0/255.0 alpha:1.0] CGColor],
                                                  (id)[[UIColor colorWithRed:235.0/255.0 green:76.0/255.0 blue:90.0/255.0 alpha:1.0] CGColor],
                                                  nil]];
    
}

@end
