//
//  Detail.swift
//  FMDB应用
//
//  Created by 俊杰 on 16/11/10.
//  Copyright © 2016年 JunJie. All rights reserved.
//

import UIKit

class Detail: Modes {
    //详情属性
    var text : String = ""
    var created_at : String = ""
    var user_id : Int = 0
    
    /// 插入详情内容
    ///
    /// - Parameter user_id: 外键的值(引用user表的主键)
    func insertDetail(user_id : String) -> () {
        let sql = "insert into t_detail(text, created_at, user_id) values ('\(text)', '\(created_at)', \(user_id))"
        
        FMDBTool.shareInstance.excuteUpdate(sql: sql)
    }
    
    // 删除一条数据(本质是删除detail,user不删除)
    func deleteUser() -> () {
        let sql = "delete from t_detail where created_at = '\(created_at)'"
        FMDBTool.shareInstance.excuteUpdate(sql: sql)
    }
    

}
