//
//  FirstViewController.swift
//  party4upro
//
//  Created by Nancy Sharma on 2018-07-14.
//  Copyright © 2018 Nancy Sharma. All rights reserved.
//
import Contacts
import ContactsUI
import UIKit
import MessageUI
import Firebase

class FirstViewController: UIViewController,  CNContactPickerDelegate, UITableViewDelegate, UITableViewDataSource, MFMessageComposeViewControllerDelegate  {
    var refArtists: DatabaseReference!
    var contactss = [String]()
     var contactsNumber = [String]()
   
   
    func canSendText() -> Bool {
        return MFMessageComposeViewController.canSendText()
        
    }
    func configuredMessageComposeViewController() -> MFMessageComposeViewController {
        let messageComposeVC = MFMessageComposeViewController()
        messageComposeVC.messageComposeDelegate = self  //  Make sure to set this property to self, so that the controller can be dismissed!
        messageComposeVC.recipients = contactsNumber
                messageComposeVC.body =  "Event Invitation: \n" + "Event Name: " + "\(String(describing: name.text!))\n" + "Theme: "  + "\(String(describing: theme.text!))\n" + "Place: "  + "\(String(describing: place.text!))\n" + "Date: "  + "\(String(describing: dateLabel.text!))\n"
      
        return messageComposeVC
    }
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
       
      tableView.dataSource = self
        tableView.delegate = self
        refArtists = Database.database().reference().child("events");
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FirstViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
     
    }
    func addEvents(){
        let key = refArtists.childByAutoId().key
        let event = ["id":key,"eventName": name.text! as String,"eventTheme": theme.text! as String,"eventPlace": place.text! as String,"eventDate": dateLabel.text! as String,"GuestsList": contactss ] as [String : Any]
       
        refArtists.child(key).setValue(event)
        labelMessage.text = "Event Saved"
    }
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
        for contact in contacts {
            
            contactss.append(contact.givenName)
            contactsNumber.append((contact.phoneNumbers[0].value ).value(forKey: "digits") as! String)
           
        }
      
      
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        let strDate = dateFormatter.string(from: datePicker.date)
        dateLabel.text = strDate
    }
    
    //outlets
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var theme: UITextField!
    @IBOutlet weak var place: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
 
    @IBOutlet weak var tableView: UITableView!
    
    
    
    @IBAction func selectContacts(_ sender: UIButton) {
        
        let contactPicker = CNContactPickerViewController()
        
        contactPicker.delegate = self
        contactPicker.displayedPropertyKeys = [CNContactPhoneNumbersKey]
        
        self.present(contactPicker, animated: true, completion: nil)
        
    }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactss.count
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier: String = "myCell5"
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        
        cell.textLabel?.text = contactss[indexPath.row]
        
        return cell
    }
    //Actions
    
    @IBAction func Saved(_ sender: UIButton) {
        
    }
    
    @IBAction func Save(_ sender: UIButton) {
        addEvents()
        let alert = UIAlertController(title: "Data Saved", message: "Send Invitation to the Selected Guests.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {ACTION in self.messagesending()}))
        self.present(alert, animated: true, completion: nil)
        labelMessage.isHidden = true
       
    }
    func  messagesending(){
    if(canSendText()){
    let m = configuredMessageComposeViewController()
    present(m, animated: true, completion: nil)
    }else{
    let errorAlert = UIAlertController(title: "cannot Send Text Message", message: "Your Device is not able to send text message.", preferredStyle: UIAlertControllerStyle.alert)
    errorAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
    self.present(errorAlert, animated: true, completion: nil)
    }
    }
   
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


