//
//  DetailTableViewCell.swift
//  ContactsTask
//
//  Created by Ann Yesip on 01.07.2021.
//

import UIKit

final class DetailTableViewCell: UITableViewCell {
  static var reuseIdentifier: String {
    return "Identifier"
  }

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .subtitle , reuseIdentifier: reuseIdentifier)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
