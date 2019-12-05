import UIKit

struct Images {
    static let backgroundImage  = UIImage(named: "Badminton Background")
    static let logoQ            = UIImage(named: "Logo Q")
    static let logoUEUE         = UIImage(named: "Logo UEUE")
}

struct Icons {
    static let leftArrow                = UIImage(named: "Left Arrow")
    static let rightAngleBracket        = UIImage(named: "Right Angle Bracket")
    static let rightAngleBracketSmall   = UIImage(named: "Right Angle Bracket Small")
    static let x                        = UIImage(named: "X Button")
}

struct LoadingMessage {
    static let email = (title: "CHECKING EMAIL", msg: "Hang tight for a moment.")
    static let login = (title: "LOGING IN", msg: "Hang tight for a moment.")
}

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
