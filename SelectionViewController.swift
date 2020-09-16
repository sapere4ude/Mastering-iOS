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

class SelectionViewController: UIViewController {
    
    lazy var list: [MaterialColorDataSource.Color] = {
        (0...2).map { _ in
            return MaterialColorDataSource.generateSingleSectionData() }.reduce([], +)
    }()
    
    lazy var checkImage: UIImage? = UIImage.init(named: "checked")
    
    @IBOutlet weak var listCollectionView: UICollectionView!
    
    func selectRandomItem() {
        let item = Int(arc4random_uniform(UInt32(list.count)))
        let targetIndexPath = IndexPath(item: item, section: 0)
        
        // cell 선택할때 호출.
        listCollectionView.selectItem(at: targetIndexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    func reset() {
        // 개별 cell 해제할때 사용
        // listCollectionView.deselectItem(at: <#T##IndexPath#>, animated: <#T##Bool#>)
        
        listCollectionView.selectItem(at: nil, animated: true, scrollPosition: .left)
        
        let firstIndexPath = IndexPath(item: 0, section: 0)
        listCollectionView.scrollToItem(at: firstIndexPath, at: .left, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showMenu))
        
        listCollectionView.allowsSelection = true
        listCollectionView.allowsMultipleSelection = false  // single로 동작
        
    }
}

extension SelectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let color = list[indexPath.item].color
        view.backgroundColor = color
        print("#1", indexPath, #function)
    }
    
    // cell을 선택하기 직전에 실행됨
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        print("#2", indexPath, #function)
        
        guard let list  = collectionView.indexPathsForSelectedItems else {
            return true
        }
        
        return !list.contains(indexPath)
    }
    
    // 선택 해제하기 전에 특정 행동을 추가할때 사용하는 메서드
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // 선택해제 된 이후 사용되는 메서드
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    
    // cell을 강조하기 전에 실행
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        print("#3", indexPath, #function)
        return true
    }
    
    // cell이 강조된 후 호출
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        print("#4", indexPath, #function)
        
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.layer.borderWidth = 6
        }
    }
    
    // cell 강조가 해제된 후 호출
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        print("#5", indexPath, #function)
        
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.layer.borderWidth = 0.0
        }
    }
}

extension SelectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.contentView.backgroundColor = list[indexPath.row].color
        
        return cell
    }
}







extension SelectionViewController {
    @objc func showMenu() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let randomAction = UIAlertAction(title: "Select Random Item", style: .default) { [weak self] (action) in
            self?.selectRandomItem()
        }
        actionSheet.addAction(randomAction)
        
        let resetPositionAction = UIAlertAction(title: "Reset", style: .default) { [weak self] (action) in
            self?.reset()
        }
        actionSheet.addAction(resetPositionAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true, completion: nil)
    }
}










