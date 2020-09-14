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

class SectionHeaderAndFooterViewController: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    
    let list = Region.generateData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let headerNib = UINib(nibName: "customHeader", bundle: nil)
        
        listTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "header")
    }
}


extension SectionHeaderAndFooterViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list[section].countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let target = list[indexPath.section].countries[indexPath.row]
        cell.textLabel?.text = target
        
        return cell
    }
    
}

extension SectionHeaderAndFooterViewController: UITableViewDelegate {
    
    // cellForRowAt 하고 비슷한 방식
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! CustomHeaderView
        
        headerView.titleLabel.text = list[section].title
        headerView.countLabel.text = "\(list[section].countries.count)"
        
//        headerView?.textLabel?.text = list[section].title
//        headerView?.detailTextLabel?.text = "Lorem Ipsum"   // tableView style이 group일때만 실행됨
        
        //headerView?.backgroundColor = UIColor.darkGray
        
        return headerView
    }
    
    // 시각적인 속성과 관련된 메서는 이 안에서 설정해줄것
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        if let headerView = view as? UITableViewHeaderFooterView {
////            if headerView.backgroundView == nil {
////                let v = UIView(frame: .zero)            // 새로운 뷰를 생성해주고 그것에다가 색상을 지정해주는 방식. headerView자체에다가 넣어주면 오류남
////                v.backgroundColor = UIColor.darkGray
////                v.isUserInteractionEnabled = false      // 터치X 방식으로 바꾸는 것
////                headerView.backgroundView = v
////            }
//            headerView.backgroundView?.backgroundColor = UIColor.darkGray
//
//            headerView.textLabel?.textColor = UIColor.white
//            headerView.textLabel?.textAlignment = .center
//        }
//    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
}














