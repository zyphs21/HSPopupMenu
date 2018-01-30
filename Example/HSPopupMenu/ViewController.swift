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

    var menuArray: [HSMenu] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor.cyan
        
        let menu1 = HSMenu(icon: nil, title: "测试啊")
        let menu2 = HSMenu(icon: nil, title: "测试测试")
        let menu3 = HSMenu(icon: nil, title: "测试啊")
        let menu4 = HSMenu(icon: nil, title: "测试啊")
        menuArray = [menu1, menu2, menu3, menu4]
        
        self.title = "HSPopupMenu"
        self.createBarBtnItem(image: UIImage(named: "barbuttonicon_add")!, method: #selector(popMenu1))
        self.createBarBtnItem(image: UIImage(named: "barbuttonicon_add")!, method: #selector(popMenu2), isLeft: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func createBarBtnItem(image: UIImage, method: Selector, isLeft: Bool = false) {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        button.addTarget(self, action: method, for: .touchUpInside)
        button.setImage(image, for: .normal)
        let barButtonItem = UIBarButtonItem(customView: button)
        
        if isLeft {
            self.navigationItem.leftBarButtonItem = barButtonItem
        } else {
            self.navigationItem.rightBarButtonItem = barButtonItem
        }
    }
    
    @objc func popMenu1() {
        let popupMenu = HSPopupMenu(menuArray: menuArray, arrowPoint: CGPoint(x: UIScreen.main.bounds.width-35, y: 64))
        popupMenu.popUp()
    }
    
    @objc func popMenu2() {
        let popupMenu = HSPopupMenu(menuArray: menuArray, arrowPoint: CGPoint(x: 35, y: 64), arrowPosition: .left)
        popupMenu.popUp()
    }

}

