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
    
    
    
    var theme = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        themeImageView.contentMode = .scaleAspectFill
        purchaseButton.setTitle("Sold Out", for: .disabled)
        purchaseButton.setTitle("Purchase", for: .normal)
        

        if theme >= 100 {
            theme = theme - 100
            themeImageView.image = character[theme]
            themeNameLabel.text = characterName[theme]
            theme = theme + 6
        } else {
            themeImageView.backgroundColor = color[theme]
            themeNameLabel.text = colorName[theme]
        }
        
        
        var purchaseList = UserDefaults.standard.array(forKey: themePurchaseKey)
        
        print(purchaseList)
        
        if (purchaseList?[theme] as! Int == 1) {
            purchaseButton.isEnabled = false
            
        }
        
        themeDetailLabel.text = "한줄 설명"
        
    }
    
    @IBAction func purchaseButtonTapped(_ sender: Any) {
        var purchaseList = UserDefaults.standard.array(forKey: themePurchaseKey)
        
        purchaseList?[theme] = 1
        
        UserDefaults.standard.set(purchaseList, forKey: themePurchaseKey)
        
        self.dismiss(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
