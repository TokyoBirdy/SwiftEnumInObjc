//
//  ViewController.m
//  SwiftEnumInObjC
//
//  Created by Cecilia Humlelu on 06/02/15.
//  Copyright (c) 2015 Cecilia Humlelu. All rights reserved.
//

#import "ViewController.h"
#import "SwiftEnumInObjC-Swift.h"

@interface ViewController ()
@property (nonatomic,strong) CHTransitionManager * transitionManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.transitionManager  = [[CHTransitionManager alloc] initWithAState:CHTransitionAnimationState.Push];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;{
    if([segue.destinationViewController isKindOfClass:[UINavigationController class]]){
        UINavigationController *nav = segue.destinationViewController;
        nav.transitioningDelegate = self.transitionManager;
    }
}



-(IBAction)unwindToViewController:(UIStoryboardSegue *)sender; {
    
}


@end
