//
//  ContactsViewModel.swift
//  Practice
//
//  Created by Cypress on 8/4/21.
//

import RxSwift
import RxRelay
import Contacts

final class ContactsViewModel {
  
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    private let contactStore = CNContactStore()
    
    // MARK: - Inputs
    
    let refresh = PublishRelay<Void>()
    
    // MARK: - Outputs
    
    let contacts = PublishRelay<[Contact]>()
    
    init() {
        doBindings()
    }
    
    // MARK: - Methods

    private func doBindings() {
        refresh
            .compactMap { [weak self] in
                self?.fetchContacts()
            }
            .map { $0.filter { !($0.email?.isEmpty ??  true) } }
            .bind(to: contacts)
            .disposed(by: disposeBag)
    }
    
    func fetchContacts() -> [Contact]? {
        let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactEmailAddressesKey] as [CNKeyDescriptor]
        do {
            return try self.contactStore.containers(matching: nil)
                .flatMap { container -> [Contact] in
                    let predicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier)
                    let results = try self.contactStore.unifiedContacts(matching: predicate, keysToFetch: keys)
                    return results.map { result in
                        let name = result.givenName
                        let lastName = result.familyName
                        let email = result.emailAddresses.first?.value
                        return Contact(name: name, lastName: lastName, email: email as String?)
                    }
                }
        } catch {
            print("Contacts Fetching Error")
        }
        return nil
    }
}
