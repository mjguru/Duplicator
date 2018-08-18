//
//  SafariExtensionHandler.swift
//  Duplicate tab
//
//  Created by Mohit on 18/08/18.
//  Copyright © 2018 Mohit. All rights reserved.
//

import SafariServices

class SafariExtensionHandler: SFSafariExtensionHandler {
    
    override func messageReceived(withName messageName: String, from page: SFSafariPage, userInfo: [String : Any]?) {
        // This method will be called when a content script provided by your extension calls safari.extension.dispatchMessage("message").
        page.getPropertiesWithCompletionHandler { properties in
            NSLog("The extension received a message (\(messageName)) from a script injected into (\(String(describing: properties?.url))) with userInfo (\(userInfo ?? [:]))")
        }
    }
    
    override func toolbarItemClicked(in window: SFSafariWindow) {
        // This method will be called when your toolbar item is clicked.
        NSLog("The extension's toolbar item was clicked")
       // let url = URL(string: "https://www.apple.com")
      //  window.openTab(with: url!,makeActiveIfPossible: false)
        window.getActiveTab() {
            (tab: SFSafariTab?) in
            tab?.getActivePage() {
                (page: SFSafariPage?) in
                page?.getPropertiesWithCompletionHandler() {
                    (properties: SFSafariPageProperties?) in
                    let url = properties?.url
                    let urlString = url?.absoluteString
                    if((urlString) != nil) {
                        window.openTab(with: url!, makeActiveIfPossible: false, completionHandler: { (tab:SFSafariTab?) in
                            NSLog("Done!")
                        })
                    }
                }
            }
        }
    }
    
    override func validateToolbarItem(in window: SFSafariWindow, validationHandler: @escaping ((Bool, String) -> Void)) {
        // This is called when Safari's state changed in some way that would require the extension's toolbar item to be validated again.
        validationHandler(true, "")
    }
    
    override func popoverViewController() -> SFSafariExtensionViewController {
        return SafariExtensionViewController.shared
    }

}
