//
//  File.swift
//  
//
//  Created by Reza Khonsari on 4/14/21.
//

import UIKit

public protocol FNMTextFieldFloatDelegate: class {
    func didBeginEditing(_ textField: FNMTextFieldFloat, view: FNMTextFieldFloatView)
    func didEndEditing(_ textField: FNMTextFieldFloat, view: FNMTextFieldFloatView)
    func editingChange(_ textField: FNMTextFieldFloat, view: FNMTextFieldFloatView, text: String)
}
