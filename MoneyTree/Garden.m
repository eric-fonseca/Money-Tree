//
//  Garden.m
//  MoneyTree
//
//  Created by Student on 11/30/14.
//  Copyright (c) 2014 Eric Fonseca. All rights reserved.
//

#import "Garden.h"
#define APP_RESIGN_ACTIVE_NOTIFICATION @"AppResignActiveNotification"

static NSString *mySavedCounterKey = @"mySAVED_COUNTER_KEY";
static NSString *mySavedTreeKey = @"mySAVED_TREE_KEY";
static NSString *mySavedMultiplierKey = @"mySAVED_MULTIPLIER_KEY";
static NSString *mySavedCashPerSecondKey = @"mySAVED_CPS_KEY";
static NSString *mySavedWorkerKey1 = @"mySAVED_WORKER_KEY_1";
static NSString *mySavedWorkerKey2 = @"mySAVED_WORKER_KEY_2";
static NSString *mySavedWorkerKey3 = @"mySAVED_WORKER_KEY_3";
static NSString *mySavedWorkerKey4 = @"mySAVED_WORKER_KEY_4";
static NSString *mySavedWorkerKey5 = @"mySAVED_WORKER_KEY_5";
static NSString *mySavedWorkerKey6 = @"mySAVED_WORKER_KEY_6";
static NSString *mySavedWorkerKey7 = @"mySAVED_WORKER_KEY_7";

@interface Garden ()

@end

@implementation Garden

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]
    addObserver:self
    selector:@selector(handleResignActiveNotification:)
    name:APP_RESIGN_ACTIVE_NOTIFICATION
    object:nil];
    
    //load and set any saved values from when the app was closed
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    float savedCounterValue = (float)[defaults floatForKey:mySavedCounterKey];
    [[Garden sharedInstance] setTotalCash:savedCounterValue];
    int savedTreeImage = (int)[defaults integerForKey:mySavedTreeKey];
    [[Garden sharedInstance] setTreeImage: savedTreeImage];
    float savedCashMultiplier = (float)[defaults floatForKey:mySavedMultiplierKey];
    [[Garden sharedInstance] setCashMultiplier:savedCashMultiplier];
    float savedCashPerSecondPrice = (float)[defaults floatForKey:mySavedCashPerSecondKey];
    [[Garden sharedInstance] setCashPerSecond:savedCashPerSecondPrice];
    float savedWorker1Price = (float)[defaults floatForKey:mySavedWorkerKey1];
    [[Garden sharedInstance] setWorker1Price:savedWorker1Price];
    float savedWorker2Price = (float)[defaults floatForKey:mySavedWorkerKey2];
    [[Garden sharedInstance] setWorker2Price:savedWorker2Price];
    float savedWorker3Price = (float)[defaults floatForKey:mySavedWorkerKey3];
    [[Garden sharedInstance] setWorker3Price:savedWorker3Price];
    float savedWorker4Price = (float)[defaults floatForKey:mySavedWorkerKey4];
    [[Garden sharedInstance] setWorker4Price:savedWorker4Price];
    float savedWorker5Price = (float)[defaults floatForKey:mySavedWorkerKey5];
    [[Garden sharedInstance] setWorker5Price:savedWorker5Price];
    float savedWorker6Price = (float)[defaults floatForKey:mySavedWorkerKey6];
    [[Garden sharedInstance] setWorker6Price:savedWorker6Price];
    float savedWorker7Price = (float)[defaults floatForKey:mySavedWorkerKey7];
    [[Garden sharedInstance] setWorker7Price:savedWorker7Price];
    
    //detect when the tree is touched
    [self.currentTree addTarget:self action:@selector(dragHandler:withEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    //set a timer to update your cash frequently
    [NSTimer scheduledTimerWithTimeInterval:0.05
                                     target:self
                                   selector:@selector(addCashPerSecond)
                                   userInfo:nil
                                    repeats:YES];
}

//update values when switching to this tab
- (void)viewDidAppear:(BOOL)animated {
    //Update total cash when the user switches to this tab
    [self updateTotalCash];
    [self updateCashPerSecond];
    [self updateTreeImage];
}

//update your total cash 20 times/second
- (void)addCashPerSecond{
    [[Garden sharedInstance] setTotalCash:([[Garden sharedInstance] totalCash]+([[Garden sharedInstance] cashPerSecond]/20))];
    [self updateTotalCash];
}

- (IBAction)treeTapped:(id)sender {
    //if you just started a new game, set your cash per harvest to $0.01
    if([[Garden sharedInstance] cashMultiplier] == 0){
        [[Garden sharedInstance] setCashMultiplier:0.01];
    }
    
    //increase your total cash by the value of your tree
    [[Garden sharedInstance] setTotalCash:([[Garden sharedInstance] totalCash]+[[Garden sharedInstance] cashMultiplier])];
    [self updateTotalCash];
}

//animate money falling from the location of your touch
-(void)dragHandler:(UIButton *)sender withEvent:(UIEvent *)event
{
    //get the touch location
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint point = [touch locationInView:self.view];
    UIImage *image;
    
    //change the image of what falls from the tree
    for(int i = 0; i < 10; i++){
        if ([[Garden sharedInstance] treeImage] == i){
            image = [UIImage imageNamed:[NSString stringWithFormat:@"money%d.png", i]];
        }
    }
    
    //animate the money falling
    UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
    imgView.center = CGPointMake(point.x, point.y);
    [self.view addSubview: imgView];
    [UIView animateWithDuration:1
                          delay:0.05
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{imgView.center = CGPointMake(point.x,2400);}
                     completion:^(BOOL finished){[imgView removeFromSuperview];}];
}

//update the cash per second label
- (void)updateCashPerSecond{
    self.cashPerSecondLabel.text = [NSString stringWithFormat:@"$%.2f / second", [[Garden sharedInstance] cashPerSecond]];
}

//update the total cash label
- (void)updateTotalCash {
    self.totalCashLabel.text = [NSString stringWithFormat:@"$%.2f", [[Garden sharedInstance] totalCash]];
}

- (void)updateTreeImage {
    //check to see what the current tree image should be
    for(int i = 0; i < 10; i++){
        if ([[Garden sharedInstance] treeImage] == i){
            [self changeTree:[NSString stringWithFormat:@"tree%d.png", i]];
        }
    }
    //put the grass in front of the tree
    [self.view bringSubviewToFront:self.grassImage];
}

//change the current image of the tree
- (void)changeTree:(NSString*)tree{
    UIImage *buttonImage = [UIImage imageNamed:tree];
    [[self currentTree] setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [self.view addSubview:[self currentTree]];
}

//save values before the app is closed
#pragma mark - Notifications
-(void)handleResignActiveNotification:(NSNotification *)notification{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setFloat:[[Garden sharedInstance] totalCash] forKey:mySavedCounterKey];
    [defaults setInteger:[[Garden sharedInstance] treeImage] forKey:mySavedTreeKey];
    [defaults setFloat:[[Garden sharedInstance] cashMultiplier] forKey:mySavedMultiplierKey];
    [defaults setFloat:[[Garden sharedInstance] cashPerSecond] forKey:mySavedCashPerSecondKey];
    [defaults setFloat:[[Garden sharedInstance] worker1Price] forKey:mySavedWorkerKey1];
    [defaults setFloat:[[Garden sharedInstance] worker2Price] forKey:mySavedWorkerKey2];
    [defaults setFloat:[[Garden sharedInstance] worker3Price] forKey:mySavedWorkerKey3];
    [defaults setFloat:[[Garden sharedInstance] worker4Price] forKey:mySavedWorkerKey4];
    [defaults setFloat:[[Garden sharedInstance] worker5Price] forKey:mySavedWorkerKey5];
    [defaults setFloat:[[Garden sharedInstance] worker6Price] forKey:mySavedWorkerKey6];
    [defaults setFloat:[[Garden sharedInstance] worker7Price] forKey:mySavedWorkerKey7];
    [defaults synchronize];
}

//singleton
+ (id)sharedInstance {
    static id sharedObject = nil;
    if (sharedObject == nil) {
        sharedObject = [[self alloc] init];
    }
    return sharedObject;
}

//hide status bar
- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
