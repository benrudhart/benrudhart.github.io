---
layout: post
title: Floating Subviews in UIScrollViews
excerpt: Create floating (i.e. non scrolling) subviews in UIScrollViews like UICollectionView or UITableView
---

Sometimes you might need a view that is floating on top of a `UITableView` or any kind of `UIScrollView`. A no-brainer implementation is to add the floating view to the scrollView’s superview i.e. above the scrollView. The scrollView will still scroll while your floating view remains at it’s initial position. You're done 👍

### The problem
But what if the scrollView itself is the `view` of your viewController and you don’t want to change this. For instance if your viewController is a `UITableViewController` you get some behavior for free - like keyboard handling. When wrapping this tableView inside a containerView that also holds your floating view you'll have to take care of this behavior yourself. Additionally this messes up your view hierarchy which you might want to avoid. Therefore using a plain `UIViewController` might not be an option for you. Adding the floating view to the superview of the viewControllers view is too hacky and hence not considered a valid solution.

### A possible solution: Autolayout
When sticking with a plain `UITableViewController` you got to add the floating view as a childView to the view of the controller i.e. the `tableView`: 

~~~swift
tableView.addSubview(floatingView)
~~~

Now to achieve the *floating* behavior you might want to use Autolayout.
See this  Technical Note on [UIScrollView and Autolayout](https://developer.apple.com/library/ios/technotes/tn2154/_index.html):

> Note that you can make a subview of the scroll view appear to float (not scroll) over the other scrolling content by creating constraints between the view and a view outside the scroll view’s subtree, such as the scroll view’s superview.

Simply constrain the floatingView to a superview of the scrollView:

~~~swift
// make sure floatingView is ready for Autolayout setup
floatingView.translatesAutoresizingMaskIntoConstraints = false

// add constrain to achieve floating
let superTopAnchor = tableView.superview?.topAnchor // make sure this is given!
let floatingConstant: CGFloat = 30
floatingView.topAnchor.constraintEqualToAnchor(superTopAnchor, constant: floatingConstant).active = true
~~~

Your floatingView will now float - stick to the top while the scrollView scrolls. 🎉

### Edge case UINavigationController
If the scrollView’s viewController is part of a `UINavigationController` scene you might get in trouble. As your viewController get’s invisible (due to the presentation of the next viewController) the scrollView’s superview becomes `nil`. Hence the Autolayout constraint will break and the floatingView stops to float. At this time it's already not visible anymore. You have to re-establish the constraint as soon as the user navigates back to your scrollView and it's superview becomes available again.

There are several options to observe the superview property: 

- use a custom subclass of the scrollView and implement `didMoveToSuperview:`
- implement `viewDidAppear:` inside your viewController
- implement the `UINavigationControllerDelegate` callback `navigationController:didShowViewController:animated:`
- unfortunately the `superview` property of a `UIView` **cannot** be observed via `KVO`

One might argue that the floatingView could have been directly added to the superview in the first place. That is probably right and just a matter of taste which of these solutions one considers less hacky...
