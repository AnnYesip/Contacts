//
//  ContactsManager.swift
//  ContactsTask
//
//  Created by Ann Yesip on 01.07.2021.
//

import UIKit

protocol ContactsManager {
  func fetchContacts()
  func contactsCount() -> (count: Int, objects: [ContactsDTO])
  func repeatingName() -> (count: Int, objects: [ContactsDTO])
  func repeatingNumbers() -> (count: Int, objects: [ContactsDTO])
  func withoutName() -> (count: Int, objects: [ContactsDTO])
  func withoutNumber() -> (count: Int, objects: [ContactsDTO])
  func withoutEmail() -> (count: Int, objects: [ContactsDTO])
}

//MARK:- ContactsManagerImp
final class ContactsManagerImp: ContactsManager {
  private let contactsFetcher: ContactsFetcher = ContactFetcherImp()
  
  func fetchContacts() {
    contactsFetcher.fetchContacts()
  }
  
  //MARK:-  contact count
  func contactsCount() -> (count: Int, objects: [ContactsDTO]) {
    return (contactsFetcher.contacts.count , contactsFetcher.contacts)
  }
  
  //MARK: - repeating Name
  func repeatingName() -> (count: Int, objects: [ContactsDTO]) {
    var contact: [ContactsDTO] = []
    var fullNamesArray = [String]()
    for item in contactsFetcher.contacts {
      fullNamesArray.append(item.firstName + " " + item.lastName)
    }
    let duplicates = Array(Set(fullNamesArray
                                .filter({ (i: String) in fullNamesArray
                                          .filter({ $0 == i })
                                          .count > 1 })))
    for item in contactsFetcher.contacts {
      for i in duplicates{
        if item.firstName + " " + item.lastName == i {
          contact.append(item)
        }
      }
    }
    return (duplicates.count, contact)
  }
  
  //  MARK: - repeating Numbers
  func repeatingNumbers() -> (count: Int, objects: [ContactsDTO]) {
    var contact: [ContactsDTO] = []
    var numberArray = [String]()
    for i in contactsFetcher.contacts{
      numberArray.append(i.phoneNumber)
    }
    let duplicates = Array(Set(numberArray
                                .filter({ (i: String) in numberArray
                                          .filter({ $0 == i })
                                          .count > 1})))
    for item in contactsFetcher.contacts {
      for i in duplicates{
        if item.phoneNumber == i {
          contact.append(item)
        }
      }
    }
    return (duplicates.count, contact)
  }
  
  //  MARK: - without Name
  func withoutName() -> (count: Int,objects: [ContactsDTO]) {
    var contact: [ContactsDTO] = []
    var contactsWithoutName = 0
    var fullNameArray = [String]()
    for i in contactsFetcher.contacts {
      fullNameArray.append(i.firstName + i.lastName)
    }
    for i in fullNameArray {
      if i.isEmpty {
        contactsWithoutName += 1
      }
    }
    for item in contactsFetcher.contacts {
      if item.firstName + item.lastName  == "" {
        contact.append(item)
      }
    }
    return (contactsWithoutName, contact )
  }
  
  //  MARK: - without Number
  func withoutNumber() -> (count: Int,objects: [ContactsDTO]) {
    var contact: [ContactsDTO] = []
    var withoutNumberContacts = 0
    var numberArray = [String]()
    for i in contactsFetcher.contacts {
      numberArray.append(i.phoneNumber)
    }
    for i in numberArray{
      if i.isEmpty {
        withoutNumberContacts += 1
      }
    }
    for item in contactsFetcher.contacts {
      if item.phoneNumber.isEmpty  {
        contact.append(item)
      }
    }
    return (withoutNumberContacts, contact)
  }
  
  //  MARK: - without Email
  func withoutEmail() -> (count: Int, objects: [ContactsDTO]) {
    var contact: [ContactsDTO] = []
    var withoutEmailContacts = 0
    var numberArray = [String]()
    for i in contactsFetcher.contacts{
      numberArray.append(i.email)
    }
    for i in numberArray{
      if i.isEmpty {
        withoutEmailContacts += 1
      }
    }
    for item in contactsFetcher.contacts {
      if item.email.isEmpty  {
        contact.append(item)
      }
    }
    return (withoutEmailContacts, contact)
  }
}
