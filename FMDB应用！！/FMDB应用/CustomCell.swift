//
//  CustomCell.swift
//  FMDB应用
//
//  Created by 俊杰 on 16/11/10.
//  Copyright © 2016年 JunJie. All rights reserved.
//

import UIKit
import Kingfisher

class CustomCell: UITableViewCell {
    @IBOutlet weak var iconV: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var createTime: UILabel!
    
    var user : User! {
        didSet {
            let url = URL(string:user.profile_image)
            iconV.kf.setImage(with: url)
            titleLabel.text = user.name
            
            detail.text = user.detail?.text
            createTime.text = user.detail?.created_at
        }
    }

}
