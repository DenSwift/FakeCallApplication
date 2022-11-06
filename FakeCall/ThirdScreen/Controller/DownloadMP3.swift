//
//  DownloadMP3.swift
//  FakeCall
//
//  Created by Денис  on 01.11.2022.
//

import Foundation
import AVFoundation

class DownloadMP3 {
    public func pathToSound(sender: Bool, player: inout AVAudioPlayer) {
        if sender == true {
            do {
                player = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Iphone Vibration - Sound.mp3", ofType: nil)!))
                player.numberOfLoops = -1
                player.play()
            } catch {
                print(error.localizedDescription)
            }
        } else {
            do {
                player = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "iphone-11-pro.mp3", ofType: nil)!))
                player.numberOfLoops = -1
                player.play()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
