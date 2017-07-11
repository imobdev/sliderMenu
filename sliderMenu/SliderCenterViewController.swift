//
//  SliderCenterViewController.swift
//  SideMenu
//
//  Created by Rajat on 7/4/17.
//  Copyright © 2017 Rajat. All rights reserved.
//

import UIKit


class SliderCenterViewController: UIViewController  {
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      
    }
     override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    class slideMenu
    {
         var slideMenu = sideMenuViewController()
         var itemNames = NSMutableArray()
         var isSlideOpen:Bool = false
        var sideMenuBackgroundColor : UIColor!
        
        //var vc : sideMenuViewController!
         private var backgroundView = UIView()
         private var tapGesture :UITapGestureRecognizer!
         private var leftSwipeGesture :UISwipeGestureRecognizer!
         private var rightSwipeGesture :UISwipeGestureRecognizer!
         private var panGesture : UIPanGestureRecognizer!
         private var sliderController = SliderCenterViewController()
        
        
        
    func initialize(_ view:UIView)
    {
        //Did Layout Subviews
        //sideMenu.delegate = self
        backgroundView.frame = CGRect(x: 0,y:0,width:UIScreen.main.bounds.size.width,height:UIScreen.main.bounds.size.height)
        backgroundView.backgroundColor = UIColor.black
        backgroundView.alpha = 0
        
        view.addSubview(backgroundView)
        view.addSubview(slideMenu.view)
        
        if !isSlideOpen
        {
            isSlideOpen = false
            backgroundView.alpha = 0
            slideMenu.view.frame = CGRect(x: -(0.8 * UIScreen.main.bounds.size.width),y:0,width:0.8 * UIScreen.main.bounds.size.width,height:sliderController.view.frame.size.height)
        }
        else
        {
            isSlideOpen = true
            backgroundView.alpha = 0.5
            slideMenu.view.frame = CGRect(x:0,y:0,width: (0.8 * UIScreen.main.bounds.size.width) ,height:UIScreen.main.bounds.size.height)
        }
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeMenu))
        backgroundView.addGestureRecognizer(tapGesture)
        
        leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        leftSwipeGesture.direction = .left
        view.addGestureRecognizer(leftSwipeGesture)
        
        rightSwipeGesture = UISwipeGestureRecognizer(target:self , action :#selector(respondToSwipeGesture(_:)))
        rightSwipeGesture.direction = .right
        view.addGestureRecognizer(rightSwipeGesture)
        
        panGesture = UIPanGestureRecognizer(target:self,action:#selector(moveDrawer(_:)))
        panGesture.maximumNumberOfTouches = 1
        panGesture.minimumNumberOfTouches = 1
        view.addGestureRecognizer(panGesture)
       
        if(sideMenuBackgroundColor != nil)
        {
          slideMenu.tableView.backgroundColor = sideMenuBackgroundColor
        }
       
        
    }
    func MenuTitleNames(_ menuName :NSMutableArray)
    {
       slideMenu.menuTitleNames =  menuName
    }
     func clearMenuTitleName()
    {
         slideMenu.menuTitleNames.removeAllObjects()
    }
    
    
    func openMenu()
    {
        isSlideOpen = true
        UIView.animate(withDuration: 0.3,  animations: {
            self.backgroundView.alpha = 0.6
            self.slideMenu.view.frame = CGRect(x:0,y:0,width: (0.8 * UIScreen.main.bounds.size.width) ,height:UIScreen.main.bounds.size.height)
            
        })
    }
    @objc func closeMenu()
    {
        isSlideOpen = false
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundView.alpha = 0
            self.slideMenu.view.frame = CGRect(x: -(0.8 * UIScreen.main.bounds.size.width),y:0,width:0.8 * UIScreen.main.bounds.size.width,height:UIScreen.main.bounds.size.height)
        })
        
    }
    
    
     @objc func respondToSwipeGesture(_ gesture :UISwipeGestureRecognizer)
    {
        switch gesture.direction
        {
        case UISwipeGestureRecognizerDirection.left:
            closeMenu()
            break
        case UISwipeGestureRecognizerDirection.right:
            openMenu()
            break
        case UISwipeGestureRecognizerDirection.up :
            print("UP")
            break
        case UISwipeGestureRecognizerDirection.down:
            print("Down")
            break
        default:
            break
        }
    }
    
   @objc  func moveDrawer(_ gesture:UIPanGestureRecognizer)
    {
        let translation = gesture.translation(in: sliderController.view)
        let velocity = gesture.velocity(in: sliderController.view)
        
        if (gesture.state == .began)
        {
            if(velocity.x > 350 && isSlideOpen == false)
            {
                openMenu()
            }
            else if(velocity.x < -350 && isSlideOpen == true)
            {
                closeMenu()
            }
        }
        else if (gesture.state == .changed)
        {
            let movingX:Float = Float(translation.x)
            let sideMenuOrigin = slideMenu.view.center.x
            print("movingX : ",movingX)
            print("translation : ",translation.x)
            print("menuViewPosition : ", sideMenuOrigin)
            
            if (Float(self.slideMenu.view.frame.origin.x) + movingX) <= 0
            {
                self.slideMenu.view.frame = CGRect(x: (CGFloat(movingX) + slideMenu.view.frame.origin.x),y:0,width:0.8 * UIScreen.main.bounds.size.width,height:UIScreen.main.bounds.size.height)
                
                gesture.setTranslation(CGPoint(x: CGFloat(0), y: CGFloat(0)), in: sliderController.view)
                
                let changingAlpha: Float  = Float(0.5 / Float(UIScreen.main.bounds.size.width) * movingX + 0.5 / 2)
                self.backgroundView.backgroundColor = UIColor(red: CGFloat(0.0), green: CGFloat(0.0), blue: CGFloat(0.0), alpha: CGFloat(changingAlpha))
            }
            
            
            
        }
        else if (gesture.state == .ended)
        {
            print(slideMenu.view.center.x)
            
            if self.slideMenu.view.center.x > 0 {
                self.openMenu()
            }
            else if self.slideMenu.view.center.x < 0 {
                self.closeMenu()
            }
            
        }
        
        
    }
    
    
    
  }
}
