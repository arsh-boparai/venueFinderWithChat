//
//  MessageComposer.swift
//  PartyAppX
//
//  Created by Arshdeep Singh on 2018-07-30.
//  Copyright © 2018 Arshdeep Singh. All rights reserved.
//
import Foundation
import MessageUI
import UIKit
var contactsNumber = [String]()
class MessageComposer: NSObject, MFMessageComposeViewControllerDelegate {

    func canSendText() -> Bool {
        return MFMessageComposeViewController.canSendText()
        
    }
    func configuredMessageComposeViewController() -> MFMessageComposeViewController {
        let messageComposeVC = MFMessageComposeViewController()
        messageComposeVC.messageComposeDelegate = self  //  Make sure to set this property to self, so that the controller can be dismissed!
        messageComposeVC.recipients = contactsNumber
//        messageComposeVC.body =  "Event Invitation: " + "Event Name: " + "\(String(describing: name.text))" + "Theme: "  + "\(String(describing: theme.text))" + "Place: "  + "\(String(describing: place.text))" + "Date: "  + "\(String(describing: dateLabel.text))"
        messageComposeVC.body =  "Sending Text Message through SMS in Swift"
        return messageComposeVC
    }
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
}
