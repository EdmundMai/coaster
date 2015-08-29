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
//    NSLog(@"image = %@", self.coasterImage.image);
    
//    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"table"]];
//    [self.view addSubview:backgroundView];

    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"table"]]];
    
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", self.imageName]];
    CGRect bounds;
    bounds.origin = CGPointZero;
    bounds.size = image.size;
    
    self.coasterImage.bounds = bounds;
    self.coasterImage.image = image;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.coasterImage;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
