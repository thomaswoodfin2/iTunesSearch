//
//  SearchDataCell.swift
//  TestApp
//
//  Created by Thomas Woodfin on 4/24/20.
//  Copyright © 2020 Thomas Woodfin . All rights reserved.
//

import UIKit

class SearchDataCell: UITableViewCell {
    
    static let identifire = "SearchDataCell"

    @IBOutlet weak var searchLbl: UILabel!
    @IBOutlet weak var favouriteBtn: UIButton!
    
    var favouriteAction: ((_ isSelect: Bool, _ index: Int)-> Void)?
    
    var index = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configuration(data: [SearchData], index: Int, favouriteList: [String]){
        searchLbl.text = data[index].trackName ?? ""
        self.index = index
        
        let list = favouriteList.filter { (id) -> Bool in
            return id == data[index].trackName
        }
        
        if list.count > 0 {
            favouriteBtn.isSelected = true
            favouriteBtn.setImage(UIImage(named: "ic_fav_full"), for: .normal)
        }else{
            favouriteBtn.setImage(UIImage(named: "ic_favourite"), for: .normal)
            favouriteBtn.isSelected = false
        }
    }

    @IBAction func favouriteAction(_ sender: UIButton) {
        if sender.isSelected{
            favouriteBtn.setImage(UIImage(named: "ic_favourite"), for: .normal)
            favouriteBtn.isSelected = false
        }else{
            favouriteBtn.isSelected = true
            favouriteBtn.setImage(UIImage(named: "ic_fav_full"), for: .normal)
        }
        
        favouriteAction?(favouriteBtn.isSelected, index)
    }
}
