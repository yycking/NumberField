//
//  NumberField.swift
//  NumberField
//
//  Created by YehYungCheng on 2016/7/15.
//  Copyright © 2016年 YehYungCheng. All rights reserved.
//

import UIKit

public protocol NumberFieldDelegate: class {
    func numberField(numberField: NumberField, willChangeToValue: String?) -> Bool
    func numberField(numberField: NumberField, didChangeToValue: String?)
}

@IBDesignable public class NumberField: UITextField, UITextFieldDelegate {
    public var helpLabel: UILabel?
    public var isFloat: Bool = false
    public var numberDeledgate: NumberFieldDelegate?
    public var toolBar: UIToolbar?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    // Default if using story board
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    private func setup() {
        self.delegate = self
    }
    
    // MARK: - UITextFieldDelegate
    
    public func textFieldDidBeginEditing(textField: UITextField) {
        var items = [UIBarButtonItem]()
        if let label = helpLabel {
            label.sizeToFit()
            items.append(UIBarButtonItem(customView: label))
        }
        items += [
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: #selector(UITextField.resignFirstResponder))
        ]
        
        let helpBar = UIToolbar()
        helpBar.frame.size.height = 44
        helpBar.items = items
        
        var height: CGFloat = 0
        
        let accessoryView = UIView()
        if let tool = toolBar {
            accessoryView.addSubview(tool)
            height = tool.frame.height
        }
        accessoryView.addSubview(helpBar)
        height += helpBar.frame.height
        accessoryView.frame.size = CGSizeMake(320, height)
        textField.inputAccessoryView = helpBar
        
        if isFloat {
            textField.keyboardType = UIKeyboardType.DecimalPad
        } else {
            textField.keyboardType = UIKeyboardType.NumberPad
        }
    }
    
    public func textFieldDidEndEditing(textField: UITextField) {
        textField.resignFirstResponder()
        
        if let function = numberDeledgate?.numberField(_: didChangeToValue:) {
            function(self, didChangeToValue: textField.text)
        }
    }
    
    public func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var newString = string
        if let text = textField.text {
            newString = (text as NSString).stringByReplacingCharactersInRange(range, withString: string)
        }
        
        if newString.isEmpty {
            return true
        }
        
        let scanner: NSScanner = NSScanner(string: newString)
        
        if isFloat {
            if (scanner.scanDecimal(nil) && scanner.atEnd) == false {
                return false
            }
        } else {
            if (scanner.scanInt(nil) && scanner.atEnd) == false {
                return false
            }
        }
        
        if let function = numberDeledgate?.numberField(_: willChangeToValue:) {
            return function(self, willChangeToValue: textField.text)
        }
        
        return true
    }
}
