//
//  ViewController.m
//  WeatherApp_v2
//
//  Created by Kenneth Pu on 6/12/16.
//  Copyright © 2016 Kenneth Pu. All rights reserved.
//

#import "ViewController.h"
#import "BingImageSearchClient.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[BingImageSearchClient sharedInstance] fetchImagesForQuery:@"Tokyo Japan Photo" callback:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
