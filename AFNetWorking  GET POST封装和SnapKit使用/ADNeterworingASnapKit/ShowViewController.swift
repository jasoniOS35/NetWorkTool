//
//  ShowViewController.swift
//  ADNeterworingASnapKit
//
//  Created by tc on 2017/1/18.
//  Copyright © 2017年 tc. All rights reserved.
//

import UIKit
import MJRefresh
class ShowViewController: UIViewController {

    var screenBounds = UIScreen.main.bounds
    
    var page = 1
    
    
    lazy var tableView :UITableView = UITableView()
    
    lazy var dataArray = [HomeModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //获取数据源
        getDataSourse()
        
        //设置界面
        setUI()
        
        //tableView的上拉刷新和下拉加载
        tableViewRefresh()
        
    }
    
    deinit {
        print("ShowViewController 销毁了")
    }

}

// MARK:-UI界面

extension ShowViewController {
    
    func setUI(){
        
        view.addSubview(tableView)
        tableView.frame = CGRect(x :0, y :0, width :screenBounds.width, height :screenBounds.height)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 500
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.register(TestCell.self , forCellReuseIdentifier: "ID")

    }
}
// MARK:-tableView的上拉刷新 下拉加载

extension ShowViewController {
    
    func tableViewRefresh(){
        
        //执行对应的函数
        
        //        tableView.mj_header =  MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(ShowViewController.headerRefresh))
        
        //        tableView.mj_footer =  MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(ShowViewController.footerRefresh))
        
        
        //        weak var weakSelf = self  两种方式都可以解决循环引用
        
        
        //闭包的形式
        
        tableView.mj_header = MJRefreshNormalHeader( refreshingBlock: {[weak self]() -> Void in
            print("MJ:(下拉刷新)")
            self?.page = 1
            self?.getDataSourse()
            self?.tableView.mj_footer.resetNoMoreData()
            self?.tableView.mj_header.endRefreshing()
            
        })
        
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {[weak self]()->Void in
            
            print("MJ:(上拉加载)")
            if self?.page == 3{
                self?.tableView.mj_footer.endRefreshingWithNoMoreData()
                return
            }
            self?.page += 1
            self?.getDataSourse()
            self?.tableView.mj_footer.endRefreshing()
            
        })

    }
}

// MARK:-tableView的代理方法

extension ShowViewController :UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ID", for: indexPath) as! TestCell
        
        let model = dataArray[indexPath.row]
        
        cell.model = model
        
        cell.selectionStyle = .none
        return cell
    }
    /*
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let model = dataArray[indexPath.row]

        let kcbzH =  Tools.getTextHeigh(textStr: model.kcbz, font: UIFont.systemFont(ofSize: 17), width: screenBounds.width - 90.0)
        
        let kcmcH  = Tools.getTextHeigh(textStr: model.kcmc, font: UIFont.systemFont(ofSize: 17), width: screenBounds.width - 90.0)
        
        return kcbzH + kcmcH + 30
    }
 */
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("选择  \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("取消选择 \(indexPath.row)")
    }
}
// MARK:-获取数据

extension ShowViewController {
    
    
   fileprivate func getDataSourse(){
        
        NetWorkTools.shareInstance.request(requestType: .GET, url: "http://www.zimozibao.com:8080/zimoAppWS/cxf/rest/kecheng/getallKecheng?_type=json&index=\(page)&size=5", parameters: nil, succeed: {
            (objc) in
            print(objc!)
            
            let arr : [[String:AnyObject]] = objc!["data"] as! [[String : AnyObject]]
            
            if self.page == 1{
                self.dataArray.removeAll()
            }
            for dic in arr {
                
                let model = HomeModel()
                model.mj_setKeyValues(dic)
                self.dataArray.append(model)
            }
            
            
            self.tableView.reloadData()
            print(self.dataArray.count)
            
            
        }, failure: {
            (error) in

            print(error!)
        })

    }

}
// MARK:-刷新事件

extension ShowViewController {
    
        
    func headerRefresh(){
        print("下拉刷新")
        page = 1
        getDataSourse()
    }
    
    func footerRefresh(){
        print("下拉加载")
        if self.page == 3{
            
            self.tableView.mj_footer.endRefreshingWithNoMoreData()

            return
        }
        page += 1
        getDataSourse()
    }
}
