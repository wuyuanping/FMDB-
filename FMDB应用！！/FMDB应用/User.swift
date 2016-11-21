//
//  User.swift
//  FMDB应用
//
//  Created by 俊杰 on 16/11/10.
//  Copyright © 2016年 JunJie. All rights reserved.
//

import UIKit

class User: Modes {
    //用户的模型属性
    var name : String = ""
    var profile_image : String = ""
    var detail : Detail?
    
    override class func initialize() {
        
        // 判断是否为自己的类,子类也会来到该方法
        if self == User.self {
            // 创建user表和detail表
            //constraint name_unique unique (name)   ??
            //constraint fk_stu_ref_class foreign key (user_id)    ??
            let sql = "create table if not exists t_user(id integer primary key autoincrement, name text , profile_image text, constraint name_unique unique (name));create table if not exists t_detail(id integer primary key autoincrement, text text, created_at text, user_id integer, constraint fk_stu_ref_class foreign key (user_id) references t_user (id))"
            FMDBTool.shareInstance.excuteStatements(sql: sql) //执行多条语句
        }
        
    }
    
    /// 插入用户数据
    func insertUser() -> () {
        
        // 查询当前name的id(主键)
        let sql = "select * from t_user where name = '\(name)'"
        let columnNames = ["id"] //直接初始化一个字符数组
        FMDBTool.shareInstance.excuteQuery(sql: sql, columnNames: columnNames, resultBlock: {(values : [String]) in
            
            if values.count > 0 {
                let value = values[0] //id唯一，只有一个
                self.detail!.insertDetail(user_id: value)
            } else {
                // 插入用户数据
                let sql1 = "insert into t_user(name, profile_image) values ('\(self.name)','\(self.profile_image)')"
                FMDBTool.shareInstance.excuteUpdate(sql: sql1)
                // 重新插入,以便于插入详情
                self.insertUser()
            }
        })

    }
    
    class func queryAll(resultBlock : @escaping (_ : [User]) -> ()) {
        // 查询详情以及用户数据
        let sql = "select * from t_detail, t_user as tu where tu.id = user_id"
        let columnNames = ["name","profile_image","text", "created_at", "user_id"]
        
        FMDBTool.shareInstance.excuteQuery(sql: sql, columnNames: columnNames, resultBlock: {(values : [String]) in
            
            // 遍历数组,转为模型
            var datasources = [User]()
            
            let count = columnNames.count
            let valuesCount = values.count
            let totalCount = valuesCount / count
            var i = -1
            for _ in 0..<totalCount {
                let user = User()
                i = i + 1
                user.name = values[i]
                i = i + 1
                user.profile_image = values[i]
                let detail = Detail()
                i = i + 1
                detail.text = values[i]
                i = i + 1
                detail.created_at = values[i]
                i = i + 1
                detail.user_id = Int(atof(values[i]))
                user.detail = detail
                datasources.append(user)
            }
            resultBlock(datasources)
        })
       
    }
}

