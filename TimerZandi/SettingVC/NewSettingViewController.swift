//
//  NewSettingViewController.swift
//  Pods
//
//  Created by 이주송 on 2022/07/20.
//

import UIKit

class NewSettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func tapLogout(_ sender: Any) {
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") else {return}
              viewController.modalPresentationStyle = .fullScreen // 기본적인 모달형식(밑에서 올라오지만 꽉 차지 않음)을 Fullscreen으로 변경 !
              self.present(viewController, animated: true, completion: nil)
    } // 로그아웃 하시겠습니까? & 세션 정보 삭제
}
