//
//  FetchContacts.swift
//  Contacts
//
//  Created by Ann Yesip on 01.07.2021.
//

import UIKit
import ContactsUI

protocol ContactsFetcher {
  var contacts: [ContactsDTO] { get }
  func fetchContacts()
}

final class ContactFetcherImp: ContactsFetcher {
  var contacts = [ContactsDTO]()
  
  func fetchContacts() {
    let store = Contacts.CNContactStore()
      store.requestAccess(for: .contacts) { (granted, error) in
        if let error = error {
          print("failed to request access", error)
          return
        }
        if granted {
          let keys = [
            CNContactGivenNameKey,
            CNContactFamilyNameKey,
            CNContactPhoneNumbersKey,
            CNContactEmailAddressesKey
          ]
          let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
          do {
            try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointer) in
              self.contacts.append(ContactsDTO(
                firstName: contact.givenName,
                lastName: contact.familyName,
                phoneNumber: contact.phoneNumbers.first?.value.stringValue ?? "",
                email:contact.emailAddresses.first?.value.abbreviatingWithTildeInPath ?? "")
              )
            })
          } catch let error {
            print("Failed to enumerate contact", error)
          }
        } else {
          print("access denied")
        }
      }
  }
}
