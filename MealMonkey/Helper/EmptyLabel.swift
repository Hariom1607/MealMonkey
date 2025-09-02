import Foundation
import UIKit
import Lottie

class EmptyStateView: UIView {
    
    private var animationView: LottieAnimationView!
    private var messageLabel: UILabel!
    
    init(animationName: String, message: String) {
        super.init(frame: .zero)
        setupView(animationName: animationName, message: message)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView(animationName: String, message: String) {
        // Lottie Animation
        let animation = LottieAnimation.named(animationName)
        animationView = LottieAnimationView(animation: animation)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        
        // Label
        messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        messageLabel.textColor = .gray
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        
        // Stack
        let stack = UIStackView(arrangedSubviews: [animationView, messageLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            animationView.widthAnchor.constraint(equalToConstant: 200),
            animationView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}

extension UITableView {
    func setEmptyView(animationName: String, message: String) {
        let emptyView = EmptyStateView(animationName: animationName, message: message)
        emptyView.frame = self.bounds
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
