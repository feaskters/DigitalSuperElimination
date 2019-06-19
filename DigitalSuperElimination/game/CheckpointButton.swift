//
//  CheckpointButton.swift
//  DigitalSuperElimination
//
//  Created by role on 2019/6/18.
//  Copyright © 2019 zmhProjectaaaaaa. All rights reserved.
//

import UIKit

class CheckpointButton: UIButton {

    
    var level:Int?
    
    func create(level:Int, enable:Bool) {
        self.level = level
        
        if enable {
            self.setBackgroundImage(UIImage.init(named: "level_blue"), for: UIControl.State.normal)
            self.isUserInteractionEnabled = true
        }else{
            self.setBackgroundImage(UIImage.init(named: "level_gray"), for: UIControl.State.normal)
            self.isUserInteractionEnabled = false
        }
        
        self.setTitle(String(self.level!), for: UIControl.State.normal)
        self.titleLabel?.font = UIFont.init(name: "Marker Felt", size: 18)
    }

}
