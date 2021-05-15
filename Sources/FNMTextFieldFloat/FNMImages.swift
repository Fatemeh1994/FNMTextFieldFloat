//
//  File.swift
//  
//
//  Created by Reza Khonsari on 5/15/21.
//

import UIKit

enum FNMImages: String {
    case hide, show
    
    var image: UIImage {
        UIImage(named: self.rawValue, in: .module, compatibleWith: nil)!
    }
}
