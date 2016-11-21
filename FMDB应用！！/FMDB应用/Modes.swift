//
//  Modes.swift
//  FMDB应用
//
//  Created by 俊杰 on 16/11/10.
//  Copyright © 2016年 JunJie. All rights reserved.
//

import UIKit

class Modes: NSObject {
    
    override init() {
        super.init()
    }
    
    init(dict : [String : AnyObject]) { //给模型属性赋值
        super.init()
        setValuesForKeys(dict)
    }
    //防止模型属性不匹配服务器传过来的属性个数而报错
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
}
