//
//  StoreVC.h
//  MoneyTree
//
//  Created by Student on 12/2/14.
//  Copyright (c) 2014 Eric Fonseca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Garden.h"

@interface StoreVC : UITableViewController{
    NSArray *treeItems;
    NSMutableArray *treePrices;
    NSArray *productionItems;
    NSMutableArray *productionPrices;
    NSMutableArray *savedWorkerPrices;
    UITableViewCell *cell;
}

@property (weak, nonatomic) IBOutlet UILabel *cashLabel;

-(void)addCashPerSecond;
-(void)treePurchased:(int)image treeCost:(float)price cashMultiplier:(float)multiplier;
-(void)workerPurchased:(int)worker selectedCell:(UITableViewCell *)cellTapped cashPerSecond:(float)cps;
-(void)updateWorkerPrices;

@end
