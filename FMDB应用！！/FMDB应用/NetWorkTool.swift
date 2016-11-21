//
//  NetWorkTool.swift
//  Floral
//
//  Created by 俊杰 on 16/11/10.
//  Copyright © 2016年 俊杰. All rights reserved.
//

import UIKit
import Alamofire

class NetWorkTool: NSObject {
    
    /// 单例
    static let shareInstance = NetWorkTool()

    /**
     获取数据
     
     - parameter method:    请求方式
     - parameter urlString: 请求的url
     - parameter result:    回调数据
     */
    func getDatas(method : String, urlString : String, result : @escaping (_ resultDict : [String : NSObject]?, _ error : String?) -> ()) {
        getDatas(method: method, parameters: nil, urlString: urlString, result: result)
    }
    
    /**
     获取数据
     
     - parameter method:     请求方式
     - parameter parameters: 请求参数
     - parameter urlString:  请求的url
     - parameter result:     回调数据
     */
    func getDatas(method : String, parameters : [String: AnyObject]?, urlString : String, result : @escaping (_ resultDict : [String : NSObject]?, _ error : String?) -> ()) {
        
        // 判断请求方式
        var m = HTTPMethod.get
        if method.lowercased() != "get" {
            m = HTTPMethod.post
        }
        
        Alamofire.request(urlString, method: m, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response : DataResponse<Any>) in
            
            if response.result.isSuccess {
                guard let dictValue = (response.result.value) as? [String : NSObject] else {
                    result(nil, "转换字典失败")
                    return
                }
                result(dictValue,nil)
                
            } else {
                result(nil, response.result.error.debugDescription)
            }
        }
    }


}
    
