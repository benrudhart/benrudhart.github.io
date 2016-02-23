---
layout: post
title: PopoverControllers for iPhone
excerpt: How to use native PopoverControllers on iPhone
---

In case you ever wanted to use a popoverController for the iPhone you've probably stumbled upon this [reference](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIPopoverController_class/index.html): *Popover controllers are for use **exclusively on iPad** devices.* 

Until iOS 8 one had to build a custom solution or use one of the [open source implementations](https://cocoapods.org/?q=popover) like [FPPopover](https://github.com/alvises/FPPopover).

## UIPopoverPresentationController to the rescue
Starting from iOS 8 one can use [`UIPopoverPresentationController`](https://developer.apple.com/library/prerelease/ios/documentation/UIKit/Reference/UIPopoverPresentationController_class/index.html) to present popovers. As of iOS 9 the old UIPopoverController is also deprecated.
Setting up a ViewController to be presented as a popover is pretty simple.

In your storyboard you create a segue to the controller you want to display as a popover. This time you chose `Action Segue` > `Present As Popover`

Before the presentation of the viewController you have to do some setup (e.g. in `prepareForSegue(segue: sender:)`):
`segue.destinationViewController?.popoverPresentationController.delegate = self`

In order to conform be the delegate `self` has to conform to  `UIPopoverPresentationControllerDelegate`:

```
extension YourController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
}
```

**Note:** you have to return `.None` and not `.Popover` here!

Of course UIPopoverPresentationController is also available for iPads.

For a quick start you might want to look at this [example project](https://github.com/AppGrade/appgrade.github.io/tree/master/assets/examples/2016_02_23%20PopoveriPhone).


