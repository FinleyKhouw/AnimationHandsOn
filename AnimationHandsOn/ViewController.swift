//
//  ViewController.swift
//  AnimationHandsOn
//
//  Created by Finley Khouwira on 15/05/19.
//  Copyright © 2019 Finley Khouwira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var red: CGFloat!
    var blue: CGFloat!
    var green: CGFloat!
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    var itemBehaviour: UIDynamicItemBehavior!
    
    @IBOutlet weak var movingItem: UIView!
    var tapGesture = UITapGestureRecognizer()
    var swipeGesture = UISwipeGestureRecognizer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.movingItem.layer.cornerRadius = self.movingItem.frame.width / 2
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.itemDidTapped(_:)))
        swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.itemDidSwiped(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        swipeGesture.direction = .down
        swipeGesture.numberOfTouchesRequired = 1
        movingItem.addGestureRecognizer(tapGesture)
        movingItem.addGestureRecognizer(swipeGesture)
        movingItem.isUserInteractionEnabled = true
        print(movingItem.frame)
        gravityAction()
    }
    
    @objc func itemDidTapped(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.5, animations: ({
            self.moveRandomly(view: self.movingItem)
            self.changeColor(view: self.movingItem)
            self.gravityAction()
        }), completion: nil)
    }
    
    @objc func itemDidSwiped(_ sender: UISwipeGestureRecognizer) {
        UIView.animate(withDuration: 1, delay: 0, options: .autoreverse, animations: ({
            self.moveRandomly(view: self.movingItem)
        }), completion: nil)
    }
    
    func moveRandomly(view: UIView) {
        let itemXPosition = CGFloat.random(in: 10...400)
        let itemYPosition = CGFloat.random(in: 0...700)
        
        movingItem.center.x = itemXPosition
        movingItem.center.y = itemYPosition
    }
    
    func changeColor(view: UIView) {
//        red = CGFloat(Float.random(in: 0...1) % 255)
//        blue = CGFloat(Float.random(in: 0...1) % 255)
//        green = CGFloat(Float.random(in: 0...1) % 255)
        
        red = randomCGFloat()
        blue = randomCGFloat()
        green = randomCGFloat()
        movingItem.backgroundColor = UIColor(displayP3Red: self.red, green: self.green, blue:
            self.blue, alpha: 1)
    }
    
    func randomCGFloat() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
    
    func gravityAction(){
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior(items: [movingItem])
        animator.addBehavior(gravity)
        
        collision = UICollisionBehavior(items: [movingItem])
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        itemBehaviour = UIDynamicItemBehavior(items: [movingItem])
        itemBehaviour.elasticity = 0.5
        itemBehaviour.charge = 1.0
        animator.addBehavior(itemBehaviour)
    }
}

