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

let size = CGSize(width: 200, height: 200)
let point = CGPoint(x: 200, y: 200)
//animationView.animate([.fadeIn(with: 3.0), .resize(to: size, with: 3.0)])
animationView.animatieInParallel([.fadeIn(with: 3.0), .resize(to: size, with: 3.0), .move(to: point, with: 3.0)])

PlaygroundPage.current.liveView = liveView
