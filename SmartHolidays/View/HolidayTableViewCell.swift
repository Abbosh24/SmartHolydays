//
//  HolidayTableViewCell.swift
//  SmartHolidays
//
//  Created by 1 on 9/9/19.
//  Copyright © 2019 1. All rights reserved.
//

import UIKit


class HolidayTableViewCell: UITableViewCell {
    
    let APP_FONT = UIFont(name: "Avenir-Medium", size: 20)

    lazy var localNameLabel: UILabel = {
        return customLabel(APP_FONT!, .blue)
    }()
    
    lazy var dateLabel: UILabel = {
        return customLabel(APP_FONT!, .orange)
    }()
    
    func customLabel(_ font: UIFont ,_ color: UIColor) -> UILabel {
        let label = UILabel()
        label.font = font
        label.numberOfLines = 2
        label.textColor = color
        return label
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.addSubview(localNameLabel)
        contentView.addSubview(dateLabel)
        
        localNameLabel.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        dateLabel.snp.makeConstraints { (make) in
            make.right.bottom.equalToSuperview().offset(-10)
        }
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    
}
