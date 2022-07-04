//
//  StaticViewController.swift
//  TimerZandi
//
//  Created by 이주송 on 2022/07/04.
//

import UIKit

class StaticViewController: UIViewController {

    @IBOutlet weak var zandiCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureColletionView()
    }
    
    private func configureColletionView() {
            self.zandiCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
            self.zandiCollectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            self.zandiCollectionView.delegate = self
            self.zandiCollectionView.dataSource = self
        }

}

extension StaticViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40, height: 40)
//        return CGSize(width: (UIScreen.main.bounds.width / 10), height: 40) // 행간의 Cell이 2개 표시됨
    } // sizeForItemAt 메소드 : 셀의 사이즈 찍어내는 메소드
}

extension StaticViewController: UICollectionViewDataSource {
    // 아래는 필수 메소드 두개 !
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    } // 콜렉션뷰의 위치에 표시할 셀의 "갯수"[필수 메서드]
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZandiCell", for: indexPath) as? ZandiCell else {return UICollectionViewCell() }
//        let diary = self.diaryList[indexPath.row]
//        let diaryTitleNumber = Int(diary.title) ?? 0
//        cell.titleLabel.text = diary.title
      
        
//        if diaryTitleNumber == 1 {
//            cell.backgroundColor = UIColor(red: 100/225, green: 220/225, blue: 220/225, alpha: 1.0)
//        } else {
//            cell.backgroundColor = .blue
//        }
        return cell
    } // 콜렉션뷰의 위치에 표시할 셀을 "요청"하는 메소드[필수 메서드]
    
    
} // 콜렉션 뷰로 보여지는 컨텐츠를 관리하는 객체

