import UIKit

protocol Spinner {
    
    func show(on view: UIView, text: String?, blockUI: Bool, indicatorColor: UIColor)
    func hide(from view: UIView)
}
