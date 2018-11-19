//
//  BaseView.swift
//  VidooApp
//
//  Created by Lê Tuyên on 10/18/18.
//  Copyright © 2018 eZLO. All rights reserved.
//

import UIKit

class BaseView: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        
    }

}

class BaseHeaderAndFooterView: UITableViewHeaderFooterView {
    
    public var didsetupview = false
    public var didLoadView = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        if !didsetupview {
            setupView()
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        if !didsetupview {
            setupView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if !didLoadView {
            loadedView()
        }
    }
    
    func setupView() {
        didsetupview = true
    }
    
    func loadedView() {
        didLoadView = true
    }
}

class BaseTableCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        
    }
}


extension UIView {
    static func loadfromxib() -> UIView? {
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?.first as? UIView
    }
    
    func makeRound() {
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
    }
    
    func makeRoundAndBorder() {
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
        layer.borderWidth = 1
        layer.borderColor = CommonConstants.borderColor.cgColor
    }
    
    func makeRoundAndBorder(color: UIColor) {
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
        layer.borderWidth = 1
        layer.borderColor = color.cgColor
    }
}
