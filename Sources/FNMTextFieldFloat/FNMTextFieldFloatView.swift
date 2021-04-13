//
//  FNMTextFieldFloatView.swift
//  
//
//  Created by Reza Khonsari on 4/13/21.
//

import UIKit

open class FNMTextFieldFloatView: UIView {
    
    public weak var delegate: FNMTextFieldFloatDelegate?
    
    private var textFieldFloat = FNMTextFieldFloat()
    private var floatingLabel = UILabel(frame: .zero)
    private var errorLabel = UILabel(frame: .zero)
    
    
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
    public var activeColor: UIColor = UIColor.blue {
        didSet {
            textFieldFloat.layer.borderColor = activeColor.cgColor
        }
    }
    
    @IBInspectable
    public var inactiveColor: UIColor = UIColor.blue {
        didSet {
            textFieldFloat.layer.borderColor = inactiveColor.cgColor
        }
    }
    
    @IBInspectable
    public var errorColor: UIColor = UIColor.blue
    
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
    public var labelsFont: UIFont = UIFont.systemFont(ofSize: 12) {
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
        textFieldFloat.addTarget(self, action: #selector(addFloatingLabel), for: .editingDidBegin)
        textFieldFloat.addTarget(self, action: #selector(removeFloatingLabel), for: .editingDidEnd)
        textFieldFloat.addTarget(self, action: #selector(removeFloatingLabel), for: .editingDidEndOnExit)
        textFieldFloat.addTarget(self, action: #selector(editingChange(_:)), for: .editingChanged)
    
    }
    
    @objc private func editingChange(_ textField: FNMTextFieldFloat) {
        delegate?.editingChange(textField, text: textField.text ?? "")
    }

    
    // Add a floating label to the view on becoming first responder
    @objc private func addFloatingLabel() {
        if textFieldFloat.text?.isEmpty == true {
            self.floatingLabel.textColor = floatingLabelColor
            self.floatingLabel.font = labelsFont
            self.floatingLabel.text = placeholder
            self.floatingLabel.translatesAutoresizingMaskIntoConstraints = false
            self.floatingLabel.textAlignment = .center
            addSubview(floatingLabel)
            layoutIfNeeded()
            let fontSize = (textFieldFloat.font?.pointSize ?? .zero)/2
            let widthConstraint = floatingLabel.widthAnchor.constraint(equalToConstant: 3 + floatingLabel.bounds.width + 3)
            widthConstraint.priority = .defaultHigh
            NSLayoutConstraint.activate([
                floatingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: textFieldFloat.totalInsets.left),
                floatingLabel.bottomAnchor.constraint(equalTo: topAnchor, constant: fontSize),
                widthConstraint
            ])
            textFieldFloat.placeholder = ""
            bringSubviewToFront(floatingLabel)
            textFieldFloat.layer.borderColor = activeColor.cgColor
        } else {
        }
        textFieldFloat.layoutIfNeeded()
    }
    
    @objc private func removeFloatingLabel() {
        if textFieldFloat.text?.isEmpty == true {
            UIView.animate(withDuration: 0.13) { [self] in
                floatingLabel.removeFromSuperview()
                textFieldFloat.setNeedsDisplay()
            }
            textFieldFloat.placeholder = placeholder
            textFieldFloat.layer.borderColor = inactiveColor.cgColor
        }
        delegate?.didEndEditing(textFieldFloat)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        textFieldFloat.layer.cornerRadius = cornerRadius
    }
    
    public func showError(message: String) {
        if errorLabel.superview == nil {
            addSubview(errorLabel)
            errorLabel.translatesAutoresizingMaskIntoConstraints = false
            errorLabel.font = UIFont.systemFont(ofSize: 10)
            let errorLabelPointSize = errorLabel.font.pointSize
            NSLayoutConstraint.activate([
                errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
                errorLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 3 + errorLabelPointSize)
            ])
        }
        errorLabel.text = message
        errorLabel.textColor = errorColor
        textFieldFloat.layer.borderColor = errorColor.cgColor
        floatingLabel.textColor = errorColor
    }
    
    public func hideError() {
        errorLabel.removeFromSuperview()
        textFieldFloat.layer.borderColor = activeColor.cgColor
        floatingLabel.textColor = activeColor
    }
}

