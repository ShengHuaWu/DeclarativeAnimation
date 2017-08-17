import Foundation
import UIKit

enum AnimationMode {
    case sequence
    case parallel
}

public final class AnimationToken {
    private let view: UIView
    private let animations: [Animation]
    private let mode: AnimationMode
    private var isValid = true
    
    // We don't want the API user to think that they should create tokens
    // themselves, so we make the initializer internal to the framework
    init(view: UIView, animations: [Animation], mode: AnimationMode) {
        self.view = view
        self.animations = animations
        self.mode = mode
    }
    
    deinit {
        // Automatically perform the animations when the token gets deallocated
        perform {}
    }
    
    func perform(completion: @escaping () -> Void) {
        // To prevent the animation from being executed twice, we invalidate
        // the token once its animation has been performed
        guard isValid else { return }
        
        isValid = false
        
        switch mode {
        case .sequence:
            view.perform(animations: animations, completion: completion)
        case .parallel:
            view.performAnimationInParallel(animations, completion: completion)
        }
    }
}

public func animate(_ tokens: [AnimationToken]) {
    guard !tokens.isEmpty else { return }
    
    var tokensCopy = tokens
    let token = tokensCopy.removeFirst()
    
    token.perform { 
        animate(tokensCopy)
    }
}
