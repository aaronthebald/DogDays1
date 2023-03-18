//
//  AddContactView.swift
//  DogDays
//
//  Created by Aaron Wilson on 3/14/23.
//

import SwiftUI

struct AddContactView: View {
    
    @ObservedObject var vm: ContactViewModel
    @State var nameTextFieldText: String = ""
    @State var categoryTextFieldText: String = ""
    @State var addressTextFieldText: String = ""
    @State var phoneTextFieldText: String = ""
    @State private var showAlert: Bool = false
    @State var alertTitle: String = ""
    @Binding var showAddContactView: Bool
    
    
    var contactType: [String] = [
    "Groomer", "Veterinarian", "Emergancy Veterinarian", "Pharmacy"
    ]
    
    var body: some View {
        NavigationStack {
            List {
                TextField("Add Name Here...", text: $nameTextFieldText)
                contactCategoryPicker
                TextField("Add Address Here...(Optional)", text: $addressTextFieldText).multilineTextAlignment(.leading)
                TextField("Add Phone Number Here...", text: $phoneTextFieldText).keyboardType(.numberPad)
            }
            .alert(isPresented: $showAlert, content: getAlert)
            .navigationTitle("Add a Contact")
            .toolbar {ToolbarItem(placement: .navigationBarTrailing) {toolBarItem}
        }
        }
    }
}

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView(vm: ContactViewModel(), showAddContactView: .constant(true) )
    }
}

extension AddContactView {
    
private var contactCategoryPicker: some View {
    Picker("Select Category..", selection: $categoryTextFieldText) {
        ForEach(contactType, id: \.self) { type in
            Text("\(type)")
                .tag(type)
            }
        }
    }
    
    private var toolBarItem: some View {
        Button {
            saveButtonPressed()
        } label: {
            Text("Save")
        }.buttonStyle(DefaultButtonStyle())
    }
    
    // MARK: functions
    func saveButtonPressed() {
        if textIsAppropriate() && phoneNumberisAppropriate() {
            vm.saveContact(name: nameTextFieldText, address: addressTextFieldText, phone: phoneTextFieldText, category: categoryTextFieldText, id: UUID().uuidString)
            showAddContactView.toggle()
        }
    }
    
    func phoneNumberisAppropriate() -> Bool {
        if phoneTextFieldText.count < 10 {
            alertTitle = "Please add a phone number with an area code."
            showAlert.toggle()
            return false
        }
        return true
    }
    
    func textIsAppropriate() -> Bool {
        if nameTextFieldText.count < 3 {
            alertTitle = "Please add a name to your contact."
            showAlert.toggle()
            return false
        }
        return true
    }
    
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }
}
