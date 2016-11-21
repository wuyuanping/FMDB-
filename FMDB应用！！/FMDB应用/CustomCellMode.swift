//
//  CustomCellMode.swift
//  FMDB应用
//
//  Created by 俊杰 on 16/11/11.
//  Copyright © 2016年 JunJie. All rights reserved.
//

import UIKit

private let VisitUrlString = "http://api.budejie.com/api/api_open.php?a=list&c=data&type=29"
class CustomCellMode: NSObject {
    
    func fetchDatasource(result :@escaping (_ : [User]) -> ()) {
        
        // 1.从缓存中获取
        User.queryAll { datasources in
            // 2.判断缓存中是否有值
            if datasources.count != 0 { // 缓存中有数据,直接执行闭包
                print("从缓存中获取")
                result(datasources)
                return
            }
            
            print("从网络中加载")
            
            NetWorkTool.shareInstance.getDatas(method: "get", urlString: VisitUrlString, result: {(resultDict : [String : NSObject]?,error :  String?) in
                // 1.判断是否有错
                if error != nil {
                    print(error!)
                    return
                }
                
                // 2.取出数组数据
                guard let resultArray = resultDict?["list"] as? [[String : AnyObject]] else {return}
                
                // 3.将数组中的字典转模型,并添加到数组中
                var users = [User]()
                for dict in resultArray {
                    let user = User(dict: dict)
                    let detail = Detail(dict: dict)
                    user.detail = detail
                    // 4插入数据到数据库
                    user.insertUser()
                    users.append(user)
                }
                // 5.执行闭包
                result(users)
            })
        }
    }
}
