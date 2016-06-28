---
layout: post
title: Owner of NSLayoutConstraint
excerpt: The UIView that "owns" a constraint might be unexpected
---

When working with Autolayout the [`identifier`](https://developer.apple.com/library/ios/documentation/AppKit/Reference/NSLayoutConstraint_Class/index.html#//apple_ref/occ/instp/NSLayoutConstraint/identifier) property of a NSLayoutConstraint can be helpful to re-identify a specific constraint of a UIView. This might for example come in handy when you want to modify the constant of a constraint dynamically at runtime. 

Side node: It's quite fun that a property with the name `constant` is the only property of a [NSLayoutConstraint](https://developer.apple.com/library/ios/documentation/AppKit/Reference/NSLayoutConstraint_Class/index.html) that is `readwrite` and allowed to be modified after the constant is activated. 😜👍

Using the `identifier` to identify a specific constraint might help if you don't want/ can't store a reference to a certain constraint. In order to obtain the reference to the constraint you simply filter the list of [constraints](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIView_Class/index.html#//apple_ref/occ/instp/UIView/constraints) of the view.

```swift
aView.constraints.filter { $0.identifier == "my constraint identifier"}.first
```

But this might turn out more tricky than expected bc. a constraint might not be found in the `constraints` of the view it constrains. 😱

For instance the leading/ trailing/ top/ bottom constraints of a view are to be found in it's superview's list of constraints. That's still true if a view is constrained to a sibling view and not to its superview:

```swift
// view1 and view2 are both subviews of a common superview
// constraint view2.leadingAnchor to view1.trailingAnchor
view2.leadingAnchor.constraint(equalTo: view1.trailingAnchor).active = true

// the created constraint will be found in their common superview
// neither in view1.constraints nor in view2.constraints
```

If you want to take a look for yourself you might find [this playground](https://github.com/benrudhart/benrudhart.github.io/tree/master/assets/examples/2016_06_28%20ConstraintsOwner) helpful.

So the next time you're looking to obtain a reference to a layoutConstraint you might want to look in the `constraints` of the view's superview! This might save you some time 😎⏲



