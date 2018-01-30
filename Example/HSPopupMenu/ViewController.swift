//
//  ViewController.swift
//  HSPopupMenu
//
//  Created by zyphs21 on 01/30/2018.
//  Copyright (c) 2018 zyphs21. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func createRightBarBtnItem(image: UIImage, method: Selector) {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        button.addTarget(self, action: method, for: .touchUpInside)
        button.setImage(image, for: .normal)
        let rightBarButtonItem = UIBarButtonItem(customView: button)
        
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }

}

