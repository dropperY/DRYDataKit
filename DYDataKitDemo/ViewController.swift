//
//  ViewController.swift
//  DYDataKitDemo
//
//  Created by yexiaocheng on 2016/11/1.
//  Copyright © 2016年 dropperY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("new person")
        let p = Person()
        p.age = 20
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

