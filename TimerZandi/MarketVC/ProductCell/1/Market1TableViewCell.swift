//
//  Market1TableViewCell.swift
//  TimerZandi
//
//  Created by Jin younkyum on 2022/07/21.
//

import UIKit

class Market1TableViewCell: UITableViewCell {

    @IBOutlet weak var m1CollectionView: UICollectionView!
    @IBOutlet weak var m1TitleLabel: UILabel!
    
    let list1 = ["blue", "red", "green", "yellow", "violet"]
    
    override func awakeFromNib() {
        super.awakeFromNib()

        m1CollectionView.delegate = self
        m1CollectionView.dataSource = self
        
        
        m1CollectionView.register(UINib(nibName: "ElementCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ElementCollectionViewCell")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension Market1TableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list1.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ElementCollectionViewCell", for: indexPath) as? ElementCollectionViewCell else { return UICollectionViewCell() }
        
        cell.ElementImage.image = UIImage(systemName: "scribble")
        cell.ElementLabel.text = list1[indexPath.row]
        cell.ElementLabel.tintColor = .black
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //guard let nextVC = inputViewController?.storyboard.
    }
}
