//
//  CoasterController.m
//  
//
//  Created by Edmund Mai on 8/28/15.
//
//

#import "CoasterController.h"

@interface CoasterController ()

@property (weak, nonatomic) IBOutlet UIImageView *coasterImage;
@property (assign, nonatomic) BOOL bannerIsVisible;
@property (strong, nonatomic) ADBannerView *adBanner;
@property (weak, nonatomic) IBOutlet UIButton *settingsButton;
@property (weak, nonatomic) IBOutlet UILabel *instructionsLabel;
@property (assign, nonatomic) NSInteger imageIndex;

@end

@implementation CoasterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.instructionsLabel.hidden = YES;
    
    UITapGestureRecognizer *screenTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(screenTapped)];
    [self.view addGestureRecognizer:screenTapRecognizer];
    
    [self nextImage];

    UISwipeGestureRecognizer *imageSwipeLeftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(nextImage)];
    imageSwipeLeftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.coasterImage addGestureRecognizer:imageSwipeLeftRecognizer];
    
    UISwipeGestureRecognizer *imageSwipeRightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(previousImage)];
    imageSwipeRightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.coasterImage addGestureRecognizer:imageSwipeRightRecognizer];
    
    UIImage *settingsIcon = [UIImage imageNamed:@"settings"];
    [self.settingsButton setImage:settingsIcon forState:UIControlStateNormal];
    
    self.adBanner = [[ADBannerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 50, 320, 50)];
    self.adBanner.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
}

- (IBAction)settingsButtonClicked:(id)sender {
    if (self.instructionsLabel.hidden) {
        self.instructionsLabel.hidden = NO;
    } else {
        self.instructionsLabel.hidden = YES;
    }
}

- (void) screenTapped {
    self.instructionsLabel.hidden = YES;
}

- (void)previousImage {
    self.instructionsLabel.hidden = YES;
    NSArray *images = @[@"whitecoaster", @"wood-5", @"red-1"];
    
    if (!self.imageIndex) {
        self.imageIndex = 0;
    }
    [self updateCoasterImage:[images objectAtIndex:self.imageIndex]];
    
    if (self.imageIndex == 0) {
        self.imageIndex = [images count] - 1;
    } else {
        self.imageIndex--;
    }
    NSLog(@"Previous image: index is: %ld", self.imageIndex);
}

- (void)nextImage {
    self.instructionsLabel.hidden = YES;
    NSArray *images = @[@"whitecoaster", @"wood-5", @"red-1"];
    if (!self.imageIndex) {
        self.imageIndex = 0;
    }

    [self updateCoasterImage:[images objectAtIndex:self.imageIndex]];
    
    if (self.imageIndex == [images count] - 1) {
        self.imageIndex = 0;
    } else {
        self.imageIndex++;
    }
    NSLog(@"Next image: index is: %ld", self.imageIndex);
}

- (void)updateCoasterImage:(NSString *)imageName {
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"table"]]];
    
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", imageName]];
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGRect bounds = CGRectMake(screen.origin.x,
                               screen.origin.y,
                               screen.size.width * 1.4,
                               screen.size.height * 1.2);
    
    self.coasterImage.frame = bounds;
    self.coasterImage.image = image;
    self.coasterImage.center = self.coasterImage.superview.center;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    if (!self.bannerIsVisible) {
        if (!self.adBanner.superview) {
            [self.view addSubview:self.adBanner];
        }
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        [UIView commitAnimations];
        self.bannerIsVisible = YES;
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    NSLog(@"Failed!!");
    [self.adBanner removeFromSuperview];
    [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
    [UIView commitAnimations];
    self.bannerIsVisible = NO;
}

@end
