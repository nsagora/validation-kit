//: [Previous](@previous)

import Foundation
import ValidationToolkit

/*:
 ## ConstraintSet
 
 In the following example we use a `ConstraintSet` to evaluate the strength of the user password.
 */

let lowerCasePredicate = RegexPredicate(expression: "^(?=.*[a-z]).*$")
let upperCasePredicate = RegexPredicate(expression: "^(?=.*[A-Z]).*$")
let digitsPredicate = RegexPredicate(expression: "^(?=.*[0-9]).*$")
let specialChars = RegexPredicate(expression: "^(?=.*[!@#\\$%\\^&\\*]).*$")
let minLenght = RegexPredicate(expression: "^.{8,}$")

var passwordConstraint = CompoundContraint<String, Form.Password>(allOf:
    PredicateConstraint(predicate: lowerCasePredicate, error: .missingLowercase),
    PredicateConstraint(predicate: upperCasePredicate, error: .missingUpercase),
    PredicateConstraint(predicate: digitsPredicate, error: .missingDigits),
    PredicateConstraint(predicate: specialChars, error: .missingSpecialChars),
    PredicateConstraint(predicate: minLenght, error: .minLenght(8))
)

let password = "3nGuard!"
let result = passwordConstraint.evaluate(with: password)

switch result {
case .success:
    print("Wow, that's a 💪 password!")
case .failure(let summary):
    print(summary.errors.map({$0.localizedDescription}))
}