//
//  ViewController.swift
//  DigitalSuperElimination
//
//  Created by role on 2019/6/18.
//  Copyright © 2019 zmhProjectaaaaaa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    lazy var tipbar : UIView = {
        let width = UIScreen.main.bounds.width / 2 + 50
        let height : CGFloat = 200
        let tipbar = UIView.init(frame: CGRect.init(x: width - 100, y: -300, width: width, height: 0))
        
        let tipback = UIImageView.init(image: UIImage.init(named: "tip"))
        tipback.frame = CGRect.init(x: 0, y: 0, width: width, height: height)
        tipbar.addSubview(tipback)
        
        let tiplabel = UILabel.init(frame: CGRect.init(x: 50, y: 0, width: width - 100, height: 200))
        tiplabel.numberOfLines = 0
        tiplabel.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        if SystemLanguageClass.getCurrentLanguage() == "cn"{
            
            tiplabel.text = "\t游戏玩法:点击数字将会减小自身和周围的数字，当所有的数字变为0时，获得胜利。"
        }else{
            
            tiplabel.text = "\tIntroduction:Clicking on the number will reduce itself and the surrounding numbers, and when all the numbers become 0, it will win."
        }
        tipbar.addSubview(tiplabel)
        
        return tipbar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tipbar)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { (Timer) in
            EffectiveClass.scale(view: self.titleLabel)
        }
        
    }
    
    @IBAction func start(_ sender: UIButton) {
        Music.shared().musicPlayEffective()
        let lvc = LevelViewController.init(nibName: nil, bundle: nil)
        self.present(lvc, animated: false, completion: nil)
    }
    
    @IBAction func info(sender:UIButton){
        Music.shared().musicPlayEffective()
        
        let width = UIScreen.main.bounds.width / 2 + 50
        let height : CGFloat = 200
        
        if self.tipbar.frame.origin.y <= 0 {
            //显示提示View
            UIView.animate(withDuration: 0.5, animations: {
                self.tipbar.frame = CGRect.init(x: (width - 100) / 2, y: UIScreen.main.bounds.height / 2 - 100, width: width, height: height)
            }) { (Bool) in
                EffectiveClass.jump(view: self.tipbar)
            }
        }else{
            //关闭提示view
            UIView.animate(withDuration: 0.8, animations: {
                self.tipbar.frame = CGRect.init(x: width - 100, y: -300, width: width, height: 0)
            })
        }
    }
    
}

