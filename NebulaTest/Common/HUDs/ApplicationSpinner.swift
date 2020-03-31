//
//  ApplicationSpinner.swift
//

import UIKit

final class ApplicationSpinner: Spinner {
    
    private var tag: Int { 10101 }
    
    func show(on view: UIView, text: String?, blockUI: Bool, indicatorColor: UIColor) {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = indicatorColor

        if blockUI {
            let backgroundView = UIView()
            backgroundView.tag = tag
            view.addSubview(backgroundView)
            backgroundView.translatesAutoresizingMaskIntoConstraints = false
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            layoutIndicator(indicator: activityIndicator, in: backgroundView)
        } else {
            activityIndicator.tag = tag
            layoutIndicator(indicator: activityIndicator, in: view)
        }
    }
    
    func hide(from view: UIView) {
        view.subviews.first { $0.tag == tag }?.removeFromSuperview()
    }
    
    private func layoutIndicator(indicator: UIActivityIndicatorView, in view: UIView) {
        view.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
