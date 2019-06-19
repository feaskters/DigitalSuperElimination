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
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
}

