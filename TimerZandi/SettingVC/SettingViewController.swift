//
//  SettingViewController.swift
//  TimerZandi
//
//  Created by 이주송 on 2022/07/08.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var moonImage: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppearanceCheck(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//    @IBAction func darkmodeButotnTap(_ sender: UIButton) {
//        if self.overrideUserInterfaceStyle == .light {
//            UserDefaults.standard.set("Dark", forKey: "Appearance")
//        } else {
//            UserDefaults.standard.set("Light", forKey: "Appearance")
//        }
//        self.viewWillAppear(true)
//    }
 
    @IBAction func switchValueChanged(_ sender: Any) {
        if self.mySwitch.isOn == false {
        self.mySwitch.setOn(true, animated: true)
        self.mySwitch.setOn(false, animated: true)
        if self.overrideUserInterfaceStyle == .light {
            UserDefaults.standard.set("Dark", forKey: "Appearance")
        } else {
            UserDefaults.standard.set("Light", forKey: "Appearance")
        }
        } else {
            if self.overrideUserInterfaceStyle == .light {
                UserDefaults.standard.set("Dark", forKey: "Appearance")
            } else {
                UserDefaults.standard.set("Light", forKey: "Appearance")
            }
        }
        self.viewWillAppear(true)
}
    
    func AppearanceCheck(_ viewController: UIViewController) {
        guard let appearance = UserDefaults.standard.string(forKey: "Appearance") else { return }
        if appearance == "Dark" {
            viewController.overrideUserInterfaceStyle = .dark
            if #available(iOS 13.0, *) {
                UIView.animate(withDuration: 0.5, delay: 0, animations: {
                    UIApplication.shared.statusBarStyle = .lightContent
                    self.moonImage.tintColor = .white
                })
            } else {
                UIApplication.shared.statusBarStyle = .default
            }
        } else {
            viewController.overrideUserInterfaceStyle = .light
            if #available(iOS 13.0, *) {
                UIView.animate(withDuration: 0.5, delay: 0, animations: {
                    UIApplication.shared.statusBarStyle = .darkContent
                    self.moonImage.tintColor = UIColor(red: 77/225, green: 22/225, blue: 79/225, alpha: 1)
                })
            } else {
                UIApplication.shared.statusBarStyle = .default
            }
        }
    }
    
}

