//
//  Copyright (c) 2018 KxCoding <kky0317@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit

class FlowLayoutViewController: UIViewController {
    
    @IBOutlet weak var listCollectionView: UICollectionView!
    
    let list = MaterialColorDataSource.generateMultiSectionData()
    
    @objc func toggleScrollDirection() {
        guard let layout = listCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        
        // performBatchUpdates -> 애니메이션을 이용한 전환
        listCollectionView.performBatchUpdates({
            // 삼항연산자 사용. true -> .horizontal / false -> .vertical
            layout.scrollDirection = layout.scrollDirection == .vertical ? .horizontal : .vertical
        }, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Toggle", style: .plain, target: self, action: #selector(toggleScrollDirection))
        
        if let layout = listCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: 100, height: 100)
            layout.minimumInteritemSpacing = 5
            layout.minimumLineSpacing = 5
            
            layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        }
        
    }
}

extension FlowLayoutViewController: UICollectionViewDelegateFlowLayout {
    
    // collectionView가 cell을 배치하기 전에 크기를 설정하기 위해 호출, cell 크기 계산이 순서에서 가장 첫번째임
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(indexPath.section, "#1",#function)
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize.zero
        }
        
        var bounds = collectionView.bounds
        bounds.size.height += bounds.origin.y
        
        var width = bounds.width - (layout.sectionInset.left + layout.sectionInset.right)
        var height = bounds.height - (layout.sectionInset.top + layout.sectionInset.bottom)
        
        switch layout.scrollDirection {
        case .vertical: // minimumLineSpacing : 세로간격, minimumInteritemSpacing: 가로간격
            height = (height - (layout.minimumLineSpacing * 4)) / 5
            if indexPath.item > 0 {
                width = (width - (layout.minimumInteritemSpacing * 2)) / 3
            }
        case .horizontal: // minimumLineSpacing : 가로간격, minimumInteritemSpacing: 세로간격
            width = (width - (layout.minimumLineSpacing * 2)) / 3
            if indexPath.item > 0 {
                height = (height - (layout.minimumInteritemSpacing * 4)) / 5
            }
        }
        
        return CGSize(width: width.rounded(.down) , height: height.rounded(.down))
    }

    // Line 92 - 107 주석 풀어서 cell 배치할때 어떤 메서드 순으로 동작하는지 확인할 수 있음
    
//    // cell 여백값이 필요할때 호출하는 메서드
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//         print(section, "#2",#function)
//        return 5
//    }
//
//    // cell 개별로 여백을 주는것은 불가능. section별로 여백을 주는 것은 가능
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//         print(section, "#3",#function)
//        return 5
//    }
//    // section 여백을 설정하는 메서드
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//         print(section, "#4",#function)
//        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
//    }
    
}


extension FlowLayoutViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list[section].colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.contentView.backgroundColor = list[indexPath.section].colors[indexPath.row]
        
        return cell
    }
}
















