//
//  NiblessController.swift
//
//  Created by Vodolazkyi Anton on 1/28/19.
//

import UIKit

class NiblessController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
        
    @available(*, unavailable, message: "Loading this controller from a nib is unsupported in favor of initializer dependency injection.")
    required init?(coder aDecoder: NSCoder) {
        fatalError("Loading this controller from a nib is unsupported in favor of initializer dependency injection.")
    }
}
