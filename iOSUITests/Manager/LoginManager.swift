//
//  LoginManager.swift
//  iOSUITests
//
//  Created by Evergrande-teki on 2018/8/10.
//  Copyright © 2018年 EvergrandeGroup. All rights reserved.
//

import UIKit
let  loginKey: String = "LOGIN_KEY"

class LoginManager: NSObject {
   class  func setLogin(isLogin: Bool) {
        let userDefault = UserDefaults.standard
        userDefault.set(isLogin, forKey: loginKey)
    }
    
    class func getLogin() -> Bool {
        let userDefault = UserDefaults.standard
        return userDefault.bool(forKey: loginKey)
    }
}
