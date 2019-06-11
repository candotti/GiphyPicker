//
//  ViewController.swift
//  GiphyPickerViewController
//
//  Created by Daniele Candotti on 06/06/2019.
//  Copyright (c) 2019 Daniele Candotti. All rights reserved.
//

import UIKit
import GiphyPicker

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openPicker() {
        let picker = GiphyPicker.getViewController()
        picker.onTapOnMedia = { giphyInfo in
            print(giphyInfo?.url ?? "Error")
        }
        present(picker, animated: true, completion: nil)
    }
}

