//
//  AnimationProtocol.swift
//  RotaryAnimation
//
//  Created by 邱云翔 on 2019/8/8.
//  Copyright © 2019 邱云翔. All rights reserved.
//

import UIKit

//动画计算协议配置
struct RotaryVariableStruct {
    var realAngle : Float //真实需要旋转的角度 endAngle - startAngle
    var intervalRote : Float //分隔的角度间隔
    var cumulativeRote : Float //累加的角度
    var circleCenter : CGPoint //圆心
    var startAngle : Float //起始角度
    var endAngle : Float //结束角度
    var fps : UInt //帧率设定,每秒执行 1.0 / fps 次
    
    init(realAngle : Float = 0.0,intervalRote : Float = 0.0,cumulativeRote :Float = 0.0,circleCenter : CGPoint = CGPoint.init(x: 0, y: 0),startAngle : Float = 0.0,endAngle : Float = 0.0, fps : UInt = 0) {
        self.realAngle = realAngle
        self.intervalRote = intervalRote
        self.cumulativeRote = cumulativeRote
        self.circleCenter = circleCenter
        self.startAngle = startAngle
        self.endAngle = endAngle
        self.fps = fps
    }
}

//动画旋转计算协议
protocol RotaryAnimationCalculateProtocol where Self : UIView {
    //配置
    var rotaryVariable : RotaryVariableStruct {get set}
    
    //服从协议的类需要对视图操作的方法
    func detailView()
}

extension RotaryAnimationCalculateProtocol  {
    //开始计算动画
    func startAnimation(proportion:Float,durationTime:Float) {
        //计算比例和时间，分化成每次叠加的角度，完整的角度从startAngle - endAngle，差值为X
        //拿到比例，获得实际需要动画的角度
        rotaryVariable.realAngle = proportion * (rotaryVariable.endAngle - rotaryVariable.startAngle) + rotaryVariable.cumulativeRote;
        //要在x秒内完成realAngle角度转换
        rotaryVariable.intervalRote = rotaryVariable.realAngle / durationTime / (Float(rotaryVariable.fps))
        //
        let timer = Timer.init(timeInterval: TimeInterval(1.0/Float(rotaryVariable.fps)), repeats: true, block: {[weak self] (timer) in
            self?.computingAngle(timer: timer)
        })
        RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
        timer.fire()
    }
    
    //角度的累计叠加值
    func computingAngle(timer:Timer) {
        rotaryVariable.cumulativeRote += rotaryVariable.intervalRote
        if rotaryVariable.cumulativeRote > rotaryVariable.realAngle {
            self.destructionTimer(timer: timer)
        }
        self.detailView()
    }
    
    //角度弧度转换
    func radianToAngle(angle:Float) -> Float {
        return (angle * Float(Double.pi) / 180)
    }
    
    //销毁计时器
    func destructionTimer(timer:Timer) {
        timer.invalidate()
    }
}
