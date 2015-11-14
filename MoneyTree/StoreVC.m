//
//  StoreVC.m
//  MoneyTree
//
//  Created by Student on 12/2/14.
//  Copyright (c) 2014 Eric Fonseca. All rights reserved.
//

#import "StoreVC.h"

@interface StoreVC ()

@end

@implementation StoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //update the cash label 20 times per second
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.05
                                     target:self
                                   selector:@selector(addCashPerSecond)
                                   userInfo:nil
                                    repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    treeItems = [NSArray arrayWithObjects:@"Jefferson Tree\n$0.05 / harvest", @"Roosevelt Tree\n$0.10 / harvest", @"Washington Tree\n$0.25 / harvest", @"Elder Washington Tree\n$1.00 / harvest", @"Lincoln Tree\n$5.00 / harvest", @"Hamilton Tree\n$10.00 / harvest", @"Jackson Tree\n$20.00 / harvest", @"Grant Tree\n$50.00 / harvest", @"Benjamin Tree\n$100.00 / harvest", nil];
    
    treePrices = [NSMutableArray arrayWithObjects:@"$1.00", @"$5.00", @"$10.00", @"$25.00", @"$100.00", @"$500.00", @"$1000.00", @"$2000.00", @"$5000.00", nil];
    
    productionItems = [NSArray arrayWithObjects:@"Neighbor's Kid\n$0.05 / second", @"Gardener\n$0.25 / second", @"Landscaper\n$1.00 / second", @"Lumberjack\n$2.50 / second", @"Farmer\n$5.00 / second", @"Cut-O-Tron Robot\n$20.00 / second", @"Alien Harvester\n$100.00 / second", nil];
    
    productionPrices = [NSMutableArray arrayWithObjects:@"$0.50", @"$2.50", @"$10.00", @"$25.00", @"$50.00", @"$200.00", @"$1000.00", nil];
    
    savedWorkerPrices = [NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"$%.2f", [[Garden sharedInstance] worker1Price]], [NSString stringWithFormat:@"$%.2f", [[Garden sharedInstance] worker2Price]], [NSString stringWithFormat:@"$%.2f", [[Garden sharedInstance] worker3Price]], [NSString stringWithFormat:@"$%.2f", [[Garden sharedInstance] worker4Price]], [NSString stringWithFormat:@"$%.2f", [[Garden sharedInstance] worker5Price]], [NSString stringWithFormat:@"$%.2f", [[Garden sharedInstance] worker6Price]], [NSString stringWithFormat:@"$%.2f", [[Garden sharedInstance] worker7Price]], nil];
    
    //if there are no saved worker prices (new game) then update the singleton with the current values
    if([[Garden sharedInstance] worker1Price] == 0){
        [[Garden sharedInstance] setWorker1Price:[[productionPrices[0] substringFromIndex:1] floatValue]];
        [[Garden sharedInstance] setWorker2Price:[[productionPrices[1] substringFromIndex:1] floatValue]];
        [[Garden sharedInstance] setWorker3Price:[[productionPrices[2] substringFromIndex:1] floatValue]];
        [[Garden sharedInstance] setWorker4Price:[[productionPrices[3] substringFromIndex:1] floatValue]];
        [[Garden sharedInstance] setWorker5Price:[[productionPrices[4] substringFromIndex:1] floatValue]];
        [[Garden sharedInstance] setWorker6Price:[[productionPrices[5] substringFromIndex:1] floatValue]];
        [[Garden sharedInstance] setWorker7Price:[[productionPrices[6] substringFromIndex:1] floatValue]];
    }
    
    //update the worker prices based on the saved prices in the singleton
    else{
        for(int i = 0; i < 7; i++){
            productionPrices[i] = savedWorkerPrices[i];
        }
    }
}

//update cash label when switching to this tab
- (void)viewDidAppear:(BOOL)animated {
    self.cashLabel.text = [NSString stringWithFormat:@"$%.2f", [[Garden sharedInstance] totalCash]];
}

//update the cash label based on the timer
-(void)addCashPerSecond {
    self.cashLabel.text = [NSString stringWithFormat:@"$%.2f", [[Garden sharedInstance] totalCash]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    cell = [tableView dequeueReusableCellWithIdentifier:@"TableCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TableCell"];
    }
    cell.textLabel.numberOfLines = 0; //enable multiple lines
    
    //populate cells with text
    if(indexPath.section == 0){
        cell.textLabel.text = [treeItems objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [treePrices objectAtIndex:indexPath.row];
    }
    else{
        cell.textLabel.text = [productionItems objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [productionPrices objectAtIndex:indexPath.row];
    }
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 60, 0);
    
    //change background color of cells
    if(indexPath.row % 2){
        UIColor *cellColor = [UIColor colorWithRed:0.96 green:0.97 blue:0.99 alpha:1.0];
        cell.textLabel.backgroundColor = cellColor;
        cell.detailTextLabel.backgroundColor = cellColor;
        cell.contentView.backgroundColor = cellColor;
    }
    else{
        UIColor *cellColor2 = [UIColor colorWithRed:0.89 green:0.93 blue:0.98 alpha:1.0];
        cell.textLabel.backgroundColor = cellColor2;
        cell.detailTextLabel.backgroundColor = cellColor2;
        cell.contentView.backgroundColor = cellColor2;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    cell = [tableView cellForRowAtIndexPath:indexPath];
    if(indexPath.section == 0){
        if (indexPath.row == 0){
            [self treePurchased:1 treeCost:1.00 cashMultiplier:0.05];
        }
        if (indexPath.row == 1){
            [self treePurchased:2 treeCost:5.00 cashMultiplier:0.10];
        }
        if (indexPath.row == 2){
            [self treePurchased:3 treeCost:10.00 cashMultiplier:0.25];
        }
        if (indexPath.row == 3){
            [self treePurchased:4 treeCost:25.00 cashMultiplier:1.00];
        }
        if (indexPath.row == 4){
            [self treePurchased:5 treeCost:100.00 cashMultiplier:5.00];
        }
        if (indexPath.row == 5){
            [self treePurchased:6 treeCost:500.00 cashMultiplier:10.00];
        }
        if (indexPath.row == 6){
            [self treePurchased:7 treeCost:1000.00 cashMultiplier:20.00];
        }
        if (indexPath.row == 7){
            [self treePurchased:8 treeCost:2000.00 cashMultiplier:50.00];
        }
        if (indexPath.row == 8){
            [self treePurchased:9 treeCost:5000.00 cashMultiplier:100.00];
        }
    }
    else{
        if (indexPath.row == 0){
            [self workerPurchased:0 selectedCell:cell cashPerSecond:0.05];
        }
        if (indexPath.row == 1){
            [self workerPurchased:1 selectedCell:cell cashPerSecond:0.25];
        }
        if (indexPath.row == 2){
            [self workerPurchased:2 selectedCell:cell cashPerSecond:1.00];
        }
        if (indexPath.row == 3){
            [self workerPurchased:3 selectedCell:cell cashPerSecond:2.50];
        }
        if (indexPath.row == 4){
            [self workerPurchased:4 selectedCell:cell cashPerSecond:5.00];
        }
        if (indexPath.row == 5){
            [self workerPurchased:5 selectedCell:cell cashPerSecond:20.00];
        }
        if (indexPath.row == 6){
            [self workerPurchased:6 selectedCell:cell cashPerSecond:100.00];
        }
        
    }
    //animate selection
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)treePurchased:(int)image treeCost:(float)price cashMultiplier:(float)multiplier{
    //display a message and prevent the user from purchasing a tree if they have a better one
    if(image < [[Garden sharedInstance] treeImage]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Purchase Failed"
                                                        message:@"You already have a better tree!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    //display a message and prevent the user from purchasing a tree if they have the same one
    else if(image == [[Garden sharedInstance] treeImage]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Purchase Failed"
                                                        message:@"You already own this tree!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    //purchase the tree if they have enough money
    else if([[Garden sharedInstance] totalCash] > price - 0.01){
        //subtract the price of the tree from the player's total cash
        [[Garden sharedInstance] setTotalCash:([[Garden sharedInstance] totalCash]-price)];
        
        //increase the amount of cash per harvest
        [[Garden sharedInstance] setCashMultiplier:multiplier];
        
        //change the image of the tree
        [[Garden sharedInstance] setTreeImage:image];
        
        //prevent the label from displaying a negative number (negative zero)
        if([[Garden sharedInstance] totalCash] < 0.01){
            [[Garden sharedInstance] setTotalCash:0.00];
        }
        
        //update the cash label
        self.cashLabel.text = [NSString stringWithFormat:@"$%.2f", [[Garden sharedInstance] totalCash]];
    }
    //display a message and prevent the user from purchasing a tree if they don't have enough money
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Purchase Failed"
                                                        message:@"You need more money to buy this tree!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

-(void)workerPurchased:(int)worker selectedCell:(UITableViewCell *)cellTapped cashPerSecond:(float)cps{
    //convert the current price from a string to a float
    float currentPrice = [[productionPrices[worker] substringFromIndex:1] floatValue];
    
    //purchase a worker if they have enough money
    if([[Garden sharedInstance] totalCash] > currentPrice - 0.01){
        //subtract the price of the tree from the player's total cash
        [[Garden sharedInstance] setTotalCash:([[Garden sharedInstance] totalCash]-currentPrice)];
        
        //increase the amount of cash per second
        [[Garden sharedInstance] setCashPerSecond:([[Garden sharedInstance] cashPerSecond]+cps)];
        
        //increase the price of the next purchase by 20%
        currentPrice *= 1.20;
        NSString *newPrice = [NSString stringWithFormat:@"$%.2f", currentPrice];
        productionPrices[worker] = newPrice;
        cellTapped.detailTextLabel.text = productionPrices[worker];
        
        //update the worker price properties in the singleton
        [self updateWorkerPrices];
        
        //prevent the label from displaying a negative number (negative zero)
        if([[Garden sharedInstance] totalCash] < 0.01){
            [[Garden sharedInstance] setTotalCash:0.00];
        }
        
        //update the cash label
        self.cashLabel.text = [NSString stringWithFormat:@"$%.2f", [[Garden sharedInstance] totalCash]];
    }
    
    //display a message and prevent the user from purchasing a tree if they don't have enough money
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Purchase Failed"
                                                        message:@"You need more money to buy this worker!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

//update the worker prices in the singleton
-(void)updateWorkerPrices{
    [[Garden sharedInstance] setWorker1Price:[[productionPrices[0] substringFromIndex:1] floatValue]];
    [[Garden sharedInstance] setWorker2Price:[[productionPrices[1] substringFromIndex:1] floatValue]];
    [[Garden sharedInstance] setWorker3Price:[[productionPrices[2] substringFromIndex:1] floatValue]];
    [[Garden sharedInstance] setWorker4Price:[[productionPrices[3] substringFromIndex:1] floatValue]];
    [[Garden sharedInstance] setWorker5Price:[[productionPrices[4] substringFromIndex:1] floatValue]];
    [[Garden sharedInstance] setWorker6Price:[[productionPrices[5] substringFromIndex:1] floatValue]];
    [[Garden sharedInstance] setWorker7Price:[[productionPrices[6] substringFromIndex:1] floatValue]];
}

//if the user presses the reset progress button, ask them to confirm
- (IBAction)resetPressed:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Are you sure?"
                                                   message: @"This will clear all saved progress. Tap reset to continue."
                                                  delegate: self
                                         cancelButtonTitle:@"Cancel"
                                         otherButtonTitles:@"Reset",nil];
    
    [alert setTag:1];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1) { //reset button
        if (buttonIndex == 1)
        {
            //clear all saved data
            [[Garden sharedInstance] setTotalCash:0.00];
            [[Garden sharedInstance] setTreeImage:0];
            [[Garden sharedInstance] setCashMultiplier:0.01];
            [[Garden sharedInstance] setCashPerSecond:0.00];
            [[Garden sharedInstance] setWorker1Price:0.50];
            [[Garden sharedInstance] setWorker2Price:2.50];
            [[Garden sharedInstance] setWorker3Price:10.00];
            [[Garden sharedInstance] setWorker4Price:25.00];
            [[Garden sharedInstance] setWorker5Price:50.00];
            [[Garden sharedInstance] setWorker6Price:200.00];
            [[Garden sharedInstance] setWorker7Price:1000.00];
            
            //update prices in the arrays
            savedWorkerPrices = [NSMutableArray arrayWithObjects:@"$0.50", @"$2.50", @"$10.00", @"$25.00", @"$50.00", @"$200.00", @"$1000.00", nil];
            productionPrices = [NSMutableArray arrayWithObjects:@"$0.50", @"$2.50", @"$10.00", @"$25.00", @"$50.00", @"$200.00", @"$1000.00", nil];
            
            //refresh table with new prices
            [self.tableView reloadData];
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

//create section headers
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel * sectionHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 175)];
    sectionHeader.backgroundColor = [UIColor colorWithRed:0.56 green:0.80 blue:0.95 alpha:1.0];
    sectionHeader.font = [UIFont boldSystemFontOfSize:30];
    sectionHeader.textAlignment = NSTextAlignmentCenter;
    sectionHeader.textColor = [UIColor whiteColor];
    if (section == 0) {
        sectionHeader.text = @"Trees";
    }
    else{
        sectionHeader.text = @"Workers";
    }
    return sectionHeader;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if(section == 0) {
        return [treeItems count];
    }
    if(section == 1) {
        return [productionItems count];
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85.0;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
