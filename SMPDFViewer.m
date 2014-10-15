//
//  SMPDFViewer.m
//  pennStateApp
//
//  Created by Nick Woodward on 10/13/14.
//  Copyright (c) 2014 softwaremerchant. All rights reserved.
//

#import "SMPDFViewer.h"

@interface SMPDFViewer ()

@end

@implementation SMPDFViewer

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    [self.wvPDF loadRequest:request];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
