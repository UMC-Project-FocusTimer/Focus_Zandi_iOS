//
//  MarketViewController.swift
//  TimerZandi
//
//  Created by Jin younkyum on 2022/07/27.
//

import UIKit

var color = [themes[0][0],
             themes[1][0],
             themes[2][0],
             themes[3][0],
             themes[4][0],
             themes[5][0],
             themes[6][0],
             themes[7][0],
             themes[8][0],
             themes[9][0],

            ]
var colorName = [
                "Light Red",
                 "Crimson",
                 "Light Orange",
                 "Light Yellow",
                 "Sky",
                 "Deep Blue",
                 "Purple",
                 "Pink",
                 "Light Green",
                 "Black"
                ]

var character = [UIImage(named: "jjangu"), UIImage(named: "puu")]
var characterName = ["짱구", "푸"]


class MarketViewController: UIViewController {
    


    @IBOutlet weak var adImageView: UIImageView!
    @IBOutlet weak var normalThemeCollectionView: UICollectionView!
    @IBOutlet weak var characterThemeCollectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Store"

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
            UserDefaults.standard.setValue(indexPath.row, forKey: "THEME_KEY")
            self.present(nextVC, animated: true)
        } else if collectionView == characterThemeCollectionView {
            
            guard let nextVC = storyboard?.instantiateViewController(identifier: "DetailViewController") as? DetailViewController else { return }
            
            nextVC.theme = indexPath.row + 100
            nextVC.theme_key = indexPath.row
            
                        
            self.present(nextVC, animated: true)
        }
    }
}
