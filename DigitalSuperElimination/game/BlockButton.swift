//
//  BlockButton.swift
//  DigitalSuperElimination
//
//  Created by role on 2019/6/18.
//  Copyright © 2019 zmhProjectaaaaaa. All rights reserved.
//

import UIKit

class BlockButton: UIButton {
    
    var number:Int?
    var location:Dictionary<String,Int>?
    
    func create(number:Int) {
        self.number = number
        self.setBackgroundImage(UIImage.init(named: String(number)), for: UIControl.State.normal)
        if number != 0{
            self.setTitle(String(number), for: UIControl.State.normal)
        }
        self.titleLabel?.font = UIFont.init(name: "Marker Felt", size: 24)
    }
    
    func minus() {
        if self.number! > 0 {
            self.number! -= 1
            self.setBackgroundImage(UIImage.init(named: String(number!)), for: UIControl.State.normal)
            self.setTitle(String(number!), for: UIControl.State.normal)
            if number == 0 {
                self.setTitle("", for: UIControl.State.normal)
            }
        }
    }
    
    func getnumber() -> Int {
        return self.number!
    }

}
