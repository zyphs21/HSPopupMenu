//
//  ViewController.swift
//  HSPopupMenu
//
//  Created by zyphs21 on 01/30/2018.
//  Copyright (c) 2018 zyphs21. All rights reserved.
//

import UIKit
import HSPopupMenu

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor.cyan
        
        self.title = "HSPopupMenu"
        self.createRightBarBtnItem(image: UIImage(named: "barbuttonicon_add")!, method: #selector(popMenu))
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
    
    @objc func popMenu() {
        let menu1 = HSMenu(icon: nil, title: "测试啊")
        let menu2 = HSMenu(icon: nil, title: "测试测试")
        let menu3 = HSMenu(icon: nil, title: "测试啊")
        let menu4 = HSMenu(icon: nil, title: "测试啊")
        
        let popupMenu = HSPopupMenu(menuArray: [menu1, menu2, menu3, menu4], arrowPoint: CGPoint(x: UIScreen.main.bounds.width-25, y: 64))
        popupMenu.popUp()
    }

}

