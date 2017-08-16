import Foundation
import UIKit

public struct Animation {
    public let duration: TimeInterval
    public let closure: (UIView) -> Void
}

extension Animation {
    public static func fadeIn(duration: TimeInterval = 0.3) -> Animation {
        return Animation(duration: duration, closure: { $0.alpha = 1 })
    }
    
    public static func resize(to size: CGSize, duration: TimeInterval = 0.3) -> Animation {
        return Animation(duration: duration, closure: { $0.bounds.size = size })
    }
}

extension UIView {
    public func animate(with animations: [Animation]) {
        // Exit condition: once all animations have been performed, we can return
        guard !animations.isEmpty else { return }
        
        // Remove the first animation from the queue
        var animationsCopy = animations
        let animation = animationsCopy.removeFirst()
        
        // Perform the animation by calling its closure
        UIView.animate(withDuration: animation.duration, animations: {
            animation.closure(self)
        }) { _ in
            // Recursively call the method, to perform each animation in sequence
            self.animate(with: animationsCopy)
        }
    }
}
