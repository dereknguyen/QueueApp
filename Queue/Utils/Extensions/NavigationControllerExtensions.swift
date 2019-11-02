//
//  NavigationControllerExtensions.swift
//  Queue
//
//  Created by Derek Nguyen on 11/1/19.
//  Copyright © 2019 Derek Nguyen. All rights reserved.
//

import UIKit

extension UINavigationBar {
    public func setupNavigationBar() {
        barTintColor = Colors.background
        backgroundColor = Colors.background
        tintColor = Colors.tintColor
        shadowImage = UIImage()
    }
}


extension UINavigationItem {
    public func removeBackButtonLabel() {
        backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
    }
    
    public func setBackButton(image: UIImage, action: Selector? = nil) {
        leftBarButtonItem = UIBarButtonItem(image: image,
                                            style: .plain,
                                            target: self,
                                            action: action)
    }
}
