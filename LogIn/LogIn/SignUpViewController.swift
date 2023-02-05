//
//  SignUpViewController.swift
//  LogIn
//
//  Created by Nidhi Pabbathi on 2/4/23.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var picker: UIPickerView!
    let data = ["Mentor", "Mentee"]
    var selected = "Mentee"
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.dataSource = self
        picker.delegate = self
    }
    //check the feilds and validate the data is correct, is everything is correct it returns nil otherwise the error message
    func validateFeilds() -> String? {
        
        //check that all fields are filled
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "please fill in all fields"
        }
        
        //check if password is secure
        if passwordTextField.text!.count < 6 {
            return "password length is less than 6"
        }
        
        return nil
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        //validate the fields
        let error = validateFeilds()
        if error != nil {
            showError(error!)
        } else {
            // create cleaned versions of the data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)


            Auth.auth().createUser(withEmail: email, password: password) {(result, err) in
                if err != nil {
                    //there is an error!
                    self.showError("error creating user")
                } else {
                    let db = Firestore.firestore();
                    
                    db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName,"role":self.selected,"uid":result!.user.uid]) {(error) in
                        
                        if error != nil{
                            self.showError("Error saving user data")
                        }
                    }
                    //transition to the home screen
                    self.transitionToHome()
                }
            }
            
        }
        //create the user
    }
    
    func showError(_ message: String) {
        errorLabel.text = message;
        errorLabel.alpha = 1
    }
    
    func transitionToHome()
    {
        let homeViewController =
        storyboard?.instantiateViewController(withIdentifier: "HomeVC") as?HomeViewController
        view.window?.rootViewController = homeViewController;
        view.window?.makeKeyAndVisible()
    }
    
    
}

extension SignUpViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    
}
extension SignUpViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selected = data[row]
    }
}
