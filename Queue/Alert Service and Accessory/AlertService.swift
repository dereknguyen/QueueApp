import UIKit

class AlertService: UIViewController {
    public static func loading(title: String, message: String) -> LoadingViewController {
        let sb = UIStoryboard(name: "Loading", bundle: .main)
        let vc = sb.instantiateViewController(withIdentifier: "Loading") as! LoadingViewController
        vc.setContent(title: title, message: message)
        return vc
    }
    
    public static func actionSheet(title: String) -> ActionSheetController {
        let sb = UIStoryboard(name: "ActionSheet", bundle: .main)
        let vc = sb.instantiateViewController(withIdentifier: "ActionSheet") as! ActionSheetController
        vc.prompt = title
        return vc
    }
    
    public static func alert(title: String) -> AlertController {
        let sb = UIStoryboard(name: "Alert", bundle: .main)
        let vc = sb.instantiateViewController(withIdentifier: "Alert") as! AlertController
        vc.title = title
        return vc
    }
}

class AlertAccessory {
    public static func club(logo: UIImage?, name: String, id: String) -> AlertAccessoryView {
        let view = Bundle.main.loadNibNamed("ClubAccessory", owner: nil, options: nil)!.first as! ClubAcessory
        view.configure(logo: logo, name: name, id: id)
        return view
    }
    
    public static func button(title: String, style: ButtonAccessory.Style, image: UIImage?, handler: @escaping () -> Void) -> AlertAccessoryView {
        let view = Bundle.main.loadNibNamed("ButtonAccessory", owner: nil, options: nil)!.first as! ButtonAccessory
        view.configure(title: title, style: style, image: image, handler: handler)
        return view
    }
}
