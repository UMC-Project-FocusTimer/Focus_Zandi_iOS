//
//  LoginViewController.swift
//  TimerZandi
//
//  Created by 이주송 on 2022/07/28.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController {

    @IBOutlet weak var idToken: UILabel!
    @IBOutlet weak var userToken: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var fullName: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tapGoogleLogin(_ sender: Any) {
        //MARK: - Google Login -> 유저정보 받아오기

        let config = GIDConfiguration(clientID: "795344605481-eh9clt5aracqv6avsfmr3ca611nemc7k.apps.googleusercontent.com")
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { user, error in
            if let error = error { return }
            guard let user = user else { return }
            self.idToken?.text = user.authentication.idToken
            self.userToken?.text = user.userID
            self.email?.text = user.profile?.email
            self.fullName?.text = user.profile?.name
            
            print(user.profile)
            
            if self.fullName?.text != Optional("Label") {
                guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainController") else {return}
                      viewController.modalPresentationStyle = .fullScreen // 기본적인 모달형식(밑에서 올라오지만 꽉 차지 않음)을 Fullscreen으로 변경 !
                      self.present(viewController, animated: true, completion: nil)
            }
        }
    }
    

    
    
}
