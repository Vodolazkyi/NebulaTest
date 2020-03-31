import UIKit

protocol SpinnerPresentable {
    
    var spinner: Spinner { get }
    
    func showSpinner(with text: String?, blockUI: Bool, indicatorColor: UIColor)
    func hideSpinner()
}

extension SpinnerPresentable where Self: UIViewController {
    
    func showSpinner(with text: String? = nil, blockUI: Bool = true, indicatorColor: UIColor = .blue) {
        spinner.show(on: view, text: text, blockUI: blockUI, indicatorColor: indicatorColor)
    }
    
    func hideSpinner() {
        spinner.hide(from: view)
    }
    
}
