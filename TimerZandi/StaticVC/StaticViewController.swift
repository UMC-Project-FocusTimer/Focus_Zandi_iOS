//
//  StaticViewController.swift
//  TimerZandi
//
//  Created by 이주송 on 2022/07/04.
//

import UIKit

class StaticViewController: UIViewController {

    var testList:[String] = []
    

    func viewDate() -> Void {
    let formatter_year = DateFormatter()
    formatter_year.dateFormat = "mm분"
    formatter_year.locale = Locale(identifier: "ko_KR")
    let current_year_string = formatter_year.string(from: Date())
// 앞에 값이랑 다를 때만 append
        if self.testList.contains(current_year_string) == false {
            self.testList.append((current_year_string))
        }
    }
    
    @IBOutlet weak var zandiCollectionView: UICollectionView!
   
    @IBAction func reLoadButton(_ sender: UIButton) {
        debugPrint("새로고침합니다.")
        self.zandiCollectionView.reloadData()
        self.viewDate()
        debugPrint(testList)
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
    
// var ZandiContents = [ZandiContents]()
// 뷰 넘길때마다 합이 저장되어 색을 변경해야 하는데 셀 색깔 바꾸는 메소드가 한번밖에 안일어남. 한번에 저장한 다음에 콜렉션뷰로 리로드 해서 바꾸기
    
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
        return CGSize(width: 30, height: 30)
//        return CGSize(width: (UIScreen.main.bounds.width / 10), height: 40) // 행간의 Cell이 2개 표시됨
    } // sizeForItemAt 메소드 : 셀의 사이즈 찍어내는 메소드
}

extension StaticViewController: UICollectionViewDataSource {
    // 아래는 필수 메소드 두개 !
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.testList.count
    } // 콜렉션뷰의 위치에 표시할 셀의 "갯수"[필수 메서드]
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZandiCell", for: indexPath) as? ZandiCell else {return UICollectionViewCell() }
        
        let testData = UserDefaults.standard.integer(forKey: sumTime)

        cell.cellTestLabel.text = self.testList[indexPath.row]


        // cell.cellTestLabel.text = self.testList[indexPath.row]
        cell.layer.cornerRadius = 6
        
        if self.testList.contains("49분") == false {
            debugPrint("48분임 아직")
        } else {
            debugPrint("49분이다 !!")
            
            if testData > 4 && testData <= 9 && self.testList[indexPath.row] == "49분" {
                cell.backgroundColor = UIColor(red: 58/225, green: 211/225, blue: 83/225, alpha: 1.0)
            } else if testData > 9 && testData <= 15 && self.testList[indexPath.row] == "49분" {
                cell.backgroundColor = UIColor(red: 38/225, green: 166/225, blue: 65/225, alpha: 1.0)
            } else if testData > 15 && testData <= 20 && self.testList[indexPath.row] == "49분" {
                cell.backgroundColor = UIColor(red: 1/225, green: 109/225, blue: 50/225, alpha: 1.0)
            } else if testData > 20 && testData <= 25 && self.testList[indexPath.row] == "49분" {
                cell.backgroundColor = UIColor(red: 13/225, green: 68/225, blue: 41/225, alpha: 1.0)
            } else if testData < 3 {
                cell.backgroundColor = .darkGray
            }
        }
// 일자 달라지면 셀이 추가 되도록 ! 하지만 추가한 셀만 색변경이 적용되게는 아직 ..
// 지금 날짜랑 일치한 셀만 색 변경가능하게
//
        debugPrint("콜렉션 뷰다 !!")

         
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
