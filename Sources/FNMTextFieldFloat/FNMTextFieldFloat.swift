//
//  SceneDelegate.swift
//  FNMTextFieldDemo
//
//  Created by Reza Khonsari on 4/13/21.
//

import UIKit

public class FNMTextFieldFloat: UITextField {
    
    var totalInsets = UIEdgeInsets(top: .zero, left: 20, bottom: .zero, right: 20)
    var floatingLabelHeight: CGFloat = 14
    var button = UIButton(type: .custom)
    var imageView = UIImageView(frame: CGRect.zero)
    
    func addViewPasswordButton() {
        self.button.setImage(UIImage(named: "ic_reveal"), for: .normal)
        self.button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.button.frame = CGRect(x: 0, y: 16, width: 22, height: 16)
        self.button.clipsToBounds = true
        self.rightView = self.button
        self.rightViewMode = .always
        self.button.addTarget(self, action: #selector(self.enablePasswordVisibilityToggle), for: .touchUpInside)
    }
    
    func addImage(image: UIImage) {
        
        self.imageView.image = image
        self.imageView.frame = CGRect(x: 20, y: 0, width: 20, height: 20)
        self.imageView.translatesAutoresizingMaskIntoConstraints = true
        self.imageView.contentMode = .scaleAspectFit
        self.imageView.clipsToBounds = true
        
        DispatchQueue.main.async { [self] in
            leftView = imageView
            leftViewMode = .always
        }
        
    }
    
    @objc func enablePasswordVisibilityToggle() {
        isSecureTextEntry.toggle()
        if isSecureTextEntry {
            self.button.setImage(UIImage(named: "ic_show"), for: .normal)
        }else{
            self.button.setImage(UIImage(named: "ic_hide"), for: .normal)
        }
    }
    
    func setInsets(for bounds: CGRect) -> CGRect {
        bounds.inset(by: totalInsets)
    }
    
    public override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        setInsets(for: bounds)
    }
    
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        setInsets(for: bounds)
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        setInsets(for: bounds)
    }
}
