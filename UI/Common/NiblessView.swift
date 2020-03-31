//
//  NiblessView.swift
//  UI
//
//  Created by Vodolazkyi Anton on 12/18/18.
//

import UIKit

open class NiblessView: UIView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable, message: "Loading this view from a nib is unsupported in favor of initializer dependency injection.")
    required
    public init?(coder aDecoder: NSCoder) {
        fatalError("Loading this view from a nib is unsupported in favor of initializer dependency injection.")
    }
}
