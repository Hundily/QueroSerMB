//
//  UIViewController+Extension.swift
//  QueroSerMB
//
//  Created by Hundily Cerqueira on 19/11/25.
//

import UIKit
import Foundation

private var loadingViewKey: UInt8 = 0

extension UIViewController {

    private var fullScreenLoadingView: UIView? {
        get { objc_getAssociatedObject(self, &loadingViewKey) as? UIView }
        set { objc_setAssociatedObject(self, &loadingViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    func showFullScreenLoading() {
        if fullScreenLoadingView != nil { return }

        let overlay = UIView(frame: view.bounds)
        overlay.backgroundColor = UIColor.black.withAlphaComponent(0.35)
        overlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        let indicator = UIActivityIndicatorView(style: .large)
        indicator.center = overlay.center
        indicator.startAnimating()

        overlay.addSubview(indicator)

        view.addSubview(overlay)
        fullScreenLoadingView = overlay
    }

    func hideFullScreenLoading() {
        fullScreenLoadingView?.removeFromSuperview()
        fullScreenLoadingView = nil
    }
}

