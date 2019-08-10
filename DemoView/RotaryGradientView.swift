//
//  RotaryGradientView.swift
//  RotaryAnimation
//
//  Created by 邱云翔 on 2019/8/9.
//  Copyright © 2019 邱云翔. All rights reserved.
//

import UIKit

class RotaryGradientView: UIView,RotaryAnimationCalculateProtocol {
    
    var rotaryVariable: RotaryVariableStruct = RotaryVariableStruct.init()

    //动画控件一：指针
    lazy var arrowView : UIView = {
        //
        let view = UIView.init(frame: CGRect.init(x: (self.bounds.size.width - 9) / 2, y: 2, width: 9, height: self.bounds.size.width / 2 - 2))
        view.backgroundColor = UIColor.clear
        
        //
        let lineView = UIView.init(frame: CGRect.init(x: (view.bounds.size.width - 2) / 2, y: 0, width: 2, height: 12))
        lineView.backgroundColor = UIColor.init(red: 1.0, green: 167.0/255.0, blue: 99.0/255.0, alpha: 1.0)
        view.addSubview(lineView)
        
        //
        let pointView = UIView.init(frame: CGRect.init(x: 1, y: 8.5, width: 7, height: 7))
        pointView.layer.cornerRadius = 3.5
        pointView.layer.masksToBounds = true
        pointView.backgroundColor = lineView.backgroundColor
        view.addSubview(pointView)
        
        //
        let maskLayer = CAShapeLayer.init()
        let maskPath = UIBezierPath.init()
        maskPath.move(to: CGPoint.init(x: 0, y: 0))
        maskPath.addLine(to: CGPoint.init(x: 9, y: 0))
        maskPath.addLine(to: CGPoint.init(x: 9, y: 15.5))
        maskPath.addLine(to: CGPoint.init(x: 0, y: 15.5))
        maskPath.close()
        maskLayer.path = maskPath.cgPath
        view.layer.mask = maskLayer
        
        //
        view.layer.anchorPoint = CGPoint.init(x: 0.5, y: 1)
        view.frame = CGRect.init(x: (self.bounds.size.width - 9) / 2, y: 2, width: 9, height: self.bounds.size.width / 2 - 2)
        self.addSubview(view)
        
        return view
    }()
    
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
    
    //视图设置
    func setUpViews() {
        let backView = UIImageView.init(image: UIImage.init(named: "RotaryGradientTypeOfOutside"))
        backView.frame = self.bounds
        self.addSubview(backView)
        
        //
        let frontView = UIImageView.init(image: UIImage.init(named: "RotaryGradientTypeOfInside"))
        frontView.frame = self.bounds
        self.addSubview(frontView)
        
        //
        frontView.layer.mask = self.maskLayer
        
        //动画参数配置
        rotaryVariable.fps = 60
        rotaryVariable.cumulativeRote = 135
        rotaryVariable.circleCenter = CGPoint.init(x: self.bounds.size.width / 2, y: self.bounds.size.width / 2)
        rotaryVariable.startAngle = 135
        rotaryVariable.endAngle = 405
    }
    
    //服从协议处理视图
    func detailView() {
        
        //转盘动画部分
        let path = UIBezierPath.init(arcCenter: rotaryVariable.circleCenter, radius: self.bounds.size.width / 2, startAngle: CGFloat(self.radianToAngle(angle: rotaryVariable.startAngle)), endAngle: CGFloat(self.radianToAngle(angle: rotaryVariable.cumulativeRote)), clockwise: true)
        path.addLine(to: rotaryVariable.circleCenter)
        path.close()
        //
        self.maskLayer.path = path.cgPath
        
        //指针动画部分
        self.arrowView.transform = CGAffineTransform.init(rotationAngle: CGFloat(self.radianToAngle(angle: rotaryVariable.cumulativeRote+90)))
    }
    
}
