//
//  ViewController.swift
//  RotaryAnimation
//
//  Created by 邱云翔 on 2019/8/8.
//  Copyright © 2019 邱云翔. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //动画视图一
        let view_1 = RotaryDialView.init(frame: CGRect.init(x: 40, y: 60, width: 244, height: 195))
        self.view.addSubview(view_1)
        
        view_1.startAnimation(proportion: 0.9, durationTime: 9)
        
        //动画视图二
        let view_2 = RotaryGradientView.init(frame: CGRect.init(x: 60, y: 300, width: 167, height: 143))
        self.view.addSubview(view_2)
        view_2.startAnimation(proportion: 0.95, durationTime: 15)
        
    }


}

