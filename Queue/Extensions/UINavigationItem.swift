import UIKit

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
