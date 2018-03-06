//
//  HSPopupMenu.swift
//  HSPopupMenu
//
//  Created by Hanson on 2018/1/30.
//

import Foundation


// MARK: - HSMenu

public struct HSMenu {
    var icon: UIImage?
    var title: String?
    
    public init(icon: UIImage?, title: String?) {
        self.icon = icon
        self.title = title
    }
}


// MARK: - HSPopupMenuDelegate

@objc public protocol HSPopupMenuDelegate {
    
    func popupMenu(_ popupMenu: HSPopupMenu, didSelectAt index: Int)
}


// MARK: - HSPopupMenu

public enum HSPopupMenuArrowPosition {
    case left
    case right
}

public class HSPopupMenu: UIView {
    
    var menuCellSize: CGSize = CGSize(width: 130, height: 44)
    var menuTextFont: UIFont = .systemFont(ofSize: 15)
    var menuTextColor: UIColor = .black
    var menuBackgroundColor: UIColor = .white
    var menuLineColor: UIColor = .black
    
    var tableViewStartPoint: CGPoint = .zero
    var arrowWidth: CGFloat = 10
    var arrowHeight: CGFloat = 10
    var arrowOffset: CGFloat = 10
    var arrowPoint: CGPoint = .zero
    var arrowPosition: HSPopupMenuArrowPosition = .right
    
    var contentBgColor: UIColor = UIColor.black.withAlphaComponent(0.6)
    
    public weak var delegate: HSPopupMenuDelegate?
    
    fileprivate let CellID = "HSPopupMenuCell"

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.bounces = false
        tableView.layer.cornerRadius = 5
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.register(HSPopupMenuCell.self, forCellReuseIdentifier: CellID)
        return tableView
    }()
    
    var menuArray: [HSMenu] = [] {
        didSet{
            self.tableView.reloadData()
        }
    }
    
    
    // MARK: - Initialization
    
    public init(menuArray: [HSMenu], arrowPoint: CGPoint,
         cellSize: CGSize = CGSize(width: 130, height: 44),
         arrowPosition: HSPopupMenuArrowPosition = .right,
         frame: CGRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)) {
        
        super.init(frame: frame)
        
        self.arrowPoint = arrowPoint
        self.menuCellSize = cellSize
        self.arrowPosition = arrowPosition
        self.backgroundColor = contentBgColor
        
        switch arrowPosition {
        case .left:
            let x = arrowPoint.x - arrowWidth/2 - arrowOffset
            let y = arrowPoint.y + arrowHeight
            tableViewStartPoint = CGPoint(x: x, y: y)
            tableView.frame = CGRect(x: x,
                                     y: y,
                                     width: cellSize.width,
                                     height: cellSize.height*CGFloat(menuArray.count))
        case .right:
            let x = arrowPoint.x + arrowWidth/2 + arrowOffset
            let y = arrowPoint.y + arrowHeight
            tableViewStartPoint = CGPoint(x: x, y: y)
            tableView.frame = CGRect(x: x,
                                     y: y,
                                     width: -cellSize.width,
                                     height: cellSize.height*CGFloat(menuArray.count))
        }
        
        self.addSubview(tableView)
        
        self.menuArray = menuArray
        
        let window = UIApplication.shared.keyWindow
        window?.addSubview(self)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.beginPath()
        if self.arrowPosition == .left {
            let startX = self.arrowPoint.x - arrowWidth/2
            let startY = self.arrowPoint.y + arrowHeight
            context?.move(to: CGPoint(x: startX, y: startY))
            context?.addLine(to: CGPoint(x: self.arrowPoint.x, y: self.arrowPoint.y))
            context?.addLine(to: CGPoint(x: startX + arrowWidth, y: startY))
        } else {
            let startX = self.arrowPoint.x + arrowWidth/2
            let startY = self.arrowPoint.y + arrowHeight
            context?.move(to: CGPoint(x: startX, y: startY))
            context?.addLine(to: CGPoint(x: self.arrowPoint.x, y: self.arrowPoint.y))
            context?.addLine(to: CGPoint(x: startX - arrowWidth, y: startY))
        }
        context?.closePath()
        self.tableView.backgroundColor?.setFill()
        self.tableView.backgroundColor?.setStroke()
        context?.drawPath(using: .fillStroke)
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss()
    }
}


// MARK: - Public Function

extension HSPopupMenu {
    
    public func popUp() {
        let frame = self.tableView.frame
        self.tableView.frame = CGRect(x: tableViewStartPoint.x, y: tableViewStartPoint.y, width: 0, height: 0)
        UIView.animate(withDuration: 0.2) {
            self.tableView.frame = frame
        }
    }
    
    public func dismiss() {
        UIView.animate(withDuration: 0.2, animations: {
            self.tableView.frame = CGRect(x: self.tableViewStartPoint.x, y: self.tableViewStartPoint.y, width: 0, height: 0)
        }) { (finished) in
            self.removeFromSuperview()
        }
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource

extension HSPopupMenu: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuArray.count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.menuCellSize.height
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID, for: indexPath) as! HSPopupMenuCell
        let menu = self.menuArray[indexPath.row]
        cell.configureCell(menu: menu)
        cell.titleLabel.font = menuTextFont
        cell.titleLabel.textColor = menuTextColor
        cell.line.isHidden = (indexPath.row < menuArray.count - 1) ? false : true
        cell.line.backgroundColor = menuLineColor
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.dismiss()
        self.delegate?.popupMenu(self, didSelectAt: indexPath.row)
    }
}
