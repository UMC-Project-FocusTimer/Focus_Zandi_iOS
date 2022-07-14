//
//  StaticViewController.swift
//  TimerZandi
//
//  Created by 이주송 on 2022/07/04.
//

import UIKit

class StaticViewController: UIViewController {

    @IBOutlet weak var zandiCollectionView: UICollectionView!
   
    @IBAction func reLoadButton(_ sender: UIButton) {
        debugPrint("새로고침합니다.")
        self.zandiCollectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureColletionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("SeguePush VC 뷰가 나타날 것이다.")
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("SeguePush VC 뷰가 나타났다.")
    }
    
    
    private func configureColletionView() {
            self.zandiCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
            self.zandiCollectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            // zandiCollectionView 와 ZandiCell 사이의 간격
            self.zandiCollectionView.delegate = self
            self.zandiCollectionView.dataSource = self
        }
}

extension StaticViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 35, height: 35)
//        return CGSize(width: (UIScreen.main.bounds.width / 10), height: 40) // 행간의 Cell이 2개 표시됨
    } // sizeForItemAt 메소드 : 셀의 사이즈 찍어내는 메소드
}

extension StaticViewController: UICollectionViewDataSource {
    // 아래는 필수 메소드 두개 !
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 42
    } // 콜렉션뷰의 위치에 표시할 셀의 "갯수"[필수 메서드]
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZandiCell", for: indexPath) as? ZandiCell else {return UICollectionViewCell() }
        cell.cellTestLabel.text = String(indexPath.row + 1)
        cell.layer.cornerRadius = 6
        

// 일자 달라지면 셀이 추가 되도록 ! 하지만 추가한 셀만 색변경이 적용되게는 아직 ..
// 지금 날짜랑 일치한 셀만 색 변경가능하게
// 분에 따라 각 셀의 색을 변화시켰지만, 하나의 키로 저장된 유저디폴트로만 이용하기에 다음 날이 되었을 때 새로고침하면 집중시간에 따른 색이 제대로 출력되지 않음
        return cell
    } // 콜렉션뷰의 위치에 표시할 셀을 "요청"하는 메소드[필수 메서드]
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        debugPrint("이 날의 총 집중시간 : \(UserDefaults.standard.integer(forKey: sumTime)) 초")
        debugPrint("이 날의 집중 중단 횟수  : \(UserDefaults.standard.integer(forKey: countTime)) 회")
    }

    
} // 콜렉션 뷰로 보여지는 컨텐츠를 관리하는 객체

// 날짜 임의로 정해놓고 바꾸는 거 구현하기
// 날짜를 의미하는 텍스트 배열을 넣고, 시간 지나면 날짜 배열에 하나씩 쌓기, 오늘의 날짜랑 배열의 [0] 값이 일치하면 첫번째 index.row에 잔디 칠하기 <일주일치>
//
