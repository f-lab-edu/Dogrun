//
//  AppDelegate.swift
//  DogRun
//
//  Created by 이규관 on 2024/01/03.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        URLProtocol.registerClass(MockURLProtocol.self)
        // UIWindow 생성
        window = UIWindow(frame: UIScreen.main.bounds)
        // 초기 화면 설정
        let viewController = LoginViewController()
        // UINavigationController 생성 및 rootViewController로 viewControllerA 지정
        let navigationController = UINavigationController(rootViewController: viewController)
        // UIWindow의 rootViewController로 UINavigationController 설정
        window?.rootViewController = navigationController
        // UIWindow를 화면에 보이게 함
        window?.makeKeyAndVisible()
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}

