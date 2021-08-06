//
//  TableViewCell.swift
//  Contacts
//
//  Created by Ann Yesip on 01.07.2021.
//

import UIKit

final class TableViewCell: UITableViewCell {
  static var reuseIdentifier: String {
    return "Identifier"
  }

  //MARK: Initializer -
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .value1 , reuseIdentifier: reuseIdentifier)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  

}
