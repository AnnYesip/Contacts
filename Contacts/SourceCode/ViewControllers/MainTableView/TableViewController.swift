//
//  TableViewController.swift
//  Contacts
//
//  Created by Ann Yesip on 01.07.2021.
//

import UIKit
import ContactsUI

final class TableViewController: UITableViewController {
  let contactsManager: ContactsManager = ContactsManagerImp()
  let labels = [
    "Контакты",
    "Повторяющиеся имена",
    "Дубликаты номеров",
    "Без имени",
    "Нет номера",
    "Нет електроной почты"
  ]
  let contactImage = [
    "person.crop.circle",
    "person.3",
    "phone",
    "person.crop.circle.badge.questionmark",
    "iphone.slash",
    "envelope"
  ]
  var details = [Int()]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Контакты"
    tableView.register(
      TableViewCell.self,
      forCellReuseIdentifier: TableViewCell.reuseIdentifier
    )
    setupNavigationController()
    contactsManager.fetchContacts()
    requestAccess()
    tableView.tableFooterView = UIView()
    details.insert(contactsManager.contactsCount().0, at: 0)
    details.insert(contactsManager.repeatingName().0, at: 1)
    details.insert(contactsManager.repeatingNumbers().0, at: 2)
    details.insert(contactsManager.withoutName().0, at: 3)
    details.insert(contactsManager.withoutNumber().0, at: 4)
    details.insert(contactsManager.withoutEmail().0, at: 5)
  }
  

  // MARK: - setup Navigation Controller
  func setupNavigationController(){
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.titleTextAttributes = [
      NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25)
    ]
  }
  
  // MARK: - Table view data source
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return labels.count
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 80
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: TableViewCell.reuseIdentifier,
      for: indexPath) as! TableViewCell
    guard labels.count - 1 >= indexPath.row else { return cell }
    cell.accessoryType = .disclosureIndicator
    cell.textLabel?.text = labels[indexPath.row]
    cell.imageView?.image = UIImage(systemName: contactImage[indexPath.row])
    cell.detailTextLabel?.textColor = .black
    cell.detailTextLabel?.text = "\(details[indexPath.row])"
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch indexPath.row {
    case 0:
      let detailVC = DetailTableViewController(contacts: contactsManager.contactsCount().1)
      navigationController?.pushViewController(detailVC, animated: true)
    case 1:
      let detailVC = DetailTableViewController(contacts: contactsManager.repeatingName().1)
      navigationController?.pushViewController(detailVC, animated: true)
    case 2:
      let detailVC = DetailTableViewController(contacts: contactsManager.repeatingNumbers().1)
      navigationController?.pushViewController(detailVC, animated: true)
    case 3:
      let detailVC = DetailTableViewController(contacts: contactsManager.withoutName().1)
      navigationController?.pushViewController(detailVC, animated: true)
    case 4:
      let detailVC = DetailTableViewController(contacts: contactsManager.withoutNumber().1)
      navigationController?.pushViewController(detailVC, animated: true)
    case 5:
      let detailVC = DetailTableViewController(contacts: contactsManager.withoutEmail().1)
      navigationController?.pushViewController(detailVC, animated: true)
    default:
      print("no tag")
    }
  }
}

//  MARK: - requestAccess
private extension TableViewController {
  func requestAccess() {
    switch CNContactStore.authorizationStatus(for: .contacts) {
    case .authorized:
    break
    case .denied:
      showSettingsAlert()
    case .restricted :
      showSettingsAlert()
    case .notDetermined:
      showSettingsAlert()
    default:
      print("")
    }
  }

  func showSettingsAlert() {
    let alert = UIAlertController(
      title: nil,
      message: "This app requires access to Contacts to proceed. Go to Settings to grant access.",
      preferredStyle: .alert)
    if
      let settings = URL(string: UIApplication.openSettingsURLString),
      UIApplication.shared.canOpenURL(settings) {
      alert.addAction(UIAlertAction(
        title: "Open Settings",
        style: .default) { action in
        UIApplication.shared.open(settings)
      })
    }
    alert.addAction(UIAlertAction(
      title: "Cancel",
      style: .cancel) { action in
    })
    present(alert, animated: true)
  }
}
