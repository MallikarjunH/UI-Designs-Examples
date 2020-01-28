//
//  UIView+Promise.swift
//  divco
//
//  Created by Irina Butaru on 20/08/2019.
//  Copyright © 2019 Irina Butaru. All rights reserved.
//

import PromiseKit
import UIKit.UIView

extension UIView {
    /**
     Animate changes to one or more views using the specified duration, delay,
     options, and completion handler.

     - Parameter duration: The total duration of the animations, measured in
     seconds. If you specify a negative value or 0, the changes are made
     without animating them.

     - Parameter delay: The amount of time (measured in seconds) to wait before
     beginning the animations. Specify a value of 0 to begin the animations
     immediately.

     - Parameter options: A mask of options indicating how you want to perform the
     animations. For a list of valid constants, see UIViewAnimationOptions.

     - Parameter animations: A block object containing the changes to commit to the
     views.

     - Returns: A promise that fulfills with a boolean NSNumber indicating
     whether or not the animations actually finished.
     */
    public class func promise(animateWithDuration duration: TimeInterval,
                              delay: TimeInterval = 0,
                              options: UIView.AnimationOptions = [],
                              animations: @escaping () -> Void) -> Guarantee<Bool> {
        return Guarantee { fulfill in
            DispatchQueue.main.async {
                animate(withDuration: duration,
                        delay: delay,
                        options: options,
                        animations: animations) { completed in
                            fulfill(completed)
                }
            }
        }
    }
    public class func promise(animateWithDuration duration: TimeInterval,
                              delay: TimeInterval = 0,
                              damping: CGFloat,
                              initialVelocity: CGFloat,
                              options: UIView.AnimationOptions = [],
                              animations: @escaping () -> Void) -> Guarantee<Bool> {
        return Guarantee { fulfill in
            DispatchQueue.main.async {
                animate(withDuration: duration,
                        delay: delay,
                        usingSpringWithDamping: damping,
                        initialSpringVelocity: initialVelocity,
                        options: options,
                        animations: animations) { completed in
                            fulfill(completed)
                }
            }
        }
    }
}

