//
//  HSPopupMenuCell.swift
//  HSPopupMenu
//
//  Created by Hanson on 2018/1/30.
//

import UIKit
import SnapKit

class HSPopupMenuCell: UITableViewCell {

    lazy var iconView: UIImageView = UIImageView()
    lazy var titleLabel: UILabel = UILabel()
    lazy var line: UIView = UIView()

    
    // MARK: - Initialization
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: - Function

extension HSPopupMenuCell {
    
    private func setUpCell() {
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .center
        self.backgroundColor = UIColor.clear
        self.contentView.addSubview(self.iconView)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.line)
        
        iconView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(8)
            make.left.equalTo(10)
            make.width.equalTo(iconView.snp.height)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconView.snp.right)
            make.top.bottom.equalToSuperview().inset(5)
            make.right.equalTo(-5)
        }
        line.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(10)
            make.height.equalTo(0.5)
        }
    }
}


extension HSPopupMenuCell {
    
    func configureCell(menu: HSMenu) {
        titleLabel.text = menu.title
        
        if let icon = menu.icon {
            iconView.image = icon
            
        } else {
            iconView.isHidden = true
            titleLabel.snp.remakeConstraints({ (make) in
                make.left.right.equalToSuperview().inset(8)
                make.top.bottom.equalToSuperview().inset(5)
            })
        }
    }
}

