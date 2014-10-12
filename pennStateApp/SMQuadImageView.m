//
//  SMQuadImageView.m
//  pennStateApp
//
//  Created by Nick Woodward on 10/12/14.
//  Copyright (c) 2014 softwaremerchant. All rights reserved.
//

#import "SMQuadImageView.h"
#import "ViewController.h"
@implementation SMQuadImageView

/*- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageNamed:@"whitekey.gif"];
    }
    return self;
}*/
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"Touched");
    ViewController *vc = (ViewController *)self.nextResponder.nextResponder.nextResponder;
    [vc imageTouched:self];
}
@end
