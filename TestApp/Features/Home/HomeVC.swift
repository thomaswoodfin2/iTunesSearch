//
//  HomeVC.swift
//  TestApp
//
//  Created by Thomas Woodfin on 4/24/20.
//  Copyright © 2020 Thomas Woodfin. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak private var tblView: UITableView!
    @IBOutlet weak private var searchFld: UITextField!
    private let viewModel = HomeVM()
    private let defaults = UserDefaults.standard
    
    var favouriteList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchFld.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        getData()
        favouriteList = defaults.object(forKey: "favourites") as? [String] ?? [String]()
    }
    
    private func getData(){
        viewModel.getData { (success) in
            if success {
                self.tblView.reloadData()
            }
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let arr = viewModel.searchList else {return}
        guard let txt = textField.text else {return}
        if txt.isEmpty{
            getData()
        }else{
            let result = arr.filter({ (model) -> Bool in
                return ((model.trackName?.lowercased().contains(txt))! && !model.kind!.isEmpty)
            })
            viewModel.setFilter(searchList: result)
            self.tblView.reloadData()
        }
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.dic.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Array(viewModel.dic)[section].key
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = Array(viewModel.dic)[section].key
        
        return viewModel.dic[key]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchDataCell.identifire, for: indexPath) as! SearchDataCell
        let key = Array(viewModel.dic)[indexPath.section].key
        guard let data = viewModel.dic[key] else {return cell}
        
        
        
        
        cell.configuration(data: data, index: indexPath.row, favouriteList: self.favouriteList)
        
        cell.favouriteAction = { isSelected, index in
            if isSelected{
                self.favouriteList.append(data[index].trackName ?? "")
            }else{
                let name = data[index].trackName ?? ""
                for count in 0..<self.favouriteList.count-1 {
                    if self.favouriteList[count] == name {
                        self.favouriteList.remove(at: count)
                    }
                }
            }
            self.defaults.set(self.favouriteList, forKey: "favourites")
        }
        
        return cell
    }
    
    
}
