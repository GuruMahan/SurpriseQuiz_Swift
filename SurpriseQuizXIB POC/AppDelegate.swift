//
//  AppDelegate.swift
//  SurpriseQuizXIB POC
//
//  Created by Guru Mahan on 03/03/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    internal var navigationController:UINavigationController!


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let pageController = UIPageControl.appearance()
        pageController.currentPageIndicatorTintColor = .black
        pageController.pageIndicatorTintColor = .lightGray
        
        let viewC = SurpriseQuizVC(nibName: "SurpriseQuizVC", bundle: nil)
        self.setAsRootViewController([viewC])
       
        return true
    }

   
}


extension AppDelegate{
    
    func setAsRootViewController(_ controllers: [UIViewController]){
        self.navigationController =  UINavigationController()
        self.navigationController?.viewControllers = controllers
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = self.navigationController
        self.window?.makeKeyAndVisible()
    }
}

