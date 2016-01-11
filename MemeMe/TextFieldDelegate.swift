//
//  TextFieldDelegate.swift
//  MemeMe
//
//  Created by Ian Kennedy on 11/5/15.
//  Copyright © 2015 Udacity. All rights reserved.
//

import Foundation
import UIKit

class TextFieldDelegate: NSObject, UITextFieldDelegate {
    
    var textIsDefault: Bool = true
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.autocorrectionType = UITextAutocorrectionType.No
        if textIsDefault {
            textField.text = ""
            textIsDefault = false
        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return true
    }

}
