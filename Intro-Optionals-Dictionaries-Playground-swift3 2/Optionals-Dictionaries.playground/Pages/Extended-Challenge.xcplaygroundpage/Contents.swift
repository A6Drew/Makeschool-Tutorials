/*:
 ![Make School Banner](./swift_banner.png)
 # Dictionaries and Optionals Extended Challenge
 
 ## A more robust contact book
 
 In this exercise, we will extend our previous challenge code to be more robust.
 
 ### Extended challenge
 
 Now that we have some basic code, it's time to "refactor" it!
 
 1. Create a `ContactBook` class. It should have the same functionality as the previous challenge, including `addContact`, `findContact`, `updateContact`, `deleteContact`, and `allContacts` methods.
 1. Create a `ContactDetails` class. Replace your values with this class and update your methods accordingly. You'll want to update what they print out to make sense. We're going to leave this pretty open ended for you but here are some other values to consider: home phone, cell phone, email, Facebook profile, LinkedIn profile. How will you store these? Maybe you should use optionals... hint hint ;)
 1. Create a few `ContactBook` objects and add data to them. Test them out!
 
 - callout(Additional Challenge): Try implementing a favorite contacts feature in `ContactBook`. All these contacts should be accessable via the normal methods but you should also include a new `favoriteContacts` method that only prints out your favorites!
 
 */

    
    var phoneBook = [String: String ]()
    var contactDetails = [String: String]()
    
    
    func addContact(name: String, phoneNumber: String, email: String) {
        
        phoneBook [name] = phoneNumber
        contactDetails [name] = email
        
        print("\(name) has been added to your phone book")
    
        
        
    }
    func findContact(name: String) {
        
        if let contact = phoneBook[name] {
            print("Andrew can be called at \(contact).")
        }

        else {
            print("There is no \(name) in your phone book")
        }
        
    }
    
func updateContact(name: String, phoneNumber: String, email: String) {
    
        if let contact = phoneBook[name] {
            print("\(name) has been updated in your phone book.")
            phoneBook [name] = phoneNumber
            contactDetails [name] = email
        } else {
            print("\(name) did not exist. It has now been added to your phone book.")
            phoneBook [name] = phoneNumber
            contactDetails [name] = email
        }
        
    }
    
    func deleteContact(name: String) {
        if let contact = phoneBook[name] {
            print("\(name) has been deleted from your phone book")
            phoneBook[name] = nil
        }
        else {
            print("\(name) did not exist")
        }
    }
    
    func allContacts() {
        for key in phoneBook.keys {
            if let contact = phoneBook[key] {
                print("\(key) can be called at \(phoneBook[key]!)")
            }
        }
        
    }


addContact(name: "Andrew", phoneNumber: "123", email: "stuff")
updateContact(name: "Andrew", phoneNumber: "235", email: "stuffz")





/*:
 [Previous](@prev)
 */
