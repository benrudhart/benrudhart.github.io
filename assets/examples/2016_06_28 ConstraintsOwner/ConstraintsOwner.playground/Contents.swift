//: This Playground helps to find the proper owner of a layoutConstraint
// compiles with Xcode 8.0 beta (8S128d)/ Swift 3, beta 1
import UIKit
import PlaygroundSupport
import XCPlayground

extension UIView {
    func nonNilConstraintIdentifiers() -> [String] {
        return constraints.flatMap { $0.identifier }
    }
}

let contentView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
contentView.backgroundColor = #colorLiteral(red: 0.1991284192, green: 0.6028449535, blue: 0.9592232704, alpha: 1)
PlaygroundPage.current.liveView = contentView


let padding: CGFloat = 15

func createAndAddLabel(text: String) -> UILabel {
    let label = UILabel()
    contentView.addSubview(label)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -2*padding).isActive = true
    label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding).isActive = true
    label.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.4).isActive = true
    
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 80)
    label.text = text
    
    return label
}

//: setup two labels as subviews of one common superview (contentView)
let label1 = createAndAddLabel(text: "1")
let label2 = createAndAddLabel(text: "2")
label1.backgroundColor = #colorLiteral(red: 0.9559464455, green: 0.7389599085, blue: 0.2778314948, alpha: 1)
label2.backgroundColor = #colorLiteral(red: 0.4028071761, green: 0.7315050364, blue: 0.2071235478, alpha: 1)



//: constraint the leading anchor and use an identifier for later identification of the constraints
let label1LeadingConstraint = label1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding)
label1LeadingConstraint.identifier = "Label 1 Leading Constraint"
label1LeadingConstraint.isActive = true

let label2LeadingConstraint = label2.leadingAnchor.constraint(equalTo: label1.trailingAnchor, constant: padding)
label2LeadingConstraint.identifier = "Label 2 Leading Constraint"
label2LeadingConstraint.isActive = true

let a = contentView.constraints.filter { $0.identifier == "Label 1 Leading Constraint"}.first
print(a)

//: obtain list of nonNilIdentifiers for label1, label2 and contentView. Here the identifier helps to filter for the leading constraints (per default all other constraint identifiers are nil)
label1.nonNilConstraintIdentifiers().count
label2.nonNilConstraintIdentifiers().count
contentView.nonNilConstraintIdentifiers().count

//: it's obvious that only the contentView contains constraints that have an identifier. check:
contentView.nonNilConstraintIdentifiers()


