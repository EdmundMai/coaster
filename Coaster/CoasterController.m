//
//  CoasterController.m
//  
//
//  Created by Edmund Mai on 8/28/15.
//
//

#import "CoasterController.h"
#import <iAd/iAd.h>
@import GoogleMobileAds;

@interface CoasterController ()  <ADBannerViewDelegate, GADBannerViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *coasterImage;
@property (assign, nonatomic) NSInteger imageIndex;

@property (weak, nonatomic) IBOutlet UIButton *settingsButton;
@property (weak, nonatomic) IBOutlet UIView *instructionsContainer;

@property (strong, nonatomic) ADBannerView *adBanner;
@property (strong, nonatomic) GADBannerView *gadBanner;

@end

@implementation CoasterController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.instructionsContainer.hidden = YES;

    UITapGestureRecognizer *screenTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(screenTapped)];
    [self.view addGestureRecognizer:screenTapRecognizer];
    
    [self nextImage];

    UISwipeGestureRecognizer *imageSwipeLeftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(nextImage)];
    imageSwipeLeftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.coasterImage addGestureRecognizer:imageSwipeLeftRecognizer];
    
    UISwipeGestureRecognizer *imageSwipeRightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(previousImage)];
    imageSwipeRightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.coasterImage addGestureRecognizer:imageSwipeRightRecognizer];
    
    [self initIadBanner];
    [self initGadBanner];
}

- (IBAction)settingsButtonClicked:(id)sender {
    if (self.instructionsContainer.hidden) {
        self.instructionsContainer.hidden = NO;
    } else {
        self.instructionsContainer.hidden = YES;
    }
}

- (void) screenTapped {
    self.instructionsContainer.hidden = YES;
}

- (NSArray *)images {
    return @[@"rope", @"white", @"wood", @"red-1"];
}

- (void)previousImage {
    self.instructionsContainer.hidden = YES;
    
    if (self.imageIndex == 0) {
        self.imageIndex = [self.images count] - 1;
    } else {
        self.imageIndex--;
    }
    
    [self updateCoasterImage:[self.images objectAtIndex:self.imageIndex]];
}

- (void)nextImage {
    self.instructionsContainer.hidden = YES;
    
    if (self.imageIndex == [self.images count] - 1) {
        self.imageIndex = 0;
    } else {
        self.imageIndex++;
    }
    
    [self updateCoasterImage:[self.images objectAtIndex:self.imageIndex]];
}

- (void)updateCoasterImage:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", imageName]];

    self.coasterImage.image = image;
    self.coasterImage.center = self.coasterImage.superview.center;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}

- (void)initIadBanner {
    self.adBanner = [[ADBannerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, 0, 0)];
    self.adBanner.delegate = self;
    self.adBanner.hidden = YES;
    [self.view addSubview:self.adBanner];
}

- (void)initGadBanner {
    self.gadBanner = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait
                                                    origin:CGPointMake(0, self.view.frame.size.height)];

    self.gadBanner.adUnitID = @"ca-app-pub-5251476832975034/4401427149";
    self.gadBanner.rootViewController = self;
    self.gadBanner.delegate = self;
    self.gadBanner.hidden = YES;
    [self.view addSubview:self.gadBanner];
}

- (void)showBanner:(UIView *)banner {
    if (banner && [banner isHidden]) {
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        banner.frame = CGRectOffset(banner.frame, 0, -banner.frame.size.height);
        [UIView commitAnimations];
        banner.hidden = NO;
    }
}

- (void)hideBanner:(UIView *)banner {
    if (banner && ![banner isHidden]) {
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        banner.frame = CGRectOffset(banner.frame, 0, banner.frame.size.height);
        [UIView commitAnimations];
        banner.hidden = YES;
    }
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    [self hideBanner:self.gadBanner];
    [self showBanner:self.adBanner];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    [self hideBanner:banner];
    [self.gadBanner loadRequest:[GADRequest request]];
}

- (void)adViewDidReceiveAd:(GADBannerView *)bannerView {
    [self hideBanner:self.adBanner];
    [self showBanner:self.gadBanner];
}

- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error {
    [self hideBanner:self.gadBanner];
}

@end
