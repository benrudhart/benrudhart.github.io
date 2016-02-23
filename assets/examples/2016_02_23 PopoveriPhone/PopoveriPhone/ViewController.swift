//
//  ViewController.swift
//  PopoveriPhone
//
//  Created by Ben Rudhart on 23/02/16.
//  Copyright © 2016 AppGrade. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination = segue.destinationViewController
        
        guard let popoverController = destination.popoverPresentationController else {
            assertionFailure("no popoverPresentationController")
            return
        }
        
        popoverController.delegate = self
    }
}

extension ViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        // in order to present this VC as a popover we have to return .None here
        return .None
    }
}
