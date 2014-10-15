//
//  SMStartPage.m
//  Course Companion
//
//  Created by Nick Woodward on 10/15/14.
//  Copyright (c) 2014 softwaremerchant. All rights reserved.
//

#import "SMStartPage.h"
#import "ViewController.h"

@interface SMStartPage (){
    NSArray *classNames;
    ViewController *vc;
}

@end

@implementation SMStartPage

- (void)viewDidLoad {
    [super viewDidLoad];
    classNames = [[NSArray alloc]initWithObjects:@"3XX",@"3XX",@"4XX", nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    vc = (ViewController *)[segue  destinationViewController];
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    vc.className = classNames[indexPath.row];
    
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
