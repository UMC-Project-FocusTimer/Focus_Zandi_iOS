//
//  NewSettingViewController.swift
//  Pods
//
//  Created by 이주송 on 2022/07/20.
//

import UIKit

class NewSettingViewController: UIViewController {

    @IBOutlet weak var vectorImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        var THEME_KEY = UserDefaults.standard.integer(forKey: "THEME_KEY")
        if THEME_KEY != 0 {
        self.vectorImageView.image = UIImage(named: vectorImage[THEME_KEY])
        } else {
            self.vectorImageView.image = UIImage(named: vectorImage[8])
        }
    }
    
    @IBAction func tapBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapLogout(_ sender: Any) {

        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)

    } // 로그아웃 하시겠습니까? & 세션 정보 삭제
}
