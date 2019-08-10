//
//  RotaryDialView.swift
//  RotaryAnimation
//
//  Created by 邱云翔 on 2019/8/8.
//  Copyright © 2019 邱云翔. All rights reserved.
//

import UIKit

class RotaryDialView: UIView,RotaryAnimationCalculateProtocol {
    
    var rotaryVariable: RotaryVariableStruct = RotaryVariableStruct.init()
    
    lazy var maskLayer : CAShapeLayer = {
        return CAShapeLayer.init()
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        //
        self.backgroundColor = UIColor.white
        
        //
        let backView = UIImageView.init(image: UIImage.init(named: "rotaryTypeOfClear"))
        backView.frame = self.bounds
        self.addSubview(backView)
        
        //
        let frontView = UIImageView.init(image: UIImage.init(named: "rotaryTypeOfColor"))
        frontView.frame = self.bounds
        self.addSubview(frontView)
        
        //
        frontView.layer.mask = self.maskLayer
        
        //动画参数配置
        rotaryVariable.fps = 60
        rotaryVariable.cumulativeRote = 140
        rotaryVariable.circleCenter = CGPoint.init(x: self.bounds.size.width / 2, y: self.bounds.size.width / 2)
        rotaryVariable.startAngle = 140
        rotaryVariable.endAngle = 400
    }
    
    //代理事件
    func detailView() {
        //
        let path = UIBezierPath.init(arcCenter: rotaryVariable.circleCenter, radius: self.bounds.size.width / 2, startAngle: CGFloat(self.radianToAngle(angle: rotaryVariable.startAngle)), endAngle: CGFloat(self.radianToAngle(angle: rotaryVariable.cumulativeRote)), clockwise: true)
        path.addLine(to: rotaryVariable.circleCenter)
        path.close()
        //
        self.maskLayer.path = path.cgPath
    }
}
