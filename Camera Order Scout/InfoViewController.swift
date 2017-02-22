//
//  InfoViewController.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 2/21/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//
//  nice to have a swipe left / right gestur to page through tutrial
//  counter to show progress on tab bar type thing on the bottom
//  whenswipe right to last document aGot It button returns to main

// just need to make border clear - might be better with buttons

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!

    @IBOutlet weak var gotIt: UIButton!
    
    @IBOutlet weak var progress: UISegmentedControl!
    
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        gotIt.isHidden = true
        
        populatePicture(counter: 0)

        self.progress.layer.borderWidth = 0.2

    }

    @IBAction func gotItAction(_ sender: Any) {
        
        _ = navigationController?.popToRootViewController(animated: true)
        
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                print("Swiped right")
                counter += 1
            case UISwipeGestureRecognizerDirection.left:
                print("Swiped left")
                counter -= 1
            default:
                break
            }
        }
        if counter >= 3 { counter = 3 }
        if counter < 0 { counter = 0 }
        populatePicture(counter: counter)
        showButton(counter: counter)
        print(counter)
    }
    
    
    func populatePicture(counter: Int) {
        
        switch counter {
        case 0:
            image.image = UIImage(named: "test 1")
            progress.selectedSegmentIndex = 0
        case 1:
            image.image = UIImage(named: "test 2")
            progress.selectedSegmentIndex = 1
        case 2:
            image.image = UIImage(named: "test 3")
            progress.selectedSegmentIndex = 2
        case 3:
            image.image = UIImage(named: "test 4")
            progress.selectedSegmentIndex = 3
        default:
            image.image = UIImage(named: "test 4")
            progress.selectedSegmentIndex = 0
        }
        
    }
    
    func showButton(counter: Int ) {
        if counter == 3 {
            gotIt.isHidden = false
        } else {
            gotIt.isHidden = true
        }
    }

}
