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

class SingleSelectionViewController: UIViewController {
   
   let list = Region.generateData()
   
   @IBOutlet weak var listTableView: UITableView!
   
    func selectRandomCell() {
        let section = Int(arc4random_uniform(UInt32(list.count)))
        let row = Int(arc4random_uniform(UInt32(list[section].countries.count)))
        let targetIndexPath = IndexPath(row: row, section: section)
        
        // 특정 cell을 선택할때 사용하는 메서드
        listTableView.selectRow(at: targetIndexPath, animated: true, scrollPosition: .top)
    }
   
    func deselect() {
        if let selected = listTableView.indexPathForSelectedRow {
            listTableView.deselectRow(at: selected, animated: true)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                [weak self] in
                let first = IndexPath(row: 0, section: 0)
                self?.listTableView.scrollToRow(at: first, at: .top, animated: true)
            }
            
        }
    
    }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showMenu(_:)))
   }
   
   @objc func showMenu(_ sender: UIBarButtonItem) {
      let menu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
      
      let selectRandomCellAction = UIAlertAction(title: "Select Random Cell", style: .default) { (action) in
         self.selectRandomCell()
      }
      menu.addAction(selectRandomCellAction)
      
      let deselectAction = UIAlertAction(title: "Deselect", style: .default) { (action) in
         self.deselect()
      }
      menu.addAction(deselectAction)
      
      let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
      menu.addAction(cancelAction)
      
      if let pc = menu.popoverPresentationController {
         pc.barButtonItem = sender
      }
      
      present(menu, animated: true, completion: nil)
   }
}

extension SingleSelectionViewController: UITableViewDataSource {
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
}


extension SingleSelectionViewController: UITableViewDelegate {
    // cell이 선택되기 전에 호출, 메소드에서 indexPath를 리턴하면 cell이 선택됨. 주로 특정 cell의 클릭을 금지할때 사용
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.row == 0 {
            return nil
        }
        return indexPath
    }
    // cell이 선택된 뒤에 호출. 선택된 cell은 indexPath를 통해 확인할 수 있음
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let target = list[indexPath.section].countries[indexPath.row]
        showAlert(with: target)
        
        tableView.cellForRow(at: indexPath)?.textLabel?.textColor = UIColor.black
        
        print("selected\(indexPath)")
    }
    
    // 선택된 cell을 선택해제하기 전에 호출. indexPath를 리턴하면 선택된 셀이 호출됨. nil을 리턴하면 선택된 cell을 그대로 유지
    func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath
    }
    
    // 선택되었던 cell이 선택해제될때 호출됨
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("deselected\(indexPath)")
    }
    
    // cell을 강조하기 전에 호출
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row != 0
        
    }
    
    // cell이 강조된 이후에 호출
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
    }
    
    // 강조 효과가 제거된 이후에 호출
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        
    }
}


extension UIViewController {
   func showAlert(with value: String) {
      let alert = UIAlertController(title: nil, message: value, preferredStyle: .alert)
      
      let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
      alert.addAction(okAction)
      
      present(alert, animated: true, completion: nil)
   }
}

class SingleSelectionCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        textLabel?.textColor = UIColor(white: 217.0/255.0, alpha: 1.0)
        textLabel?.highlightedTextColor = UIColor.black
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setSelected(highlighted, animated: animated)
    }
}






