//
//  ZandiTableViewCell.swift
//  TimerZandi
//
//  Created by Jin younkyum on 2022/07/07.
//

import UIKit

class ZandiTableViewCell: UITableViewCell {

    @IBOutlet weak var zandiCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        zandiCollectionView.dataSource = self
        zandiCollectionView.delegate = self
        zandiCollectionView.register(UINib(nibName: "ZandiCell", bundle: .main), forCellWithReuseIdentifier: "ZandiCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension ZandiTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forzandi.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZandiCell", for: indexPath) as? ZandiCell else {return UICollectionViewCell() }
                
        cell.layer.cornerRadius = 6
                
        let testData = forzandi[indexPath.row]

        debugPrint("콜렉션 뷰다 !!")
        //rgb(58, 211, 83)
        /*
        if testData > 4 && testData <= 9 {
            cell.backgroundColor = UIColor(red: 58/225, green: 211/225, blue: 83/225, alpha: 1.0)
        } else if testData > 9 && testData <= 15 {
            cell.backgroundColor = UIColor(red: 38/225, green: 166/225, blue: 65/225, alpha: 1.0)
        } else if testData > 15 && testData <= 20 {
            cell.backgroundColor = UIColor(red: 1/225, green: 109/225, blue: 50/225, alpha: 1.0)
        } else if testData > 20 && testData <= 25 {
            cell.backgroundColor = UIColor(red: 13/225, green: 68/225, blue: 41/225, alpha: 1.0)
        } else if testData < 3 {
            cell.backgroundColor = .darkGray
        }
         */
        if testData <= 1 {
            cell.backgroundColor = .gray
        } else if testData > 1 && testData <= 9 {
            cell.backgroundColor = UIColor(red: 58/225, green: 211/225, blue: 83/225, alpha: 1.0)
        } else if testData > 9 && testData <= 15 {
            cell.backgroundColor = UIColor(red: 38/225, green: 166/225, blue: 65/225, alpha: 1.0)
        } else if testData > 15 && testData <= 20 {
            cell.backgroundColor = UIColor(red: 1/225, green: 109/225, blue: 50/225, alpha: 1.0)
        } else {
            cell.backgroundColor = UIColor(red: 13/225, green: 68/225, blue: 41/225, alpha: 1.0)
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 30, height: 30)
    }
    
    
    
}
