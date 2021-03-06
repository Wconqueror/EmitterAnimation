//
//  ViewController.m
//  Emitter
//
//  Created by 王得胜 on 2020/4/7.
//  Copyright © 2020 王得胜. All rights reserved.
//

#import "ViewController.h"
#import "FireView.h"


#define SCREEN_WIDTH     [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT    [[UIScreen mainScreen] bounds].size.height


@interface ViewController ()
@property (nonatomic,strong) CAEmitterLayer *emitterLayer;
@property (nonatomic,strong) UIView *emitterView;
@property (nonatomic,strong) FireView *fireView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initSky];
    [self initEmitteryLayer];
    [self initView];
}

-(void)initSky{
    //天空渐变色
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:gradientLayer];
    
    UIColor *lightColor = [UIColor colorWithRed:40.0 / 255.0 green:150.0/255.0 blue:200.0/255.0 alpha:1.0];
    
    UIColor *whiteColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    
    gradientLayer.colors = @[(__bridge id)lightColor.CGColor,(__bridge id)whiteColor.CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
}

//粒子发射器
-(void)initEmitteryLayer{
    _emitterView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_WIDTH - 100)];
    _emitterView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_emitterView];
    
    //每秒粒子产生的乘数因子,会和layer的birthRate相乘,然后确定每秒产生的粒子个数
    CAEmitterCell *cell = [[CAEmitterCell alloc]init];
    
    cell.contents = (__bridge id _Nullable)([UIImage imageNamed:@"white"].CGImage);
    cell.birthRate = 2000;
    //粒子的存活时长
    cell.lifetime = 5.0;
    //粒子生命周期的范围
    cell.lifetimeRange = 0.3;
    //粒子透明度的变化
    cell.alphaSpeed = -0.2;
    //粒子透明度变化范围
    cell.alphaRange = 0.5;
    //粒子速度
    cell.velocity = 40;
    //粒子的速度变化范围
    cell.velocityRange = 20;
    //周围发射的角度,如果M_PI*2 就可以从360度的任意位置发射
    cell.emissionRange = M_PI * 2;
    cell.redRange = 0.5;
    cell.blueRange = 0.5;
    cell.greenRange = 0.5;
    
    cell.scale = 0.2; //缩放比例
    cell.scaleRange = 0.02;//缩放比例范围
    cell.yAcceleration = 70.0; //y方向的加速度
    cell.xAcceleration = 20.0;//x方向的加速度
    
    _emitterLayer = [CAEmitterLayer layer];
    _emitterLayer.emitterPosition = CGPointMake(SCREEN_WIDTH / 2.0, 0); //发射位置
    _emitterLayer.emitterSize = CGSizeMake(SCREEN_WIDTH, 0);//发射器的尺寸
    _emitterLayer.emitterShape = kCAEmitterLayerCircle; //发射形状
    _emitterLayer.emitterMode = kCAEmitterLayerOutline;//发射模式
    _emitterLayer.renderMode = kCAEmitterLayerUnordered;//渲染模式
    
    _emitterLayer.zPosition = -1;
    _emitterLayer.emitterCells = @[cell];
    [self.emitterView.layer addSublayer:_emitterLayer];
}

-(void)initView{
    UIButton *clickButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 100, 40)];
    clickButton.backgroundColor = [UIColor blueColor];
    [clickButton setTitle:@"暂停" forState:UIControlStateNormal];
    [clickButton setTitle:@"开始" forState:UIControlStateSelected];
    [clickButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [clickButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clickButton];
    
    UIButton *fireButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 110, 20, 100, 40)];
    fireButton.backgroundColor = [UIColor blueColor];
    [fireButton setTitle:@"烟花" forState:UIControlStateNormal];
    [fireButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [fireButton addTarget:self action:@selector(fireAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fireButton];
    
    _fireView = [[FireView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    _fireView.center = self.view.center;
    [self.view addSubview:_fireView];
}

-(void)buttonAction:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (!btn.selected){
        [self startAnimation];
    }else{
        [self stopAnimation];
    }
}

-(void)startAnimation{
    self.emitterLayer.birthRate = 1;
}

-(void)stopAnimation{
    self.emitterLayer.birthRate = 0;
}

-(void)fireAction{
    [_fireView startAnimation];
}

@end
