import UIKit
import PlaygroundSupport

let frame = CGRect(x: 0, y: 0, width: 500, height: 500)
let liveView = UIView(frame: frame)
liveView.backgroundColor = .white

let smallFrame = CGRect(x: 0, y: 0, width: 50, height: 50)
let animationView = UIView(frame: smallFrame)
animationView.backgroundColor = .red
animationView.alpha = 0
liveView.addSubview(animationView)

let size = CGSize(width: 300, height: 300)
animationView.animate(with: [.fadeIn(), .resize(to: size)])

PlaygroundPage.current.liveView = liveView
