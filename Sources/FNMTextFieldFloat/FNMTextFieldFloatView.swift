//
//  FNMTextFieldFloatView.swift
//  
//
//  Created by Reza Khonsari on 4/13/21.
//

import UIKit

open class FNMTextFieldFloatView: UIView {
    
    private var textFieldFloat = FNMTextFieldFloat()
    private var floatingLabel = UILabel(frame: CGRect.zero)
    
    
    @IBInspectable
    public var cornerRadius: CGFloat = .zero {
        didSet {
            layoutIfNeeded()
        }
    }
    
    @IBInspectable
    public var placeholder: String? {
        didSet {
            textFieldFloat.placeholder = placeholder
        }
    }
    
    @IBInspectable
    public var floatingLabelColor: UIColor = UIColor.black {
        didSet {
            self.floatingLabel.textColor = floatingLabelColor
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable
    public var activeBorderColor: UIColor = UIColor.blue {
        didSet {
            textFieldFloat.layer.borderColor = activeBorderColor.cgColor
        }
    }
    
    @IBInspectable
    public var activeBorderWidth: CGFloat = .zero {
        didSet {
            textFieldFloat.layer.borderWidth = activeBorderWidth
        }
    }
    
    @IBInspectable
    public var floatingLabelBackground: UIColor = .white {
        didSet {
            floatingLabel.backgroundColor = self.floatingLabelBackground
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    public var labelsFont: UIFont = UIFont.systemFont(ofSize: 14) {
        didSet {
            floatingLabel.font = labelsFont
            textFieldFloat.font = labelsFont
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    public var isSecure: Bool = false {
        didSet {
            textFieldFloat.isSecureTextEntry = isSecure
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        clipsToBounds = false
        addSubview(textFieldFloat)
        textFieldFloat.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textFieldFloat.topAnchor.constraint(equalTo: topAnchor),
            textFieldFloat.bottomAnchor.constraint(equalTo: bottomAnchor),
            textFieldFloat.leadingAnchor.constraint(equalTo: leadingAnchor),
            textFieldFloat.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        floatingLabel = UILabel(frame: CGRect.zero)
        floatingLabel.backgroundColor = floatingLabelBackground
        textFieldFloat.addTarget(self, action: #selector(self.addFloatingLabel), for: .editingDidBegin)
        textFieldFloat.addTarget(self, action: #selector(self.removeFloatingLabel), for: .editingDidEnd)
    
    }
    
    // Add a floating label to the view on becoming first responder
    @objc func addFloatingLabel() {
        if textFieldFloat.text?.isEmpty == true {
            self.floatingLabel.textColor = floatingLabelColor
            self.floatingLabel.font = labelsFont
            self.floatingLabel.text = placeholder
            self.floatingLabel.translatesAutoresizingMaskIntoConstraints = false
            self.floatingLabel.textAlignment = .center
            addSubview(floatingLabel)
            layoutIfNeeded()
            let fontSize = (textFieldFloat.font?.pointSize ?? .zero)/2
            let widthConstraint = floatingLabel.widthAnchor.constraint(equalToConstant: 2 + floatingLabel.bounds.width + 2)
            widthConstraint.priority = .defaultHigh
            NSLayoutConstraint.activate([
                floatingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: textFieldFloat.totalInsets.left),
                floatingLabel.bottomAnchor.constraint(equalTo: topAnchor, constant: fontSize),
                widthConstraint
            ])
            textFieldFloat.placeholder = ""
            bringSubviewToFront(floatingLabel)
        }
        textFieldFloat.layoutIfNeeded()
    }
    
    @objc func removeFloatingLabel() {
        if textFieldFloat.text?.isEmpty == true {
            UIView.animate(withDuration: 0.13) { [self] in
                floatingLabel.removeFromSuperview()
                textFieldFloat.setNeedsDisplay()
            }
            textFieldFloat.placeholder = placeholder
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        textFieldFloat.layer.cornerRadius = cornerRadius
    }
}

