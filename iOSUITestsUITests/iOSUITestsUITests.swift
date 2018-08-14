//
//  iOSUITestsUITests.swift
//  iOSUITestsUITests
//
//  Created by Evergrande-teki on 2018/8/10.
//  Copyright © 2018年 EvergrandeGroup. All rights reserved.
//

import XCTest

let MaxLoginNumber = 2 //最多循环登录次数
var loginIndex: Int = 0 //当前登录账号的下标

class iOSUITestsUITests: XCTestCase {
    
    
    /// 当前测试的APP
    var app: XCUIApplication = XCUIApplication()
    
    var accountArr: [[String: String]] = [
        ["name":"zhangsan", "pwd":"123456"],//账号1
        ["name":"lisis", "pwd":"123456"],//账号2
        ["name":"wangmazi", "pwd":"123456"],//账号3
        ["name":"iss", "pwd":"123456"],//账号4
    ]
    
    override func setUp() {
        super.setUp()
        
        
        app.terminate()
        
        app.launch()
        
        let args = app.launchArguments
        for arg in args {
            print("arg : \(arg)")
        }
        
        let env = app.launchEnvironment
        for key in env {
            let objct = env[key as! String] as! String
            print("env :\(objct)")
        }
        
        

        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        
        app.launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        allTestExample()
    }
    
    
    func allTestExample() -> Void {
        
        testHome()
        
        testLogin()
        
        testLogOut()
        
        testInformation()
        
        testMine()
    }
    
    // MARK: - 首页（未登录）
    func testHome() -> Void {
        if isLogin() {
            testLogOut()
        }
        var segmentedButton = app.segmentedControls.buttons["Second"]
        if segmentedButton.exists {
            segmentedButton.tap()
        }else {
            print("second 不存在")
        }
        
        
        segmentedButton = app.segmentedControls.buttons["First"];
        if segmentedButton.exists {
            segmentedButton.tap()
        }else {
            print("First 不存在")
        }
        
        let tabBarQuery = app.tabBars
        var tableBarButton = tabBarQuery.buttons["我的"]
        if tableBarButton.exists  {
            tableBarButton.tap()
        }else {
            print("我的 不存在")
        }
        
        tableBarButton = app.buttons["取消"]
        if tableBarButton.exists {
            tableBarButton.tap()
        }else {
            print("取消 不存在")
        }
        
        // 通过标签
        let slider1 = app.sliders.element(boundBy: 0)
        if slider1.exists {
            slider1.adjust(toNormalizedSliderPosition: 0)
            slider1.adjust(toNormalizedSliderPosition: 1)
        }else {
            print("slider1 不存在")
        }
        

        let switch1 = app.switches.element(boundBy: 0)
        if switch1.exists {
            switch1.tap()
            switch1.tap()
        }else {
            print("switch1 不存在")
        }
        
        
        //UIStepper (通过顺序)
        let steppersQuery = app.steppers
        let decrementButton = steppersQuery.buttons["Decrement"]
        if decrementButton.exists {
            decrementButton.tap()
            decrementButton.tap()
            decrementButton.tap()
        }
        else {
            print("decrementButton 不存在")
        }
        
        
        let incrementButton = steppersQuery.buttons["Increment"]
        if incrementButton.exists {
            incrementButton.tap()
            incrementButton.tap()
            incrementButton.tap()
        }else {
            print("incrementButton 不存在")
        }
        

        //tableview (通过顺序)
        let tableview = app.tables.element(boundBy: 0)
        if tableview.exists {
            tableview.swipeDown()
            tableview.swipeUp()
            tableview.swipeDown()
        }else {
            print("tableview 不存在")
        }
        
        //cells
        let cellQuery = tableview.cells;
        
        for index in 0..<5 {
            //cell (通过顺序)
            cellTapAtIndex(index, withCells: cellQuery)
            //UIAlertView
            alertViewTap()

        }

        
    }
    
    
    func testLogin() -> Void {
        if isLogin() {
            print("--> 测试登陆 已经是登陆状态")
            return
        }
        
        print("---> 开始测试登录")
        let tabBarsQuery = app.tabBars
        let tableBarButton = tabBarsQuery.buttons["我的"]
        if tableBarButton.exists {
            tableBarButton.tap()
        }else {
            XCTFail("--> tableBarButton 不存在")
        }
        
        XCTAssert((loginIndex < accountArr.count), "所有账号都无法登陆")
        
        let accountDict = accountArr[loginIndex]
        let userName = accountDict["name"]
        let pwd = accountDict["pwd"]
        
        let nameTextFiled = app.textFields["用户名"]
        if nameTextFiled.exists {
            nameTextFiled.tap()
        }else {
            XCTFail("nametextfiled not exist")
        }
        
        let cleanButton = app.buttons["Celar text"]
        if cleanButton.exists {
            cleanButton.tap()
        }else {
            print("cleanButton not exist")
        }
        
        nameTextFiled.typeText(userName!)
        
        hidenKeyBoard()
        
        let pwdTextFiled = app.secureTextFields["密码"]
        if pwdTextFiled.exists {
            pwdTextFiled.tap()
            pwdTextFiled.typeText(pwd!)
        }
        
        hidenKeyBoard()
        
        let loginButton = app.buttons["登录"]
        if loginButton.exists {
            loginButton.tap()
        }
        
        sleep(UInt32(1))
        
        let loginLabel = app.staticTexts["loginLabel"]
        if loginLabel.exists { // 登录失败
            
            alertViewTap()
            print("---> 账号%\(String(describing: userName) ) 密码\(pwd ?? "") 登陆失败")
            // 换个账号重新登录
            loginIndex += 1
            testLogin()
            
        }else { //登录成功
            print("---> 账号%\(userName ?? "") 密码\(pwd ?? "") 登陆成功")
            var tableBarButton = tabBarsQuery.buttons["我的"]
            if tableBarButton.exists {
                tableBarButton.tap()
            }
            tableBarButton = tabBarsQuery.buttons["首页"]
            if tableBarButton.exists {
                tableBarButton.tap()
            }
            print("---> 登陆测试完成")

        }
        
    }
    
    func testLogOut() -> Void {
        if isLogin() {
            let tableBarButton = app.tabBars.buttons["我的"]
            if tableBarButton.exists {
                tableBarButton.tap()
            }
            
            let tableView = app.tables.element(boundBy: 0)
            tableView.swipeUp()
            
            let tablesQuery = app.tables
            tablesQuery.buttons["退出登录"].tap()
            
            alertViewTap()
            
            
        }
    }
    
    func testInformation() -> Void {
        var loginCount = 0
        if isLogin() {
            print("---> 开始测试资讯页面")
            let infomation = app.tabBars["资讯"]
            if infomation.exists {
                infomation.tap()
            }
            else {
                print("资讯按钮不存在")
            }
            
            var button = app.buttons["标签2"]
            button.tap()
            button = app.buttons["标签3"]
            button.tap()
            button = app.buttons["标签4"]
            button.tap()
            button = app.buttons["标签5"]
            button.tap()
            button = app.buttons["标签6"]
            button.tap()
            button = app.buttons["标签1"]
            button.tap()
            
            let swipeView = app.scrollViews.element(boundBy: 0)
            if swipeView.exists {
                swipeView.swipeRight()
                swipeView.swipeLeft()
                swipeView.swipeLeft()
                swipeView.swipeLeft()
                swipeView.swipeLeft()
                swipeView.swipeLeft()
                swipeView.swipeLeft()
                
                print("---> 资讯页面测试完成")
            }
            else {
                XCTAssert(loginCount < MaxLoginNumber)
            }
            loginCount += 1
            testLogin()
            testInformation()
            
        }
        
    }
    
    func testMine() -> Void {
        var loginCount = 0;
        if isLogin() {
            print("---> 开始测试我的页面")
            let information = app.tabBars.buttons["我的"]
            if information.exists {
                information.tap()
            }else {
                XCTFail("我的 按钮不存在")
            }
            
            let tableView = app.tables.element(boundBy: 0)
            tableView.swipeDown()
            tableView.swipeUp()
            tableView.swipeDown()
            tableView.swipeUp()
            
            print("---> 我的页面测试完成")
        }
        else {
            XCTAssert((loginCount<MaxLoginNumber), "");
            print("---> 在我的页面发现未登录 开始第 \(loginCount)次登陆");
            loginCount += 1
            //发起登陆
            testLogin()
            //继续测试我的
            testMine()
        }
    }
    
    /// MARK - Life Cycle
    
    /// MARK - Public Methods
    
    /// MARK - Private Methods
    func isLogin() -> Bool {
        var isLogin = false
        let tabBarsQuery = app.tabBars
        var tableBarButton = tabBarsQuery.buttons["我的"]
        if tableBarButton.exists {
            tableBarButton.tap()
        }
        let loginLabel = app.staticTexts["loginLabel"]
        if loginLabel.exists {
            let cancelButton = app.buttons["取消"]
            if cancelButton.exists {
                cancelButton.tap()
            }
            
            isLogin = false
        }
        else {
            tableBarButton = tabBarsQuery.buttons["首页"]
            if tableBarButton.exists {
                tableBarButton.tap()
            }
            isLogin = true
        }
        return isLogin
    }
    
    
    /// cell点击
    ///
    /// - Parameters:
    ///   - index: <#index description#>
    ///   - withCells: <#withCells description#>
    func cellTapAtIndex(_ index: Int, withCells: XCUIElementQuery) -> Void {
        let cellElement = withCells.element(boundBy: index)
        if cellElement.exists {
            cellElement.tap()
        }
        else {
            print("cellElement 不存在")
        }
    }
    
    /// 弹窗点击
    func alertViewTap() -> Void {
        sleep(UInt32(0.5))
        let alertView = app.alerts.element(boundBy: 0)
        let alertButton = alertView.buttons["确定"]
        if alertButton.exists {
            alertButton.tap()
        }else {
            print("alertButton 不存在")
        }
        
        
    }
    
    
    func hidenKeyBoard() -> Void {
        let element = app.children(matching: XCUIElement.ElementType.window).element(boundBy: 0)
        element.tap()
    }
    
    
    
    /// MARK - Actions
    
    /// MARK - UITableViewDataSource
    
    /// MARK - UITableViewDelegate
    
    /// MARK - Custom Delegate
    
    /// MARK - getters and setters

    
    
    
}
