//
//  MarketViewController.swift
//  TimerZandi
//
//  Created by Jin younkyum on 2022/07/27.
//

import UIKit

var color = [UIColor(red: 0.962, green: 0.832, blue: 0.832, alpha: 1),
             UIColor(red: 0.938, green: 0.638, blue: 0.638, alpha: 1),
             UIColor(red: 0.962, green: 0.851, blue: 0.719, alpha: 1),
             UIColor(red: 0.938, green: 0.888, blue: 0.651, alpha: 1),
             UIColor(red: 0.742, green: 0.859, blue: 0.925, alpha: 1),
             UIColor(red: 0.805, green: 0.829, blue: 0.954, alpha: 1)]
var colorName = ["Pink", "Warm Pink", "Light Pink", "Light Yellow", "Sky Blue", "Blue"]

var character = [UIImage(named: "jjangu"), UIImage(named: "puu")]
var characterName = ["짱구", "푸"]


class MarketViewController: UIViewController {
    


    @IBOutlet weak var adImageView: UIImageView!
    @IBOutlet weak var normalThemeCollectionView: UICollectionView!
    @IBOutlet weak var characterThemeCollectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "스토어"
        normalThemeCollectionView.delegate = self
        normalThemeCollectionView.dataSource = self
        characterThemeCollectionView.delegate = self
        characterThemeCollectionView.dataSource = self
        normalThemeCollectionView.register(UINib(nibName: "ElementCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ElementCollectionViewCell")
        characterThemeCollectionView.register(UINib(nibName: "ElementCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ElementCollectionViewCell")
        
        
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 100, height: 150)
        flowLayout.scrollDirection = .horizontal
        
        characterThemeCollectionView.collectionViewLayout = flowLayout
        normalThemeCollectionView.collectionViewLayout = flowLayout
        // Do any additional setup after loading the view.
    }
    
}

extension MarketViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == normalThemeCollectionView {
            return color.count
        } else if collectionView == characterThemeCollectionView {
            return character.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == normalThemeCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ElementCollectionViewCell", for: indexPath) as? ElementCollectionViewCell else { return UICollectionViewCell() }
            
            cell.ElementImage.backgroundColor = color[indexPath.row]
            cell.ElementLabel.text = colorName[indexPath.row]
            
            return cell
        } else if collectionView == characterThemeCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ElementCollectionViewCell", for: indexPath) as? ElementCollectionViewCell else { return UICollectionViewCell() }
            
            cell.ElementImage.image = character[indexPath.row]
            cell.ElementLabel.text = characterName[indexPath.row]
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == normalThemeCollectionView {
            guard let nextVC = storyboard?.instantiateViewController(identifier: "DetailViewController") as? DetailViewController else { return }
            
            nextVC.theme = indexPath.row
            
            self.present(nextVC, animated: true)
        } else if collectionView == characterThemeCollectionView {
            
            guard let nextVC = storyboard?.instantiateViewController(identifier: "DetailViewController") as? DetailViewController else { return }
            
            nextVC.theme = indexPath.row + 100
            
            self.present(nextVC, animated: true)
        }
    }
}
