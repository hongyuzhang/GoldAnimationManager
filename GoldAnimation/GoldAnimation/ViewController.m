    //
    //  ViewController.m
    //  GoldAnimation
    //
    //  Created by Justin on 16/1/11.
    //  Copyright © 2016年 MySelf. All rights reserved.
    //

#import "ViewController.h"
#import "GoldAnimationManager.h"

@interface ViewController ()

#pragma mark 为了有个比较炫的效果，做了9个按钮，可能结果还是挺丑的吧，不过测试没有问题。

@property (strong, nonatomic) IBOutlet UIButton *Gold1;
@property (strong, nonatomic) IBOutlet UIButton *Gold2;
@property (strong, nonatomic) IBOutlet UIButton *Gold3;
@property (strong, nonatomic) IBOutlet UIButton *Gold4;
@property (strong, nonatomic) IBOutlet UIButton *Gold5;
@property (strong, nonatomic) IBOutlet UIButton *Gold6;
@property (strong, nonatomic) IBOutlet UIButton *Gold7;
@property (strong, nonatomic) IBOutlet UIButton *Gold8;
@property (strong, nonatomic) IBOutlet UIButton *Gold9;
@property (strong, nonatomic) IBOutlet UIButton *shoppingCar;

@property (strong, nonatomic) NSArray *arr;

@end

@implementation ViewController

-(NSArray *)arr{
    if (!_arr) {
        _arr = [NSArray array];

        _arr = @[self.Gold1,
                 self.Gold2,
                 self.Gold3,
                 self.Gold4,
                 self.Gold5,
                 self.Gold6,
                 self.Gold7,
                 self.Gold8,
                 self.Gold9,
                 ];
    }
    return _arr;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    for (int i = 0 ; i < self.arr.count; i++) {
        [self btnDidClick:self.arr[i]];

    }

}

- (IBAction)btnDidClick:(id)sender {

    [[GoldAnimationManager sharedManager] performGoldAnimationFromView:(UIButton *)sender ToView:self.shoppingCar BackView:self.view];

}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}

@end
