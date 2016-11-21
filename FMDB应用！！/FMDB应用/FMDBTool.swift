//
//  FMDBTool.swift
//  FMDB应用
//
//  Created by 俊杰 on 16/11/10.
//  Copyright © 2016年 JunJie. All rights reserved.
//

import UIKit

class FMDBTool: NSObject {
    
    // 单例
    static let shareInstance = FMDBTool()

    // 创建数据库
    private lazy var db : FMDatabase? = {
        guard let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last else {return nil}
        let fullPath = path + "/demo.sqlite"
        return FMDatabase(path : fullPath)
    }()
    
    override init() {
        super.init()
    
        // 打开数据库，只有先打开数据库才能对数据库进行操作
        if db != nil {
            if db!.open() {
                print("打开数据库成功")
            } else {
                print("打开数据库失败")
            }
        }
    }
    
    /// 执行SQL语句
    ///
    /// - Parameter sql: sql语句
    /// - Returns: 是否执行成功
    func excuteUpdate(sql : String) -> () {
        
        if let _ = db { //??
            if db!.executeUpdate(sql, withArgumentsIn: nil) {
                print("成功")
            } else {
                print("失败")
            }
        }
    
    }
    
    
    /// 执行多条sql语句
    ///
    /// - Parameter sql: sql
    /// - Returns: 执行结果
    func excuteStatements(sql : String) -> () {
        if let _ = db {
            db!.executeStatements(sql)
        }
    }
    
    
    /// 查询数据
    ///
    /// - Parameters:
    ///   - sql: sql语句
    ///   - columnNames: 查询的字段
    /// - Returns: 返回查询到的数组字典
    func excuteQuery(sql : String,columnNames : [String], resultBlock : @escaping ([String]) -> ()) {
        guard let result = db?.executeQuery(sql, withArgumentsIn: nil) else {return}
        
        var values = [String]() //保存查询结果
        while result.next() {
            for columnName in columnNames {
                if let value =  result.string(forColumn: columnName) {
                    values.append(value)
                }
            }
        }
        resultBlock(values)
    }
}






























