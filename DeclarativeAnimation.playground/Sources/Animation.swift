import Foundation
import UIKit

public struct Animation {
    public let duration: TimeInterval
    public let closure: (UIView) -> Void
}

extension Animation {
    public static func fadeIn(with duration: TimeInterval = 0.3) -> Animation {
        return Animation(duration: duration, closure: { $0.alpha = 1 })
    }
    
    public static func resize(to size: CGSize, with duration: TimeInterval = 0.3) -> Animation {
        return Animation(duration: duration) { (view) in
            let newFrame = CGRect(origin: view.frame.origin, size: size)
            view.frame = newFrame
        }
    }
    
    public static func move(to point: CGPoint, with duration: TimeInterval = 0.3) -> Animation {
        return Animation(duration: duration) { (view) in
            view.center = point
        }
    }
}

extension UIView {
    public func animate(_ animations: [Animation]) {
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
            self.animate(animationsCopy)
        }
    }
    
    public func animatieInParallel(_ animations: [Animation]) {
        for animation in animations {
            UIView.animate(withDuration: animation.duration) {
                animation.closure(self)
            }
        }
    }
}
