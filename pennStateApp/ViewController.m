//
//  ViewController.m
//  pennStateApp
//
//  Created by Nick Woodward on 10/8/14.
//  Copyright (c) 2014 softwaremerchant. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (UIImageView *iv in self.quadImages) {
        iv.userInteractionEnabled = YES;
    }

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    SMQuadImageView *myQIV = sender;
    UITableViewController *tvc = segue.destinationViewController;
    if(myQIV.tag == 1){
        tvc.navigationItem.title = @"Tutorials";
    }
    else if(myQIV.tag == 2){
        tvc.navigationItem.title = @"Course Materials";
    }
    else{
        tvc.navigationItem.title = @"Corporate Resources";
    }
}
- (void)imageTouched:(SMQuadImageView*)qiv{
    //NSLog(@"imageTouched");
    //NSLog(@"%i",qiv.tag);
    if(qiv.tag!=4){
        [self performSegueWithIdentifier:@"toTable" sender:qiv];
    }
}

@end
