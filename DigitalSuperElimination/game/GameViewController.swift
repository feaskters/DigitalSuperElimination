//
//  GameViewController.swift
//  DigitalSuperElimination
//
//  Created by role on 2019/6/18.
//  Copyright © 2019 zmhProjectaaaaaa. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var gameView: UIView!
    @IBOutlet weak var progress: UIProgressView!
    
    var timer : Timer?
    var level : Int?
    var blocksArray:Array<Array<Int>>?
    var blockButtonArray:Array<Array<BlockButton>> = Array<Array<BlockButton>>.init()
    var time_left : Float?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.blocksArray = Checkpoints.shared().checkPointsArray[self.level! - 1] as? Array<Array<Int>>
    }

    override func viewWillAppear(_ animated: Bool) {
        self.levelLabel.text = String(level!)
        
        let width:CGFloat = 65
        let height:CGFloat = 65
        let space = (gameView.bounds.width - 5 * width) / 6
        
        for i in 0...4{
            self.blockButtonArray.append([])
            for j in 0...4{
                let block = BlockButton.init(frame: CGRect.init(x: space + CGFloat(j) * (space + width), y: space + CGFloat(i) * (space + height), width: width + 50, height: height + 50))
                block.create(number: self.blocksArray![i][j])
                self.blockButtonArray[i].append(block)
                self.gameView.addSubview(block)
                var dic = Dictionary<String,Int>.init()
                dic["x"] = i
                dic["y"] = j
                block.location = dic
                
                block.alpha = 0
                block.addTarget(self, action: #selector(self.blockClk(sender:)), for: UIControl.Event.touchUpInside)
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + TimeInterval(Double(i) * 0.1)) {
                    UIView.animate(withDuration: 0.2, animations: {
                        block.alpha = 1
                        block.frame = CGRect.init(x: space + CGFloat(j) * (space + width), y: space + CGFloat(i) * (space + height), width: width, height: height)
                    }) { (Bool) in
                        
                    }
                }
                
            }
        }
        
        //倒计时启动
        self.time_left = Float(self.timeLabel.text!)!
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (Timer) in
            self.time_left! -= 0.01
            self.timeLabel.text = String(Int(self.time_left!))
            self.progress.progress = Float(self.time_left!) / 30
            if self.time_left! <= 0{
                self.failed()
                Timer.invalidate()
            }
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.timer!.invalidate()
    }
    
    @objc func blockClk(sender:BlockButton){
        guard sender.number! != 0 else {
            return
        }
        Music.shared().musicPlayMergeEffective()
        let x = sender.location!["x"]!
        let y = sender.location!["y"]!
        sender.minus()
        if x > 0 {
            self.blockButtonArray[x - 1][y].minus()
        }
        if x < 4 {
            self.blockButtonArray[x + 1][y].minus()
        }
        if y > 0 {
            self.blockButtonArray[x][y - 1].minus()
        }
        if y < 4 {
            self.blockButtonArray[x][y + 1].minus()
        }
        
        
        //判断胜利
        var flag = true
        for items in self.blockButtonArray{
            for item in items{
                if item.number! != 0 {
                    flag = false
                    let x = item.location!["x"]!
                    let y = item.location!["y"]!
                    if (x == 0 || self.blockButtonArray[x - 1][y].number! == 0) && (x == 4 || self.blockButtonArray[x + 1][y].number! == 0) && (y == 0 || self.blockButtonArray[x][y - 1].number! == 0) && (y == 4 || self.blockButtonArray[x][y + 1].number! == 0){
                        self.failed()
                    }
                    
                }
            }
        }
        if flag {
            self.success()
        }
    }
    
    func success(){
        if UserDefaults.standard.integer(forKey: "level") < self.level! {
            
            UserDefaults.standard.set(self.level!, forKey: "level")
        }
        self.timer!.invalidate()
        end(success: true)
    }
    
    func failed(){
        self.timer!.invalidate()
        EffectiveClass.shake(view: self.view, delta: 3)
        end(success: false)
    }
    
    func end(success:Bool) {
        
        self.gameView.isUserInteractionEnabled = false
        
        let width : CGFloat = 300
        let height : CGFloat = 200
        let x = (UIScreen.main.bounds.width - width) / 2
        let y = (UIScreen.main.bounds.height - height) / 2
        let gov = GameOverView.init(frame: CGRect.init(x: x, y: -height, width: width, height: height))
        gov.create(time: self.timeLabel.text!, result: success, gameview: self)
        self.view.addSubview(gov)
        
        UIView.animate(withDuration: 1) {
            gov.frame = CGRect.init(x: x, y: y, width: width, height: height)
        }
        
    }
    
    @IBAction func back(_ sender: UIButton) {
        Music.shared().musicPlayEffective()
        EffectiveClass.reversePage(view: self.gameView)
        UIView.animate(withDuration: 1, animations: {
            self.progress.alpha = 0
        }, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + TimeInterval(1)) {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
}
