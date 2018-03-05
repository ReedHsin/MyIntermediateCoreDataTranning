//
//  CoreDataManager.swift
//  MyIntermediateCoreDataTranning
//
//  Created by 辛忠翰 on 05/03/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import CoreData
struct CoreDataManager {
    //It will leave forever as long as ur app is still alive, it's properites will too
    static let shared = CoreDataManager()//這樣的寫法可以創造singleTern
    //如此一來CoreDataManager的所有properties便可永遠活在app run time時期
    let persistantContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MyIntermediateCoreDatatranningModel")
        container.loadPersistentStores { (storeDescription, err) in
            if let err = err{
                fatalError("Loading of store failure: \(err)")
            }
            print("Successfully load store!!")
        }
        return container
    }()
}
