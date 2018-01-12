//
//  ConcentrationThemeChooseViewController.swift
//  ConcentrationGame
//
//  Created by Viral Chauhan on 12/01/18.
//  Copyright © 2018 Viral Chauhan. All rights reserved.
//

import UIKit

class ConcentrationThemeChooseViewController: UIViewController, UISplitViewControllerDelegate {

    //MARK: Properties
    var themes = [
        "Sports":"⚽️🏀🏈⚾️🎾🏐🏉🎱🥅🏹🤼‍♂️🤺⛹🏽‍♀️",
        "Faces" : "🤓😎🤡🤠😭😩😞🤣😱😬😮",
        "Animals" : "🙉🐻🦄🐈🐿🐪🐃🐄🦏🐘🐍🐢",
    ]
    
    private var lastVisitedConcentrationViewController: ConcentrationViewController?
    
    // MARK: ViewController methods
    override func awakeFromNib() {
        super.awakeFromNib()
        splitViewController?.delegate  = self
    }
    
    //MARK: SpliteViewController Delegate methods
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if let cvc = secondaryViewController as? ConcentrationViewController {
            if cvc.theme == nil {
                return true
            }
        }
        return false
    }
    
    //MARK: Action methods
    @IBAction func themeChoose(_ sender: Any) {
        if let cvc = splitViewDetailViewController {
            if let buttonTitle = (sender as? UIButton)?.currentTitle, let theme = themes[buttonTitle] {
                cvc.theme = theme
            }
        } else if let cvc = lastVisitedConcentrationViewController {
            if let buttonTitle = (sender as? UIButton)?.currentTitle, let theme = themes[buttonTitle] {
                cvc.theme = theme
            }
            navigationController?.pushViewController(cvc, animated: true)
        } else {
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
        
    }
    
    
    //MARK - Methods
    var splitViewDetailViewController: ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let buttonTitle = (sender as? UIButton)?.currentTitle, let theme = themes[buttonTitle] {
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = theme
                    lastVisitedConcentrationViewController = cvc
                }
            }
        }
    }
    

}
