//
//  QueueCustomButton.swift
//  Queue
//
//  Created by Derek Nguyen on 10/15/19.
//  Copyright © 2019 Derek Nguyen. All rights reserved.
//

import UIKit

extension UIView {
    func generateGradient(colors: [CGColor]) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.2)
        gradientLayer.frame = bounds
        return gradientLayer
    }
}

class CustomButton: UIButton {
    
    private lazy var gradientLayer = generateGradient(colors: Colors.gradientActive)
    
    override func imageRect(forContentRect contentRect:CGRect) -> CGRect {
        return CGRect(x: self.frame.width - self.frame.height,
                      y: 0,
                      width: self.frame.height,
                      height: self.frame.height)
    }
    
    func setDisabled() {
        backgroundColor = #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1)
        gradientLayer.removeFromSuperlayer()
        isEnabled = false
    }
    
    func setActive() {
        setBackground(colors: Colors.gradientActive)
        isEnabled = true
    }
    
    func setBackground(colors: [CGColor]) {
        self.layer.insertSublayer(gradientLayer, at: 0)
        bringSubviewToFront(self.imageView!)
    }
}
