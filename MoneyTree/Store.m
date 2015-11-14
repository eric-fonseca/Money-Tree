//
//  Store.m
//  MoneyTree
//
//  Created by Student on 11/30/14.
//  Copyright (c) 2014 Eric Fonseca. All rights reserved.
//

#import "Store.h"

@interface Store ()

@end

@implementation Store

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    //Update total cash when the user switches to this tab
    self.storeCashLabel.text = [NSString stringWithFormat:@"$%.2f", [[Garden sharedInstance] totalCash]];
}

- (IBAction)storeClicked:(id)sender {
    [[Garden sharedInstance] setTotalCash:([[Garden sharedInstance] totalCash]+1.00)];
    self.storeCashLabel.text = [NSString stringWithFormat:@"$%.2f", [[Garden sharedInstance] totalCash]];
    [[Garden sharedInstance] setTreeImage:3];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
