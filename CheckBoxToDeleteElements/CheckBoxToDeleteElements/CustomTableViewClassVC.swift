//
//  CustomTableViewClassVC.swift
//  CheckBoxToDeleteElements
//
//  Created by yogesh singh negi on 04/09/17.
//  Copyright © 2017 appinventiv. All rights reserved.
//

import UIKit

//=============================================================//
//MARK: CustomTableViewClassVC Class
//=============================================================//

class CustomTableViewClassVC: UIViewController {
    
//=============================================================//
//MARK: Stored Properties
//=============================================================//

    var nameArray = ["Yogesh","Arvind","Sajal","Vinay","Akshay","Negi","Kartik","Aman","Kumar","Verma"]
    
    var imageNameArray = [String]()
    
//=============================================================//
//MARK: Defining IBOutlets
//=============================================================//
    
    @IBOutlet weak var customTableView: UITableView!
    
    @IBOutlet weak var deleteBtnName: UIButton!
    
//=============================================================//
//MARK: View Methods
//=============================================================//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "My Friends Zone"
        self.customTableView.delegate = self
        self.customTableView.dataSource = self
        self.deleteBtnName.isUserInteractionEnabled = false
        self.deleteBtnName.backgroundColor = UIColor.lightGray
        for tempIndex in 0..<self.nameArray.count{
            self.imageNameArray.insert("blank", at: tempIndex)
        }
    }
    
//=============================================================//
//MARK: Dispose of any resources that can be recreated
//=============================================================//

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
//=============================================================//
//MARK: Defining IBAction of Custom Delete Button
//=============================================================//
    
    @IBAction func navigationItemBtnTapped(_ sender: UIBarButtonItem) {
        
        if self.navigationItem.rightBarButtonItem?.title == "Edit"{
            self.navigationItem.rightBarButtonItem?.title = "Done"
            self.deleteBtnName.isUserInteractionEnabled = true
            self.deleteBtnName.backgroundColor = UIColor.white
            for tempIndex in 0..<self.nameArray.count{
                self.imageNameArray[tempIndex] = "uncheck"
            }
        }
        else if self.navigationItem.rightBarButtonItem?.title == "Done"{
            self.navigationItem.rightBarButtonItem?.title = "Edit"
            self.deleteBtnName.isUserInteractionEnabled = false
            self.deleteBtnName.backgroundColor = UIColor.lightGray
            for tempIndex in 0..<self.nameArray.count{
                self.imageNameArray[tempIndex] = "blank"
            }
        }
        self.customTableView.reloadData()
        
    }
    
    @IBAction func checkBoxImageBtnTapped(_ sender: UIButton) {
        
        guard let tableCell = getCell(button: sender) as? CellForRowClass else{fatalError()}
        guard let indexPath = self.customTableView.indexPath(for: tableCell) else {fatalError()}
        if self.imageNameArray[indexPath.row] == "uncheck"{
            self.imageNameArray[indexPath.row] = "check"
        }
        else if self.imageNameArray[indexPath.row] == "check"{
            self.imageNameArray[indexPath.row] = "uncheck"
        }
        self.customTableView.reloadData()
    }
    
    @IBAction func deleteBtnTapped(_ sender: UIButton) {
        
        var tempArray = [String]()
        for temIndex in 0..<self.nameArray.count{
            if self.imageNameArray[temIndex] == "uncheck"{
                tempArray.append(self.nameArray[temIndex])
            }
        }
        self.nameArray.removeAll()
        self.imageNameArray.removeAll()
        for tempIndex in 0..<tempArray.count{
            self.nameArray.insert(tempArray[tempIndex], at: tempIndex)
            self.imageNameArray.insert("uncheck", at: tempIndex)
        }
        self.customTableView.reloadData()
    }
    
}
    

//=============================================================//
//MARK: CustomTableViewClassVC Class Extension
//=============================================================//

extension CustomTableViewClassVC: UITableViewDelegate,UITableViewDataSource{
    
//=============================================================//
//MARK: Setting Number Of Cells
//=============================================================//
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.nameArray.count
    }
    
//=============================================================//
//MARK: Setting the Cell
//=============================================================//
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellForRowClass_ID") as? CellForRowClass else { fatalError("Cell Failed to load") }
        cell.nameLabel.text = self.nameArray[indexPath.row]
        cell.imageBtnName.setImage(UIImage(named: self.imageNameArray[indexPath.row]), for: .normal)
        return cell
    }
    
//=============================================================//
//MARK: Setting Height Of the Cell
//=============================================================//
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
//=============================================================//
//MARK: User Define Method for Getting IndexPath
//=============================================================//

    func getCell(button: UIButton) -> UITableViewCell {
        var cell : UIView = button
        while !(cell is CellForRowClass) {
            if let super_view = cell.superview {
                cell = super_view
            }
        }
        guard let tableCell = cell as? CellForRowClass else { fatalError() }
        return tableCell
    }
    
}

//=============================================================//
//MARK: Class for Cell UIViews
//=============================================================//

class CellForRowClass: UITableViewCell {
    
//=============================================================//
//MARK: TableView IBOutlets
//=============================================================//
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var imageBtnName: UIButton!

}

