//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Matthew Waller on 1/7/16.
//  Copyright © 2016 Matthew Waller. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController, AVAudioPlayerDelegate {

    
    var audioPlayer: AVAudioPlayer!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    var receivedAudio:RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)
        
        audioPlayer = try! AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        audioPlayer.enableRate = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func playSlowSound(sender: UIButton) {
        
        playSoundWithRate(0.5)
        
    }
    
    @IBAction func playFastSound(sender: UIButton) {
        
       playSoundWithRate(1.5)
        
    }
    
    
    @IBAction func playChipmunkSound(sender: UIButton) {
        
        playAudioWithVariablePitch(1000)
        
    }
    
    
    @IBAction func playVaderSound(sender: UIButton) {
        
         playAudioWithVariablePitch(-1000)
        
    }
    
    
    func playAudioWithVariablePitch(pitch: Float) {
        
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        
        try! audioEngine.start()
        
        audioPlayerNode.play()
        
    }
    
    @IBAction func playSoundWithEcho(sender: UIButton) {
        
        //Made with help from http://stackoverflow.com/questions/29619087/what-does-detachnode-do-in-avaudioengine-class-in-swift
        
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        let echoNode = AVAudioUnitDelay()
        echoNode.delayTime = NSTimeInterval(0.3)
        
        let audioPlayerNode = AVAudioPlayerNode()
        
        audioEngine.attachNode(audioPlayerNode)
        
        audioEngine.attachNode(echoNode)
        
        audioEngine.connect(audioPlayerNode, to: echoNode, format: audioFile.processingFormat)
        
        audioEngine.connect(echoNode, to: audioEngine.outputNode, format: audioFile.processingFormat)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler:nil)
        
        try! audioEngine.start()
        
        audioPlayerNode.play()
        
    }
    
    
    func playSoundWithRate(rate: Float) {
        
        audioPlayer.stop()
        //Task 2
        audioEngine.stop()
        audioEngine.reset()
        
        audioPlayer.rate = rate
        
        audioPlayer.currentTime = 0.0
        
        audioPlayer.play()
        
    }
    
    
    @IBAction func stopSound(sender: UIButton) {
        
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
    }
    

}
