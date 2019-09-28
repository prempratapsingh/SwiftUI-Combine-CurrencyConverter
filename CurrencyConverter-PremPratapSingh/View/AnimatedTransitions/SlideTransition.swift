import UIKit

class SlideTransition: NSObject, UIViewControllerAnimatedTransitioning {
    var slideDirection: SlideDirection = .fromRight
    let duration: TimeInterval = 0.4
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        var viewKey: UITransitionContextViewKey = .to
        if slideDirection == .toLeft || slideDirection == .toRight || slideDirection == .toTop || slideDirection == .toBottom {
            viewKey = .from
        }
        let view = transitionContext.view(forKey: viewKey)!
        container.addSubview(view)
        
        var fromOrigin: CGPoint!
        switch slideDirection {
        case .fromLeft:
            fromOrigin = CGPoint(x: -view.frame.width, y: 0)
        case .fromRight:
            fromOrigin = CGPoint(x: view.frame.width, y: 0)
        case .fromTop:
            fromOrigin = CGPoint(x: 0, y: -view.frame.height)
        case .fromBottom:
            fromOrigin = CGPoint(x: 0, y: view.frame.height)
        case .toLeft, .toRight, .toTop, .toBottom:
            fromOrigin = .zero
        }
        view.frame.origin = fromOrigin
        
        UIView.animate(withDuration: duration,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {
                        var toOrigin: CGPoint!
                        switch self.slideDirection {
                        case .toLeft:
                            toOrigin = CGPoint(x: -view.frame.width, y: 0)
                        case .toRight:
                           toOrigin = CGPoint(x: view.frame.width, y: 0)
                        case .toTop:
                            toOrigin = CGPoint(x: 0, y: -view.frame.height)
                        case .toBottom:
                            toOrigin = CGPoint(x: 0, y: view.frame.height)
                        case .fromLeft, .fromRight, .fromTop, .fromBottom:
                            toOrigin = .zero
                        }
                        view.frame.origin = toOrigin
        },
                       completion: { _ in
                        if self.slideDirection == .toLeft || self.slideDirection == .toRight || self.slideDirection == .toTop || self.slideDirection == .toBottom {
                            view.removeFromSuperview()
                        }
                        transitionContext.completeTransition(true)
        })
    }
}
