//
//  ViewController.swift
//  IBDesignable-And-IBInspectable
//
//  Created by Mallikarjun H on 20/05/22.
//

/*
@IBDesignable provides functionality for live rendering of changes of our custom views directly in a Storyboard or .xib. All we have to do is mark the class of a custom view with a @IBDesignable attribute and implement the prepareForInterfaceBuilder() method.
 
@IBInspectable allows us to create attributes in code that we can assign in a storyboard or a .xib file. For example, when we want a cornerRadius property available in a Storyboard, we create a cornerRadius property inside our custom view and mark it with @IBInspectable.
 */

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

