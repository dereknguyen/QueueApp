import UIKit

extension UIColor {
    
    class var QueueAppBlue: UIColor {
        return UIColor(named: "Queue Blue")!
    }
    
    class var QueueAppLightBlue: UIColor {
        return UIColor(named: "Queue Light Blue")!
    }
    
    class var QueueAppViolet: UIColor {
        return UIColor(named: "Queue Violet")!
    }
    
    class var QueueAppPurple: UIColor {
        return UIColor(named: "Queue Purple")!
    }
    
    class var QueueAppGradient: [CGColor] {
        return [QueueAppViolet.cgColor, QueueAppBlue.cgColor]
    }
    
    class var background: UIColor {
        return UIColor(named: "Background")!
    }
    
    class var alertBackgroundOverlay: UIColor {
        return UIColor.black.withAlphaComponent(0.3)
    }
    
    class var textColor: UIColor {
        return UIColor(named: "Text")!
    }
    
    class var tintColor: UIColor {
        return UIColor(named: "Tint")!
    }
    
    class var buttonNormal: UIColor {
        return UIColor(named: "Button Normal")!
    }
        
    class var buttonDestructive: UIColor {
        return UIColor(named: "Button Destructive")!
    }
    
    class var buttonDisabled: UIColor {
        return UIColor(named: "Button Disabled")!
    }
    
    class var tabBarTint: UIColor {
        return QueueAppViolet
    }
}
