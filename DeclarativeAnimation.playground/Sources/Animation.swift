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
    @discardableResult public func animate(_ animations: Animation...) -> AnimationToken {
        return animate(animations)
    }
    
    func animate(_ animations: [Animation]) -> AnimationToken {
        return AnimationToken(view: self, animations: animations, mode: .sequence)
    }
    
    @discardableResult func animateInParallel(_ animations: Animation...) -> AnimationToken {
        return animatieInParallel(animations)
    }
    
    func animatieInParallel(_ animations: [Animation]) -> AnimationToken {
        return AnimationToken(view: self, animations: animations, mode: .parallel)
    }
    
    func perform(animations: [Animation], completion: @escaping () -> Void) {
        // This implementation is exactly the same as before, only now we call
        // the completion handler when our exit condition is hit
        guard !animations.isEmpty else {
            return completion()
        }
        
        // Remove the first animation from the queue
        var animationsCopy = animations
        let animation = animationsCopy.removeFirst()
        
        // Perform the animation by calling its closure
        UIView.animate(withDuration: animation.duration, animations: {
            animation.closure(self)
        }) { _ in
            // Recursively call the method, to perform each animation in sequence
            self.perform(animations: animationsCopy, completion: completion)
        }
    }
    
    func performAnimationInParallel(_ animations: [Animation], completion: @escaping () -> Void) {
        guard !animations.isEmpty else {
            return completion()
        }
        
        // In order to call the completion handler once all animations
        // have finished, we need to keep track of these counts
        let animationCount = animations.count
        var completionCount = 0
        
        let animationCompletion = {
            completionCount += 1
            
            // Once all animations have finished, we call the completion handler
            if completionCount == animationCount {
                completion()
            }
        }
        
        // Same as before, only with the call to the animation
        // completion handler added
        for animation in animations {
            UIView.animate(withDuration: animation.duration, animations: { 
                animation.closure(self)
            }, completion: { _ in
                animationCompletion()
            })
        }
    }
}
