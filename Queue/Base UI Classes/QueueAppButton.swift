import UIKit

class QueueAppButton: UIButton {
    
    enum ActionState {
        case normal
        case disabled
        case active
        case destructive
    }
    
    private lazy var gradientLayer = generateGradient(colors: UIColor.QueueAppGradient)
    
    override func imageRect(forContentRect contentRect:CGRect) -> CGRect {
        return CGRect(x: frame.width - frame.height, y: 0, width: frame.height, height: frame.height)
    }
    
    func setButton(title: String? = nil, state: QueueAppButton.ActionState) {
    
        setTitle(
            (title ?? self.title(for: .normal))?.uppercased(),
            for: .normal
        )
        
        layer.borderWidth = 0.0
        layer.borderColor = UIColor.clear.cgColor
        gradientLayer.removeFromSuperlayer()
        
        switch state {
        case .active:       setActive()
        case .destructive:  setDestructive()
        case .disabled:     setDisabled()
        case .normal:       setNormal()
        }
    }
    
    private func setDisabled() {
        backgroundColor = .buttonDisabled
        setTitleColor(.white, for: .normal)
        tintColor = .white
        isEnabled = false
    }
    
    private func setActive() {
        layer.insertSublayer(gradientLayer, at: 0)
        bringSubviewToFront(imageView!)
        setTitleColor(.white, for: .normal)
        tintColor = .white
        isEnabled = true
    }
    
    private func setDestructive() {
        backgroundColor = .buttonDestructive
        tintColor = .red
        setTitleColor(.red, for: .normal)
        isEnabled = true
    }
    
    private func setNormal() {
        layer.borderWidth = 3.0
        layer.borderColor = UIColor.buttonNormal.cgColor
        backgroundColor = .clear
        tintColor = .buttonNormal
        setTitleColor(.buttonNormal, for: .normal)
        isEnabled = true
    }
}