//
//  LoginViewController.swift
//  iOSUITests
//
//  Created by Evergrande-teki on 2018/8/10.
//  Copyright © 2018年 EvergrandeGroup. All rights reserved.
//

import UIKit

let TestName: String = "iss"
let TestPwd: String = "123456"

class LoginViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var pwdTextField: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.autocorrectionType = UITextAutocorrectionType.no
        pwdTextField.autocorrectionType = UITextAutocorrectionType.no

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    /// MARK - Actions
    @IBAction func cancerButtonClick(_ sender: Any) {
        UIApplication.shared.keyWindow?.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loginButtonClick(_ sender: Any) {
        if nameTextField.text == TestName &&
            pwdTextField.text == TestPwd {
            LoginManager.setLogin(isLogin: true)
            dismiss(animated: true, completion: nil)
        }
        
        let alertController: UIAlertController = UIAlertController(title: nil, message: "账号或者密码错误", preferredStyle: UIAlertControllerStyle.alert)
        let alertAction: UIAlertAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.cancel) { (alertAction) in
            
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
  
    
}
