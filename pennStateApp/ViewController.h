//
//  ViewController.h
//  pennStateApp
//
//  Created by Nick Woodward on 10/8/14.
//  Copyright (c) 2014 softwaremerchant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMQuadImageView.h"

@interface ViewController : UIViewController
- (void)imageTouched:(SMQuadImageView*)qiv;
@property (weak, nonatomic) IBOutlet UILabel *lblClassName;

@property (strong, nonatomic) IBOutletCollection(SMQuadImageView) NSArray *quadImages;
- (IBAction)quadButtonPressed:(UIButton *)sender;
@property NSString *className;
@end

