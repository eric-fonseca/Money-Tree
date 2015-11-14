//
//  Garden.h
//  MoneyTree
//
//  Created by Student on 11/30/14.
//  Copyright (c) 2014 Eric Fonseca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Store.h"
#import "AppDelegate.h"

@interface Garden : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *currentTree;
@property (weak, nonatomic) IBOutlet UILabel *totalCashLabel;
@property (weak, nonatomic) IBOutlet UILabel *cashPerSecondLabel;
@property (weak, nonatomic) IBOutlet UIImageView *grassImage;

@property (nonatomic) float totalCash;
@property (nonatomic) float cashMultiplier;
@property (nonatomic) float cashPerSecond;
@property (nonatomic) int treeImage;
@property (nonatomic) float worker1Price;
@property (nonatomic) float worker2Price;
@property (nonatomic) float worker3Price;
@property (nonatomic) float worker4Price;
@property (nonatomic) float worker5Price;
@property (nonatomic) float worker6Price;
@property (nonatomic) float worker7Price;

- (void)updateTotalCash;
- (void)updateTreeImage;
- (void)changeTree:(NSString*)tree;
+ (id)sharedInstance;

@end

