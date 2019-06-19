//
//  GameOverView.swift
//  DigitalSuperElimination
//
//  Created by role on 2019/6/19.
//  Copyright © 2019 zmhProjectaaaaaa. All rights reserved.
//

import UIKit

class GameOverView: UIView {

    var gameViewController:GameViewController?
    func create(time:String, result:Bool, gameview:GameViewController) {
        self.gameViewController = gameview
        let backgroundImage = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        backgroundImage.image = UIImage.init(named: "result")
        
        self.addSubview(backgroundImage)
        
        let resultLabel = UILabel.init(frame: CGRect.init(x: self.frame.width / 2 - 50, y: 50, width: 100, height: 50))
        resultLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        resultLabel.font = UIFont.systemFont(ofSize: 36)
        resultLabel.textAlignment = NSTextAlignment.center
        if result {
            resultLabel.text = "成功"
        }else{
            resultLabel.text = "失败"
        }
        self.addSubview(resultLabel)
        
        let timeLabel = UILabel.init(frame: CGRect.init(x: self.frame.width / 2 - 50, y: 120, width: 100, height: 50))
        timeLabel.textAlignment = NSTextAlignment.center
        timeLabel.textColor = UIColor.white
        timeLabel.text = "剩余时间: " + time
        self.addSubview(timeLabel)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.gameViewController!.back(UIButton.init())
        UIView.animate(withDuration: 1) {
            self.alpha = 0
        }
    }
}
