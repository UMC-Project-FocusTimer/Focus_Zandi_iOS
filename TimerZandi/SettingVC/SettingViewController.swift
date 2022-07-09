//
//  SettingViewController.swift
//  TimerZandi
//
//  Created by 이주송 on 2022/07/08.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet weak var mySwitch: UISwitch!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppearanceCheck(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func darkmodeButotnTap(_ sender: UIButton) {
        if self.overrideUserInterfaceStyle == .light {
            UserDefaults.standard.set("Dark", forKey: "Appearance")
        } else {
            UserDefaults.standard.set("Light", forKey: "Appearance")
        }
        self.viewWillAppear(true)
    }
 
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
                UIApplication.shared.statusBarStyle = .lightContent
            } else {
                UIApplication.shared.statusBarStyle = .default
            }
        } else {
            viewController.overrideUserInterfaceStyle = .light
            if #available(iOS 13.0, *) {
                UIApplication.shared.statusBarStyle = .darkContent
            } else {
                UIApplication.shared.statusBarStyle = .default
            }
        }
    }
}
