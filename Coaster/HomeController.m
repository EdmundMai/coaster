//
//  HomeController.m
//  Coaster
//
//  Created by Edmund Mai on 8/28/15.
//  Copyright (c) 2015 Edmund Mai. All rights reserved.
//

#import "HomeController.h"
#import "CoasterController.h"

@interface HomeController ()

@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    CoasterController *dvc = (CoasterController *)segue.destinationViewController;
    dvc.imageName = segue.identifier;
}

@end
