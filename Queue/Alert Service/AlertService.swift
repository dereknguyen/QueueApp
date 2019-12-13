import UIKit

class AlertService: UIViewController {    
    public static func actionSheet(title: String) -> ActionSheetController {
        let sb = UIStoryboard(name: "ActionSheet", bundle: .main)
        let vc = sb.instantiateViewController(withIdentifier: "ActionSheet") as! ActionSheetController
        vc.prompt = title
        return vc
    }
}

