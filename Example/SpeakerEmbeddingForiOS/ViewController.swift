//
//  ViewController.swift
//  SpeakerEmbeddingForiOS
//
//  Created by fuhao on 04/25/2023.
//  Copyright (c) 2023 fuhao. All rights reserved.
//

import UIKit
import SpeakerEmbeddingForiOS
import AVFAudio

class ViewController: UIViewController {
    var extracter: SpeakerEmbedding?
    override func viewDidLoad() {
        super.viewDidLoad()
        extracter = SpeakerEmbedding()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(testFunc)))
        
    }
    
    @objc
    func testFunc() {
        guard let buffer = loadAudioFile(url: Bundle.main.url(forResource: "en_example", withExtension: "wav")) else {
            return
        }
        
        guard let featureArray:[Float] = extracter?.extractFeature(buffer: buffer, range: 0..<2000) else {
            return
        }
        let floatStrArr = featureArray.map { String(format: "%.2f", $0) }
        let floatStr = floatStrArr.joined(separator: ", ")
        print(floatStr)
        
        
    }
    
    func loadAudioFile(url: URL?) -> AVAudioPCMBuffer? {
        guard let url = url,
              let file = try? AVAudioFile(forReading: url) else {
            return nil
        }

        let format = file.processingFormat
        let format2 = file.fileFormat
        print(format.description)
        print(format2.description)
        
        
        let frameCount = UInt32(file.length)
        guard let buffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: frameCount) else {
            return nil
        }

        do {
            try file.read(into: buffer)
            return buffer
        } catch {
            return nil
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

