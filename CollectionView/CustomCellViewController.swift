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

class CustomCellViewController: UIViewController {
    
    let list = MaterialColorDataSource.generateSingleSectionData()
    
    @IBOutlet weak var listCollectionView: UICollectionView!
    
    // 세그웨이가 호출되기 전에 실행됨
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cell = sender as? UICollectionViewCell else {
            return
        }
        
        guard let indexPath = listCollectionView.indexPath(for: cell) else {
            return
        }
        
        let target = list[indexPath.item]
        
        segue.destination.view.backgroundColor = target.color
        segue.destination.title = target.title
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // cell 목록을 배열로 리턴
        //listCollectionView.visibleCells
        
        // 특정 위치에 있는 cell을 이 메서드를 통해 얻을 수 있음
        //listCollectionView.cellForItem(at: <#T##IndexPath#>)
        
        // cell 위치를 확인할때 사용
        //listCollectionView.indexPath(for: UICollectionViewCell)
        
    }
}

extension CustomCellViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ColorCollectionViewCell
        
        let target = list[indexPath.item]
        cell.colorView.backgroundColor = target.color
        cell.hexLabel.text = target.hex
        cell.nameLabel.text = target.title
        
        
        return cell
    }
}















