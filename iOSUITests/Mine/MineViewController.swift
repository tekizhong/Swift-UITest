//
//  MineViewController.swift
//  iOSUITests
//
//  Created by Evergrande-teki on 2018/8/10.
//  Copyright © 2018年 EvergrandeGroup. All rights reserved.
//

import UIKit

class MineViewController: UITableViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return super.numberOfSections(in: tableView)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return super.tableView(tableView, numberOfRowsInSection: section)
    }
    
    /// MARK - Actions
    @IBAction func buttonclick(_ sender: Any) {
        LoginManager.setLogin(isLogin: false)
        
        let alertController: UIAlertController = UIAlertController(title: nil, message: "成功注销", preferredStyle: UIAlertControllerStyle.alert)
        let alertAction: UIAlertAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.cancel) { (alertAction) in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "logOut"), object: nil)
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
}
