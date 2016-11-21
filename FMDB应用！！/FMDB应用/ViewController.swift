//
//  ViewController.swift
//  FMDB应用
//
//  Created by 俊杰 on 16/11/10.
//  Copyright © 2016年 JunJie. All rights reserved.
//

import UIKit


class ViewController: UITableViewController {
    
    var datasource : [User] = [User]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestData()
    }
    
    func requestData() -> () {
        let cellMode = CustomCellMode()
        cellMode.fetchDatasource { (users) in
            self.datasource = users
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "item", for: indexPath) as! CustomCell
        
        // 1.取出数据模型
        let user = datasource[indexPath.row]
        
        // 2.展示数据
        cell.user = user
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // 1.取出数据模型
        let user = datasource[indexPath.row]
        let text = user.detail?.text ?? ""
        // 计算cell高度
        return text.characters.count == 0 ? 0 : text.boundingRect(with: CGSize(width: tableView.bounds.width - 20, height: CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 17)], context: nil).size.height + 80
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // 获取数据模型
            let user = datasource[indexPath.row]
            // 获取要删除的那行数据
            user.detail?.deleteUser()
            datasource.remove(at: indexPath.row)
            tableView.reloadData()
            print(datasource.count)
            
            if datasource.count == 0 {
                requestData()
            }
            
        }
    }
    
}






































