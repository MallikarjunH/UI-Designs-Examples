//
//  ViewController.swift
//  CustomPopUpExample
//
//  Created by EOO61 on 25/03/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func showPopUoButtonAction(_ sender: Any) {
        
        let newWindow = UIApplication.shared.keyWindow!
        let bgView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        bgView.backgroundColor = UIColor(red:56/255,green:63/255,blue:65/255,alpha:0.2) //UIColor.clear
        newWindow.addSubview(bgView)
        
        let createView = self.loadView(fromNib: "NewMyAddaCreatePopUp", withType: NewMyAddaCreatePopUp.self)
        
       // createView.frame = CGRect(x:12, y:UIScreen.main.bounds.height , width:UIScreen.main.bounds.width - 24,height:265 - 51)
        createView.frame = CGRect(x:0, y:UIScreen.main.bounds.height , width:UIScreen.main.bounds.width,height:265-55)
        bgView.addSubview(createView)//UIScreen.main.bounds.height - 295 - 12
        var newCenter = createView.frame
        //createView.bgView = bgView
         bgView.addGestureRecognizer(UITapGestureRecognizer(target:createView , action: #selector( createView.didTabOnCross)))
       // newCenter.origin = CGPoint(x: 12, y: UIScreen.main.bounds.height - 265 + 51 - 12)
        newCenter.origin = CGPoint(x: 0, y: UIScreen.main.bounds.height - 265 + 51 - 12)
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            
            createView.frame = newCenter
        }, completion: { finished in
            //self.blurView.isHidden = false
        })
    }
    
    func loadView<T>(fromNib name: String, withType type: T.Type) -> T {
       if let view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? T {
           return view
       }
       fatalError("Could not load view with type " + String(describing: type))
   }
   
}

