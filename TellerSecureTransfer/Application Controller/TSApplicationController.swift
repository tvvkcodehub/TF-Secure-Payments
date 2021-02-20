//
//  TSApplicationController.swift
//  TellerSecureTransfer
//
//  Created by Vamsi Krishna Tirumala on 20/02/21.
//

import UIKit

final class TSApplicationController: NSObject {

    var appWindow : UIWindow!
    var rootNavigationController : UINavigationController!
    var splashViewController : TSSplashViewController!
    var loginViewController : TSLoginViewController!
    
    //MARK - : Shared Instance.
    static let shared = TSApplicationController()
    private override init() {}
    
    //MARK : Initialize Root window with appWindow variable.
    func initWithWindow(_appWindow : UIWindow) -> Void{
        appWindow = _appWindow
    }
    
    //MARK : Launch application by attaching Splas View Controller to root Window.
    func lanchApplication() -> Void {
        
        //Remove if any view controller existing and re create
        if(rootNavigationController != nil) {
            rootNavigationController.removeFromParent()
            rootNavigationController.view.removeFromSuperview()
            rootNavigationController = nil
        }
        //Remove if any root view controller is still existing and remove and re create.
        if(splashViewController != nil) {
            splashViewController.removeFromParent()
            splashViewController.view.removeFromSuperview()
            splashViewController = nil
        }
        
        splashViewController = TSSplashViewController(nibName : "TSSplashViewController",bundle : Bundle.main)
        rootNavigationController = UINavigationController.init(rootViewController: splashViewController)
        appWindow.rootViewController = rootNavigationController
        
        perform(#selector(loadLoginScreen), with: nil, afterDelay: 2.0)
    }
    
    /********** Remove Splash Screen from Root Window, create login VC inside root navigation View Controller ***********/
    @objc func loadLoginScreen() {
        
        if(splashViewController != nil) {
            splashViewController!.removeFromParent()
            splashViewController!.view.removeFromSuperview()
        }
        
        let loginViewController = TSLoginViewController(nibName: "TSLoginViewController", bundle: Bundle.main)
        rootNavigationController = UINavigationController.init(rootViewController: loginViewController)
        TSCommonFunctions.shared.applyFadeAnimationToLayer(layer: appWindow!.layer, duration: 0.5)
        appWindow!.rootViewController = rootNavigationController
    }
    
    /************* Remove root navigation controller and root tab bar controller. Re initialize Navigation **********/
    /*******/
    func logOut() {
    
        if(self.rootNavigationController != nil) {
            self.rootNavigationController.removeFromParent()
            self.rootNavigationController.view.removeFromSuperview()
            self.rootNavigationController = nil
        }
        
        let loginViewController = TSLoginViewController(nibName: "TSLoginViewController", bundle: Bundle.main)
        self.rootNavigationController = UINavigationController.init(rootViewController: loginViewController)
        TSCommonFunctions.shared.applyFadeAnimationToLayer(layer: self.appWindow!.layer, duration: 0.5)
        self.appWindow!.rootViewController = self.rootNavigationController
    }
}
