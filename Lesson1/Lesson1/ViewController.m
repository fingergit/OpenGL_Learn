//
//  ViewController.m
//  Lesson1
//
//  Created by redos on 2018/1/28.
//  Copyright © 2018年 redos. All rights reserved.
//

#import "ViewController.h"
#import "GLView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    GLView* glView = (GLView*)self.view;
    [glView render];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
