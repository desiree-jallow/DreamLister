//
//  ItemCell.swift
//  DreamLister
//
//  Created by Desiree on 11/25/20.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var details: UILabel!
    
    
    func configCell(_ item: Item) {
        thumbnail.image = item.image?.image as? UIImage ?? UIImage(named: "imagePick")
        title.text = item.name
        price.text = "$\(item.price)"
        details.text = item.details
    }
}
