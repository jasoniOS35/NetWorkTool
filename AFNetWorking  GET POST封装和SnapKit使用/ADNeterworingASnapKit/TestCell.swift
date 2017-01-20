//
//  TestCell.swift
//  ADNeterworingASnapKit
//
//  Created by tc on 2017/1/18.
//  Copyright © 2017年 tc. All rights reserved.
//

import UIKit

class TestCell: UITableViewCell {

    var screenBounds = UIScreen.main.bounds

    var model : HomeModel? {
        
        didSet {
            titleLab.text = model?.kcbz
            contentLab.text = model?.kcmc
        }
    }
    
   fileprivate var iconImg = UIImageView()
    
   fileprivate var titleLab = UILabel()
    
   fileprivate var contentLab = UILabel()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
       super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        setUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TestCell {
    
   fileprivate func setUI(){
        
        contentView.addSubview(iconImg)
        iconImg.image = UIImage(named: "ziyouxie02")
        iconImg.snp.makeConstraints { (make) in
            
           make.centerX.equalTo(35)
           make.centerY.equalTo(contentView)
           make.width.height.equalTo(50)
        }
        
        contentView.addSubview(titleLab)
        titleLab.numberOfLines = 0
        titleLab.backgroundColor = UIColor.gray
        titleLab.snp.makeConstraints { (make) in
            
            make.left.equalTo(iconImg.snp.right).offset(20)
            make.top.equalTo(contentView).offset(10)
            make.width.equalTo(screenBounds.width - 90)
        }
        titleLab.sizeToFit()

        contentView.addSubview(contentLab)
        contentLab.numberOfLines = 0
        contentLab.textColor = UIColor.red
        contentLab.snp.makeConstraints { (make) in
            
            make.top.equalTo(titleLab.snp.bottom).offset(10)
            make.width.equalTo(titleLab)
            make.left.equalTo(titleLab)
            make.bottom.equalTo(-10)
        }
        contentLab.sizeToFit()

    }
}
