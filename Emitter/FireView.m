//
//  FireView.m
//  Emitter
//
//  Created by 王得胜 on 2020/4/8.
//  Copyright © 2020 王得胜. All rights reserved.
//

#import "FireView.h"

@interface FireView ()

@property (strong,nonatomic) CAEmitterLayer *explosionLayer;

@end

@implementation FireView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    [self setupExplosion];
}

-(void)setupExplosion{
    CAEmitterCell *explosionCell = [[CAEmitterCell alloc]init];
    explosionCell.alphaRange = 0.10;
    explosionCell.alphaSpeed = -1.0;
    explosionCell.lifetime = 1.0;
    explosionCell.lifetimeRange = 0.3;
    explosionCell.birthRate = 1500;
    explosionCell.velocity = 40.0;
    explosionCell.velocityRange = 10.0;
    explosionCell.scale = 0.1;
    explosionCell.scaleRange = 0.02;
    explosionCell.contents = (__bridge id _Nullable)([UIImage imageNamed:@"icon_xin"].CGImage);
    self.explosionLayer.emitterCells = @[explosionCell];
    [self.layer addSublayer:self.explosionLayer];
}

-(CAEmitterLayer *)explosionLayer{
    if (_explosionLayer == nil){
        _explosionLayer = [[CAEmitterLayer alloc] init];
        _explosionLayer.emitterShape = kCAEmitterLayerCircle;
        _explosionLayer.emitterMode = kCAEmitterLayerOutline;
        _explosionLayer.emitterSize = CGSizeMake(10, 0);
        _explosionLayer.renderMode = kCAEmitterLayerOldestFirst;
        _explosionLayer.masksToBounds = NO;
        _explosionLayer.birthRate = 0;
        _explosionLayer.position = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
        _explosionLayer.zPosition = -1;
    }
    return _explosionLayer;
}

-(void)startAnimation{
    self.explosionLayer.beginTime = CACurrentMediaTime();
    self.explosionLayer.birthRate = 1;
    [self performSelector:@selector(stopAnimation) withObject:nil afterDelay:0.15];
}

-(void)stopAnimation{
    self.explosionLayer.birthRate = 0;
}

@end
