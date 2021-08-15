//
//  CustomCheckAnswerButton.swift
//  State Capitals Quiz
//
//  Created by Stacey Moore on 3/31/21.
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setButton()
    }
    
    func setButton() {
        setShadow()
        setTitleColor(.white, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius  = frame.size.height / 2
        layer.masksToBounds = false
        layer.borderWidth   = 0.1
        layer.borderColor   = UIColor.darkGray.cgColor
    }
    
    private func setShadow() {
        layer.shadowColor   = UIColor.black.cgColor
        layer.shadowOffset  = CGSize(width: 0.0, height: 2.0)
        layer.shadowRadius  = 8
        layer.shadowOpacity = 0.2
        clipsToBounds       = true
        layer.masksToBounds = false
    }
}
