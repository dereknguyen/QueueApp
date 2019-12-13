import UIKit

class QueueAppButton: UIButton {
    
    enum Style {
        case normal
        case disabled
        case active
        case destructive
    }
    
    private lazy var gradientLayer = generateGradient(colors: UIColor.QueueAppGradient)
    
    override func imageRect(forContentRect contentRect:CGRect) -> CGRect {
        return CGRect(x: frame.width - frame.height, y: 0, width: frame.height, height: frame.height)
    }
    
    func setButton(title: String? = nil, style: QueueAppButton.Style) {
        
        DispatchQueue.main.async {
            [weak self] in
            guard let this = self else { return }
            this.setTitle(
                (title ?? this.title(for: .normal))?.uppercased(),
                for: .normal
            )
            
            this.layer.borderWidth = 0.0
            this.layer.borderColor = UIColor.clear.cgColor
            this.gradientLayer.removeFromSuperlayer()
            
            switch style {
            case .active:       this.setActive()
            case .destructive:  this.setDestructive()
            case .disabled:     this.setDisabled()
            case .normal:       this.setNormal()
            }
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
