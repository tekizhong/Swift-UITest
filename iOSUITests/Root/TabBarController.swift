//
//  TabBarController.swift
//  iOSUITests
//
//  Created by Evergrande-teki on 2018/8/10.
//  Copyright © 2018年 EvergrandeGroup. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController,UITabBarControllerDelegate {

    /// MARK - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "logOut"), object: nil)
    }
    // MARK: - TabBarController Delegate
    
    
    /// MARK - Actions
    @objc func logOut() -> Void {
        self.selectedIndex = 0
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if !LoginManager.getLogin() {
            performSegue(withIdentifier: "prLoginViewController", sender: nil)
            return false
        }
        return true

    }

}
