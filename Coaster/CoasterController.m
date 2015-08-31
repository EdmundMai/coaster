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

@end

@implementation CoasterController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateCoasterImage:@"goldencoaster"];
    
    UITapGestureRecognizer *imageTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped)];
    imageTapRecognizer.numberOfTapsRequired = 2;
    [self.coasterImage addGestureRecognizer:imageTapRecognizer];
    
    UITapGestureRecognizer *backgroundTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTapped)];
    backgroundTapRecognizer.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:backgroundTapRecognizer];
}

- (void) backgroundTapped {
    NSLog(@"cool");
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"table-2"]]];
}

- (void)imageTapped {
    [self updateCoasterImage:@"blackcoaster"];
}

- (void)updateCoasterImage:(NSString *)imageName {
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"table"]]];
    
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", imageName]];
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGRect bounds = CGRectMake(screen.origin.x+10,
                               screen.origin.y+10,
                               screen.size.width-10,
                               screen.size.width-10);
    
    self.coasterImage.frame = bounds;
    self.coasterImage.image = image;
    self.coasterImage.center = self.coasterImage.superview.center;
}

@end
