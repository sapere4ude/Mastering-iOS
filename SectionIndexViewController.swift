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

class SectionIndexViewController: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    
    let list = Region.generateData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 디자인 바꾸기 title Color, backgroundColor 변경만 가능
        listTableView.sectionIndexColor = UIColor.white
        listTableView.sectionIndexBackgroundColor = UIColor.lightGray
        listTableView.sectionIndexTrackingBackgroundColor = UIColor.darkGray
    }
}

extension SectionIndexViewController: UITableViewDataSource {
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return list[section].title
    }
    
    // 짝수로 이동할 수 있게하는 코드 -> 드래그해서 움직일때 뭔가 안맞음
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return stride(from: 0, to: list.count, by: 2).map { list[$0].title }
    }
    
    // 원하는 위치로 index를 이동시켜주는 역할을 하는 메서드
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index * 2
    }
    
}










