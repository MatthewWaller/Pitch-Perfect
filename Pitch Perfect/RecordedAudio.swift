//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Matthew Waller on 1/7/16.
//  Copyright © 2016 Matthew Waller. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePathURL: NSURL, title: String) {
        
        //Taken with guidance from http://code.tutsplus.com/tutorials/swift-from-scratch-initialization-and-initializer-delegation--cms-23538
        
        self.filePathUrl = filePathURL
        self.title = title
    }
    
}