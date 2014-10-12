//
//  SMTable.m
//  pennStateApp
//
//  Created by Nick Woodward on 10/12/14.
//  Copyright (c) 2014 softwaremerchant. All rights reserved.
//

#import "SMTable.h"

@interface SMTable ()

@end

@implementation SMTable{
    MPMoviePlayerController *mpc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.navigationItem.title = @"TESTING 345";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tutorial" forIndexPath:indexPath];
    
    cell.textLabel.text = @"Example video";
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Selected");
    NSURL *url=[NSURL URLWithString:@"http://www.softwaremerchant.com/stream/chapter3/prog_index.m3u8"];
    mpc = [[MPMoviePlayerController alloc] initWithContentURL:url];
    [mpc.view setFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
    
    
    [self.view addSubview:mpc.view];
    //[MPMoviePlayerController setScalingMode:MPMovieScalingModeFill];
    [mpc setScalingMode:MPMovieScalingModeAspectFit];
    
    //mpc.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    mpc.movieSourceType = MPMovieSourceTypeStreaming;
    mpc.controlStyle = MPMovieControlStyleNone;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MPMoviePlayerDidExitFullscreen:) name:MPMoviePlayerDidExitFullscreenNotification object:nil];

    [mpc play];
    mpc.controlStyle = MPMovieControlStyleFullscreen;
    mpc.fullscreen = YES;
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.mov];
}


- (void)MPMoviePlayerDidExitFullscreen:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerDidExitFullscreenNotification
                                                  object:nil];
    
    [mpc stop];
    [mpc.view removeFromSuperview];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
