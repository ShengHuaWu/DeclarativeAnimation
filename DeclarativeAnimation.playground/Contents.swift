import UIKit
import PlaygroundSupport

let frame = CGRect(x: 0, y: 0, width: 500, height: 500)
let liveView = UIView(frame: frame)
liveView.backgroundColor = .white

let smallFrame = CGRect(x: 20, y: 20, width: 50, height: 50)
let animationView = UIView(frame: smallFrame)
animationView.backgroundColor = .red
animationView.alpha = 0
liveView.addSubview(animationView)

let anotherView = UIView(frame: smallFrame)
anotherView.backgroundColor = .blue
anotherView.alpha = 0
liveView.addSubview(anotherView)

let size = CGSize(width: 200, height: 200)
let point = CGPoint(x: 200, y: 200)

animate(
    animationView.animate(.fadeIn(with: 3), .resize(to: size, with: 3)),
    anotherView.animateInParallel(.fadeIn(with: 3), .move(to: point, with: 3))
)

PlaygroundPage.current.liveView = liveView
