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
    static let xSmall                   = UIImage(named: "X Button Small")
    static let checkmark                = UIImage(named: "Checkmark")
    static let edit                     = UIImage(named: "Edit")
    static let partner                  = UIImage(named: "Partner")
    static let singlePlayer             = UIImage(named: "Single Player")
    static let deletePlayer             = UIImage(named: "Delete Player")
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
