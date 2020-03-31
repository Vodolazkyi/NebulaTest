//
//  ApplicationAlert.swift
//

import UIKit

final class ApplicationAlert: Alert {
    
    func show(
        on viewController: UIViewController,
        title: String?,
        message: String?,
        style: UIAlertController.Style,
        actions: [UIAlertAction]
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        
        if actions.isEmpty {
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
        } else {
            actions.forEach(alert.addAction)
        }
        
        viewController.present(alert, animated: true, completion: nil)
    }
}
