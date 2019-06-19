//
//  LevelViewController.swift
//  DigitalSuperElimination
//
//  Created by role on 2019/6/18.
//  Copyright © 2019 zmhProjectaaaaaa. All rights reserved.
//

import UIKit

class LevelViewController: UIViewController {

    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var checkpointsView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        for item in checkpointsView.subviews{
            item.removeFromSuperview()
        }
        self.menuView.alpha = 1
        self.checkpointsView.alpha = 1
        let width:CGFloat = 60
        let height:CGFloat = 60
        let space = (checkpointsView.bounds.width - 5 * width) / 6
        
        for i in 0...24 {
            let checkbtn = CheckpointButton.init(frame: CGRect.init(x: space + CGFloat(i % 5) * (width + space), y: space + CGFloat(i / 5) * (width + space), width: width + 50, height: height + 50))
            checkbtn.alpha = 0
            if i <= UserDefaults.standard.integer(forKey: "level"){
                checkbtn.create(level: i + 1, enable: true)
                checkbtn.addTarget(self, action: #selector(self.checkbtn_clk(sender:)), for: UIControl.Event.touchUpInside)
            }else{
                checkbtn.create(level: i + 1, enable: false)
            }
            self.checkpointsView.addSubview(checkbtn)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + TimeInterval(Double(i) * 0.05)) {
                UIView.animate(withDuration: 0.2, animations: {
                    checkbtn.alpha = 1
                    checkbtn.frame = CGRect.init(x: space + CGFloat(i % 5) * (width + space), y: space + CGFloat(i / 5) * (width + space), width: width, height: height)
                }) { (Bool) in
                    
                }
            }
        }
        
    }
    
    
    @objc func checkbtn_clk(sender:CheckpointButton){
        Music.shared().musicPlayEffective()
        UIView.animate(withDuration: 1, animations: {
            self.checkpointsView.alpha = 0
            self.menuView.alpha = 0
        }) { (Bool) in
            let gvc = GameViewController.init(nibName: nil, bundle: nil)
            gvc.level = sender.level!
            self.present(gvc, animated: false, completion: nil)
            self.reloadInputViews()
        }
    }

    @IBAction func back(_ sender: UIButton) {
        Music.shared().musicPlayEffective()
        self.dismiss(animated: false, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
