//
//  ViewController.swift
//  CoreDataTest
//
//  Created by Appnap WS01 on 14/9/20.
//  Copyright © 2020 Appnap WS01. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var submit: UIButton!
    
    var storedData = [Employee]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submit.layer.cornerRadius = submit.frame.height / 5
        loadData()
    }

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    @IBAction func submitPressed(_ sender: UIButton) {
        if let name = textField1.text, let age = textField2.text {
            let newItem = Employee(context: context)
            newItem.name = name
            newItem.age = Int64(age)!
            do {
                try context.save()
            }catch {
                print(error)
            }
        }
        textField1.text = ""
        textField2.text = ""
        textField1.placeholder = "Please enter your name"
        textField2.placeholder = "Please enter your age"
        loadData()
        printData()
    }
    
    func loadData() {
        let request: NSFetchRequest<Employee> = Employee.fetchRequest()
        do {
            storedData = try context.fetch(request)
        }catch {
            print(error)
        }
    }
    
    func printData() {
        for data in storedData {
            print("Name: \(data.name ?? "No name") Age: \(data.age)")
        }
    }
}

