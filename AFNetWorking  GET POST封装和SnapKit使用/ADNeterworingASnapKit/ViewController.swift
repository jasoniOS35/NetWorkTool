//
//  ViewController.swift
//  ADNeterworingASnapKit
//
//  Created by tc on 2017/1/17.
//  Copyright © 2017年 tc. All rights reserved.
//

import UIKit
import SnapKit
import AFNetworking
import MJExtension
class ViewController: UIViewController {

    
   lazy var phoneTextTF = UITextField()
    
   lazy var dataArray = [HomeModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.init(white: 0.9, alpha: 0.9)
        title = "登录"
        
        setPhoneView()
        
        
        let dic = ["loginid":"861809565702204375","smark":"1"] as [String : String]
        
        let img = UIImage(named: "suijilight")
        
        
        NetWorkTools.shareInstance.unload(urlString: "http://www.zimozibao.com:8080/zimoAppWS/cxf/rest/userinfo/upload", parameters: dic as AnyObject?, img: img!, uploadProgress: {
            
            (progress) in //上传进度
            print(progress.completedUnitCount)
            print(progress.totalUnitCount)
            
        }, success:  {
            
            (objc) in
            print(objc!)
            
        }, failure: {
            
            (error) in
            print(error)
        })
    }
    
    
    


}


// MARK:-设置UI界面

extension ViewController {
    
   func setPhoneView(){
        
        let phoneView = UIView()
        view .addSubview(phoneView)
        
        phoneView.snp.makeConstraints { (make) in
            
            make.left.equalTo(view).offset(-1)
            make.right.equalTo(view).offset(1)
            make.top.equalTo(view).offset(180)
            make.height.equalTo(50)
        }
//        phoneView.backgroundColor = UIColor.lightGray
        phoneView.layer.borderWidth = 0.5
        phoneView.layer.borderColor = UIColor.gray.cgColor
        
        let iconImg = UIImageView()
        phoneView.addSubview(iconImg)
        
        iconImg.snp.makeConstraints { (make) in
            make.left.equalTo(phoneView).offset(10)
            make.top.equalTo(phoneView).offset(10)
            make.width.height.equalTo(30)
        }
        iconImg.image = UIImage(named: "genwoxue02")
        
        
        let line = UILabel()
        phoneView.addSubview(line)
        
        line.backgroundColor = UIColor.lightGray

        line.snp.makeConstraints { (make) in
            make.top.equalTo(phoneView).offset(5)
            make.bottom.equalTo(phoneView).offset(-5)
            make.right.equalTo(iconImg).offset(35)
            make.width.equalTo(1)
        }
        
        phoneView.addSubview(phoneTextTF)
        
        phoneTextTF.snp.makeConstraints { (make) in
            
            make.top.equalTo(phoneView)
            make.left.equalTo(line).offset(15)
            make.bottom.equalTo(phoneView)
            make.right.equalTo(phoneView)
        }
        
        phoneTextTF.placeholder = "请输入手机号"
        phoneTextTF.keyboardType = .phonePad
        
        
        
        let loginButt = UIButton()
        view.addSubview(loginButt)
        
        loginButt.snp.makeConstraints { (make) in
            
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.top.equalTo(phoneView).offset(150)
            make.height.equalTo(50)
            
        }
        loginButt.backgroundColor = UIColor.orange
        
        loginButt.addTarget(self, action: #selector(ViewController.loginClick), for: .touchUpInside)
        
        loginButt.setTitle("登录", for: .normal)
    
    }
    
    
}
// MARK:-响应事件

extension ViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        view.endEditing(true)
    }
    
    func loginClick(){
        
        print("点击了登录")
        
        navigationController?.pushViewController(ShowViewController(), animated: true)
        
    }
}
