//
//  LoginViewController.swift
//  TimerZandi
//
//  Created by 이주송 on 2022/07/28.
//

import UIKit
import GoogleSignIn
import Alamofire

class LoginViewController: UIViewController {

    @IBOutlet weak var userToken: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var fullName: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tapGoogleLogin(_ sender: Any) {
        //MARK: - Google Login -> 유저정보 받아오기

        let config = GIDConfiguration(clientID: "795344605481-eh9clt5aracqv6avsfmr3ca611nemc7k.apps.googleusercontent.com")
        var LOGINKEY:Int = 0

        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { user, error in
            if let error = error { return }
            guard let user = user else { return }
            var USER_TOKEN:String = user.userID ?? ""
            var USER_EMAIL:String = user.profile?.email ?? ""
            var USER_NAME:String = user.profile?.name ?? ""
            LOGINKEY = 1
            
            if LOGINKEY == 1 {
                postTestnd(userToken: USER_TOKEN, email: USER_EMAIL, fullName: USER_NAME)
        
                guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainController") else {return}
                      viewController.modalPresentationStyle = .fullScreen // 기본적인 모달형식(밑에서 올라오지만 꽉 차지 않음)을 Fullscreen으로 변경 !
                      self.present(viewController, animated: true, completion: nil)
                      LOGINKEY = 0
            }
        }
    }

    
}

