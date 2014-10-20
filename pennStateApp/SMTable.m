//
//  SMTable.m
//  pennStateApp
//
//  Created by Nick Woodward on 10/12/14.
//  Copyright (c) 2014 softwaremerchant. All rights reserved.
//

#import "SMTable.h"
#import "SMPDFViewer.h"

@interface SMTable ()

@end

@implementation SMTable{
    MPMoviePlayerController *mpc;
    UIImage *cellImg;
    NSURL *url;
    NSURL *pdfURL;
    NSMutableArray *tableArray;
    NSMutableDictionary *corporateDict;
    NSDictionary *tableDict;
    SMPDFViewer *destination;
    NSArray *sectionHeaders;
    NSMutableArray *sectionCounts;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    if([self.navigationItem.title isEqualToString:@"Tutorials"]){
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Tutorials" ofType:@"plist"];
        tableArray = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    }
    else if([self.navigationItem.title isEqualToString:@"Corporate Resources"]){
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"CorporateResources" ofType:@"plist"];
        tableDict = [[NSDictionary alloc] initWithContentsOfFile:filePath];
        tableArray = [NSMutableArray new];
        sectionCounts = [[NSMutableArray alloc]init];
        corporateDict = [NSMutableDictionary new];
        sectionHeaders = [tableDict allKeys];
        
        for(int i =0;i<[sectionHeaders count];i++){
            NSDictionary *dict = tableDict[sectionHeaders[i]];
            NSArray *tableElements = [dict allKeys];
            NSInteger temp = [tableElements count];
            [sectionCounts addObject:[[NSNumber alloc]initWithInteger:temp]];
            [corporateDict addEntriesFromDictionary:dict];
            for(int j=0;j<[tableElements count];j++){
                [tableArray addObject:tableElements[j]];
            }
            
        }
    }
    else{
        tableArray = [[NSMutableArray alloc]initWithObjects:@"Syllabus",@"Homework 1",@"Homework 2",@"Homework 3", nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    destination = [segue destinationViewController];
    //NSURL *url2 = [NSURL URLWithString:@"http://www.softwaremerchant.com/welcomepacket/W-4%202014.pdf"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    if([self.navigationItem.title isEqualToString:@"Corporate Resources"]){
        return [sectionHeaders count];
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if([self.navigationItem.title isEqualToString:@"Corporate Resources"]){
        NSNumber *num = sectionCounts[section];
        return [num integerValue];
    }
    return [tableArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    if([self.navigationItem.title isEqualToString:@"Tutorials"]){
        cell = [tableView dequeueReusableCellWithIdentifier:@"tutorial" forIndexPath:indexPath];
        UILabel *cellLabel = (UILabel*)[cell.contentView viewWithTag:1];
        
        NSDictionary *cellUrlPair = tableArray[indexPath.row];
        NSArray *key = [cellUrlPair allKeys];
        cellLabel.text = key[0];
        return cell;

    }
    else if([self.navigationItem.title isEqualToString:@"Corporate Resources"]){
        cell = [tableView dequeueReusableCellWithIdentifier:@"other" forIndexPath:indexPath];
        UILabel *cellLabel = (UILabel*)[cell.contentView viewWithTag:1];
        int offset = 0;
        for(int i=0;i<indexPath.section;i++){
            NSNumber *num = sectionCounts[i];
            offset = offset + [num intValue];
        }
        //NSLog(@"%ld",(long)indexPath.section);
        cellLabel.text = tableArray[indexPath.row+offset];
    }
    else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"course" forIndexPath:indexPath];
        UILabel *cellLabel = (UILabel*)[cell.contentView viewWithTag:1];
        cellLabel.text = tableArray[indexPath.row];
    }
    
    
    return cell;

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [sectionHeaders objectAtIndex:section];
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self.navigationItem.title isEqualToString:@"Tutorials"]){
        return 90.0;
    }
    else{
        return 60.0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Selected");
    if([self.navigationItem.title isEqualToString:@"Tutorials"]){
        NSDictionary *cellUrlPair = tableArray[indexPath.row];
        NSArray *key = [cellUrlPair allKeys];
        
        url=[NSURL URLWithString:cellUrlPair[key[0]]];
        mpc = [[MPMoviePlayerController alloc] initWithContentURL:url];
        
        [mpc.view setFrame:CGRectMake(10,10,0.0,0.0)];
        [self.view addSubview:mpc.view];
        [mpc setScalingMode:MPMovieScalingModeAspectFit];
        mpc.movieSourceType = MPMovieSourceTypeStreaming;
        mpc.controlStyle = MPMovieControlStyleNone;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MPMoviePlayerDidExitFullscreen:) name:MPMoviePlayerDidExitFullscreenNotification object:nil];

        [mpc play];
        mpc.controlStyle = MPMovieControlStyleFullscreen;
        mpc.fullscreen = YES;
    }
    else if([self.navigationItem.title isEqualToString:@"Corporate Resources"]){
        int offset = 0;
        for(int i=0;i<indexPath.section;i++){
            NSNumber *num = sectionCounts[i];
            offset = offset + [num intValue];
        }
        pdfURL = [NSURL URLWithString:corporateDict[tableArray[indexPath.row+offset]]];
    }
    else{
        pdfURL = [NSURL URLWithString:corporateDict[tableArray[indexPath.row]]];
    }
    destination.url = pdfURL;
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
