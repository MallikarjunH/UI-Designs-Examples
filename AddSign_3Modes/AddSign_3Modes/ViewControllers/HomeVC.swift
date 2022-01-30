//
//  HomeVC.swift
//  AddSign_3Modes
//
//  Created by EOO61 on 30/01/22.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!
    
    var currentViewController:UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.currentViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignAppearanceVC") as! SignAppearanceVC
        self.currentViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.addChild(self.currentViewController)
        self.addSubview(subView: self.currentViewController.view, parentView: self.containerView)
        
        // Do any additional setup after loading the view.
        self.segmentedControl.selectedSegmentIndex = 0
        self.segmentedControl.setNeedsLayout()
    }
    
    func addSubview(subView: UIView, parentView: UIView){
        
        parentView.addSubview(subView)
        
        // Create a new (key: string, value: string) dictionary
        var viewsDict: Dictionary = [String: String]()
        viewsDict["subView"] = "subView"
        
        
        
        var constraint = NSLayoutConstraint(item: subView,
                                            attribute: NSLayoutConstraint.Attribute.top,
                                            relatedBy: NSLayoutConstraint.Relation.equal,
                                            toItem: self.containerView,
                                            attribute: NSLayoutConstraint.Attribute.top,
                                            multiplier: 1,
                                            constant: 0)
        
        self.view.addConstraint(constraint)
        
        
        constraint = NSLayoutConstraint(item: subView,
                                        attribute: NSLayoutConstraint.Attribute.height,
                                        relatedBy: NSLayoutConstraint.Relation.equal,
                                        toItem: self.containerView,
                                        attribute: NSLayoutConstraint.Attribute.height,
                                        multiplier: 1,
                                        constant: 0)
        
        self.view.addConstraint(constraint)
        
        constraint = NSLayoutConstraint(item: subView,
                                        attribute: NSLayoutConstraint.Attribute.leading,
                                        relatedBy: NSLayoutConstraint.Relation.equal,
                                        toItem: self.containerView,
                                        attribute: NSLayoutConstraint.Attribute.leading,
                                        multiplier: 1,
                                        constant: 0)
        
        self.view.addConstraint(constraint)
        
        
        constraint = NSLayoutConstraint(item: subView,
                                        attribute: NSLayoutConstraint.Attribute.trailing,
                                        relatedBy: NSLayoutConstraint.Relation.equal,
                                        toItem: self.containerView,
                                        attribute: NSLayoutConstraint.Attribute.trailing,
                                        multiplier: 1,
                                        constant: 0)
        
        self.view.addConstraint(constraint)
        
        
    }
    
    @IBAction func segmentsChangedAction(_ sender: Any) {
        
        if segmentedControl.selectedSegmentIndex == 0 {
            
            let newViewController:UIViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignAppearanceVC") as! SignAppearanceVC
            
            newViewController.view.translatesAutoresizingMaskIntoConstraints = false
            
            self.cycleFromViewController(oldViewController: self.currentViewController, newViewController: newViewController)
            self.currentViewController = newViewController
        }
        else if segmentedControl.selectedSegmentIndex == 1{
            
            let newViewController:UIViewController = self.storyboard?.instantiateViewController(withIdentifier: "ImageUploadForSign") as! ImageUploadForSign
            
            newViewController.view.translatesAutoresizingMaskIntoConstraints = false
            
            self.cycleFromViewController(oldViewController: self.currentViewController, newViewController: newViewController)
            self.currentViewController = newViewController
        }
        else {
            
            let newViewController:UIViewController = self.storyboard?.instantiateViewController(withIdentifier: "DrawSignVC") as! DrawSignVC
            
            newViewController.view.translatesAutoresizingMaskIntoConstraints = false
            
            self.cycleFromViewController(oldViewController: self.currentViewController, newViewController: newViewController)
            self.currentViewController = newViewController
        }
    }
    
    func cycleFromViewController(oldViewController: UIViewController, newViewController:UIViewController) {
        
        oldViewController.willMove(toParent: nil)
        
        self.addChild(newViewController)
        self.addSubview(subView: newViewController.view, parentView: self.containerView)
        //newViewController.view.alpha = 0
        newViewController.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.5, animations: {
            
            //   newViewController.view.alpha = 0
            //   oldViewController.view.alpha = 0
            
        }) { (BOOL) in
            
            oldViewController.view.removeFromSuperview()
            oldViewController.removeFromParent()
            newViewController.didMove(toParent: self)
        }
        
    }
    
}
