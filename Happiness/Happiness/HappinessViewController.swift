//
//  HappinessViewController.swift
//  
//
//  Created by LiuWei on 15/9/11.
//
//

import UIKit

class HappinessViewController: UIViewController,FaceViewDataSource{
    
    private struct Constants {
        static let HappinessGestureScale:CGFloat = 4
    }
    
    @IBAction func changeHappiness(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .Ended : fallthrough
        case .Changed:
            let translation = gesture.translationInView(faceView)
            let happnessChange = -Int(translation.y/Constants.HappinessGestureScale)
            if happnessChange != 0 {
                happiness += happnessChange
                gesture.setTranslation(CGPointZero, inView: faceView)
            }
        default: break
        }
    }

    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.dataSource = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action:"scale:"))
        }
    }
    
    var happiness:Int = 100 {// 0 = very sad, 100 = ecstatic
        didSet {
            happiness = min(max(happiness, 0), 100)
            println("happiness = \(happiness)")
            updateUI()
        }
    }
    
    func updateUI() {
        faceView.setNeedsDisplay()
    }
    
    func smilinessForFaceView(sender: FaceView) -> Double? {
        return Double(happiness-50)/50
    }
}
