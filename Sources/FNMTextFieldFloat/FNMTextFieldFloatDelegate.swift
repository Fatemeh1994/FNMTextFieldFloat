//
//  File.swift
//  
//
//  Created by Reza Khonsari on 4/14/21.
//

import UIKit

public protocol FNMTextFieldFloatDelegate: class {
    func didEndEditing(_ textField: FNMTextFieldFloat)
    func editingChange(_ textField: FNMTextFieldFloat, text: String)
}
