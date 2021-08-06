//
//  DetailTableViewController.swift
//  ContactsTask
//
//  Created by Ann Yesip on 01.07.2021.
//

import UIKit

final class DetailTableViewController: UITableViewController {
  var contacts: [ContactsDTO]
  
  init(contacts: [ContactsDTO]) {
    self.contacts = contacts
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.allowsSelection = false
    tableView.register(
      DetailTableViewCell.self,
      forCellReuseIdentifier: DetailTableViewCell.reuseIdentifier
    )
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return contacts.count
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 80
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: DetailTableViewCell.reuseIdentifier,
      for: indexPath) as! DetailTableViewCell
    guard contacts.count - 1 >= indexPath.row else { return cell }
    let contact = contacts[indexPath.row]
    cell.detailTextLabel?.text = contact.phoneNumber
    cell.imageView?.image = UIImage(systemName: "person.circle.fill")
    guard
      (!contact.firstName.isEmpty &&
        !contact.lastName.isEmpty) ||
        (!contact.firstName.isEmpty ||
          !contact.lastName.isEmpty) else { cell.textLabel?.text = "No name"; return cell }
    cell.textLabel?.text = contact.firstName + " " + contact.lastName
    return cell
  }
  
}
