//
//  Tools.swift
//  ADNeterworingASnapKit
//
//  Created by tc on 2017/1/18.
//  Copyright © 2017年 tc. All rights reserved.
//

import UIKit

class Tools: NSObject {

    
    
 }

// MARK:-计算文字高度

extension Tools {
    
   static func getTextHeigh(textStr:String,font:UIFont,width:CGFloat) -> CGFloat {
        
        let normalText: NSString = textStr as NSString
        let size = CGSize(width :width, height :1000)
        let dic = NSDictionary(object: font, forKey: NSFontAttributeName as NSCopying)
        let stringSize = normalText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [String : AnyObject], context:nil).size
        
        return stringSize.height
    }

}
