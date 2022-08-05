//
//  DetailViewController.swift
//  TimerZandi
//
//  Created by Jin younkyum on 2022/07/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var themeImageView: UIImageView!
    @IBOutlet weak var themeNameLabel: UILabel!
    @IBOutlet weak var themeDetailLabel: UILabel!
    
    @IBOutlet weak var purchaseButton: UIButton!
    @IBOutlet weak var detailImageCollectionView: UICollectionView!
    
    
    var theme_key:Int?
    var theme = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        themeImageView.contentMode = .scaleAspectFill
        purchaseButton.setTitle("Sold Out", for: .disabled)
        purchaseButton.setTitle("Apply", for: .normal)
        
        
        
        if theme >= 100 {
            theme = theme - 100
            themeImageView.image = character[theme]
            themeNameLabel.text = characterName[theme]
            theme = theme + 10
        } else {
            themeImageView.backgroundColor = color[theme]
            themeNameLabel.text = colorName[theme]
        }
        
        
//        var purchaseList = UserDefaults.standard.array(forKey: themePurchaseKey)
//
//        print(purchaseList)
        
//        if (purchaseList?[theme] as! Int == 1) {
//            purchaseButton.isEnabled = false
//
//        }
        
        themeDetailLabel.text = "한줄 설명"
        
    }
    
    @IBAction func purchaseButtonTapped(_ sender: Any) {
//        var purchaseList = UserDefaults.standard.array(forKey: themePurchaseKey)
        
        if let codePresentName = theme_key {
            UserDefaults.standard.setValue(codePresentName, forKey: "THEME_KEY")
        }
        
        print(UserDefaults.standard.integer(forKey: "THEME_KEY")) // 적용되면 이거 이용해서 바꾸기 다른 VC 색상
        
//        purchaseList?[theme] = 1
//
//        UserDefaults.standard.set(purchaseList, forKey: themePurchaseKey)
        
        self.dismiss(animated: true)
    }
}
