//
//  HomeViewController.swift
//  iOSUITests
//
//  Created by Evergrande-teki on 2018/8/10.
//  Copyright © 2018年 EvergrandeGroup. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var secmentInfoLabel: UILabel!
    @IBOutlet weak var a1: UIActivityIndicatorView!
    @IBOutlet weak var a2: UIActivityIndicatorView!
    @IBOutlet weak var prView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func segmentedValueChange(sender: UISegmentedControl) {
        let text = (sender.selectedSegmentIndex == 1) ? "Segmented右边" : "Segmented左边"
        self.secmentInfoLabel.text = text
    }
    
    
    @IBAction func switchValueChange(sender: UISwitch) {
        sender.isOn ? a1.startAnimating() : a1.stopAnimating()
        sender.isOn ? a2.startAnimating() : a2.stopAnimating()
    }
    @IBAction func stepperValueChange(sender: UIStepper) {
        self.prView.progress = Float(sender.value / 10.0);
    }
}
