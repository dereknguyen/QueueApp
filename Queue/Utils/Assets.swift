//
//  Assets.swift
//  Queue
//
//  Created by Derek Nguyen on 10/18/19.
//  Copyright © 2019 Derek Nguyen. All rights reserved.
//

import UIKit

struct StoryboardID {
    static let loading = "Loading"
    static let launchScreen = "LaunchScreen"
    static let auth = "Authentication"
}

struct ViewControllerID {
    static let authRootNavigation = "AuthRootNavigation"
    static let loading = "Loading"
    static let launchScreen = "LaunchScreen"
}

struct Images {
    static let backgroundImage  = UIImage(named: "Badminton Background")
    static let logoQ            = UIImage(named: "Logo Q")
    static let logoUEUE         = UIImage(named: "Logo UEUE")
}

struct Icons {
    static let leftArrow                = UIImage(named: "Left Arrow")
    static let rightAngleBracket        = UIImage(named: "Right Angle Bracket")
    static let rightAngleBracketSmall   = UIImage(named: "Right Angle Bracket Small")
}

struct Colors {
    static let background               = #colorLiteral(red: 0.9700000286, green: 0.9700000286, blue: 0.9700000286, alpha: 1)
    static let loadingBackground        = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.7)
    static let tintColor                = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    static let textColor                = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    static let disabledButtonBackground = #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1)
    static let buttonTintColor          = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    static let gradientActive           = [#colorLiteral(red: 0.5764705882, green: 0.1764705882, blue: 0.9137254902, alpha: 1).cgColor, #colorLiteral(red: 0.2039215686, green: 0.1490196078, blue: 0.7921568627, alpha: 1).cgColor]
}

struct Copy {
    enum EmailCheckView: String {
        case title = "Hello,"
        case message = "we can check if you already have an account."
    }
    enum LoginView: String {
        case title = "Welcome back"
        case message = "enter your password and we will get you going."
    }
    enum EmailLoadingView: String {
        case title = "CHECKING EMAIL"
        case message = "Hang tight for a moment."
    }
    enum LogInLoadingView: String {
        case title = "LOGING IN"
        case message = "Hang tight for a moment."
    }
}
