//
//  ViewController.swift
//  NumberField
//
//  Created by YehYungCheng on 2016/7/15.
//  Copyright © 2016年 YehYungCheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var numberField: NumberField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        numberField.isSupportFloat = true
        
        let label = UILabel()
        label.text = "Help text!"
        numberField.helpLabel = label
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

