//
//  ViewController.swift
//  MixAudioAndVideoSwift
//
//  Created by Tuuu on 1/5/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {

    @IBAction func action(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let videoUrl = URL(fileURLWithPath: "/Users/tuuu/Desktop/SourceTest/Suni Hạ Linh - Em Đã Biết - Official MV.mp4")
        let audioUrl = URL(fileURLWithPath:"/Users/tuuu/Desktop/SourceTest/Thang-Tu-La-Loi-Noi-Doi-Cua-Em-Ha-Anh-Tuan.mp3")
//        mixAudio(audioURL: audioUrl, videoURL: videoUrl)
        mergeVideoAndMusicWithVolume(videoURL: videoUrl, audioURL: audioUrl, startAudioTime: 0, volumeVideo: 0.1, volumeAudio: 1) { (urlOutput) in
            print(urlOutput?.description)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func mergeVideoAndMusicWithVolume(videoURL: URL, audioURL: URL, startAudioTime: Float64, volumeVideo: Float, volumeAudio: Float, complete: @escaping (NSURL?) -> Void) -> Void {
        
        //The goal is merging a video and a music from iPod library, and set it a volume
        
        //Get the path of App Document Directory
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docsDir = dirPaths[0] as String
        
        //Create Asset from record and music
        let assetVideo: AVURLAsset = AVURLAsset(url: videoURL)
        let assetMusic: AVURLAsset = AVURLAsset(url: audioURL)
        
        let composition: AVMutableComposition = AVMutableComposition()
        let compositionVideo: AVMutableCompositionTrack = composition.addMutableTrack(withMediaType: AVMediaTypeVideo, preferredTrackID: CMPersistentTrackID())
        
        let compositionAudioVideo: AVMutableCompositionTrack = composition.addMutableTrack(withMediaType: AVMediaTypeAudio, preferredTrackID: CMPersistentTrackID())
        
        let compositionAudioMusic: AVMutableCompositionTrack = composition.addMutableTrack(withMediaType: AVMediaTypeAudio, preferredTrackID: CMPersistentTrackID())
        
        
        //Add video to the final record
        do {
            try compositionVideo.insertTimeRange(CMTimeRangeMake(kCMTimeZero, assetVideo.duration), of: assetVideo.tracks(withMediaType: AVMediaTypeVideo)[0], at: kCMTimeZero)
        } catch _ {
        }
        
        //Extract audio from the video and the music
        let audioMix: AVMutableAudioMix = AVMutableAudioMix()
        var audioMixParam: [AVMutableAudioMixInputParameters] = []
        
        let assetVideoTrack: AVAssetTrack = assetVideo.tracks(withMediaType: AVMediaTypeAudio)[0]
        let assetMusicTrack: AVAssetTrack = assetMusic.tracks(withMediaType: AVMediaTypeAudio)[0]
        
        let videoParam: AVMutableAudioMixInputParameters = AVMutableAudioMixInputParameters(track: assetVideoTrack)
        videoParam.trackID = compositionAudioVideo.trackID
        
        let musicParam: AVMutableAudioMixInputParameters = AVMutableAudioMixInputParameters(track: assetMusicTrack)
        musicParam.trackID = compositionAudioMusic.trackID
        
        //Set final volume of the audio record and the music
        videoParam.setVolume(volumeVideo, at: kCMTimeZero)
        musicParam.setVolume(volumeAudio, at: kCMTimeZero)
        
        //Add setting
        audioMixParam.append(musicParam)
        audioMixParam.append(videoParam)
        
        //Add audio on final record
        //First: the audio of the record and Second: the music
        do {
            try compositionAudioVideo.insertTimeRange(CMTimeRangeMake(kCMTimeZero, assetVideo.duration), of: assetVideoTrack, at: kCMTimeZero)
        } catch _ {
            assertionFailure()
        }
        
        do {
            try compositionAudioMusic.insertTimeRange(CMTimeRangeMake(CMTimeMake(Int64(startAudioTime * 10000), 10000), assetVideo.duration), of: assetMusicTrack, at: kCMTimeZero)
        } catch _ {
            assertionFailure()
        }
        
        //Add parameter
        audioMix.inputParameters = audioMixParam
        
        //Remove the previous temp video if exist
        let filemgr = FileManager.default
        do {
            if filemgr.fileExists(atPath: "\(docsDir)/movie-merge-music.mov") {
                try filemgr.removeItem(atPath: "\(docsDir)/movie-merge-music.mov")
            } else {
            }
        } catch _ {
        }
        
        //Exporte the final record’
        let completeMovie = "\(docsDir)/movie-merge-music.mov"
        let completeMovieUrl = NSURL(fileURLWithPath: completeMovie)
        let exporter: AVAssetExportSession = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetHighestQuality)!
        exporter.outputURL = completeMovieUrl as URL
        exporter.outputFileType = AVFileTypeMPEG4
        exporter.audioMix = audioMix
        
        exporter.exportAsynchronously(completionHandler: {
            switch exporter.status{
            case  AVAssetExportSessionStatus.failed:
                print("failed \(exporter.error)")
                complete(nil)
            case AVAssetExportSessionStatus.cancelled:
                print("cancelled \(exporter.error)")
                complete(nil)
            default:
                print("complete")
                complete(completeMovieUrl)
            }
        })
    }
    func mixAudio(audioURL: URL, videoURL: URL) {
        let audioAsset = AVURLAsset(url: audioURL)
        let videoAsset = AVURLAsset(url: videoURL)
        
        let mixComposition = AVMutableComposition()
        
        
        let compositionCommentaryTrack:AVMutableCompositionTrack = mixComposition.addMutableTrack(withMediaType: AVMediaTypeAudio, preferredTrackID: kCMPersistentTrackID_Invalid)
        
        
        let compositionCommentaryTrack1 = mixComposition.addMutableTrack(withMediaType: AVMediaTypeAudio, preferredTrackID: kCMPersistentTrackID_Invalid)
        
        // add audio
        
        let timeRange = CMTimeRangeMake(kCMTimeZero, CMTime(value: 20, timescale: CMTimeScale(1.0)))
        
        let track1:AVAssetTrack = videoAsset.tracks(withMediaType: AVMediaTypeAudio)[0]
        
        
        
        let track = audioAsset.tracks(withMediaType: AVMediaTypeAudio)[0]
        
        do {
            try compositionCommentaryTrack.insertTimeRange(timeRange, of: track, at: kCMTimeZero)
            try compositionCommentaryTrack1.insertTimeRange(timeRange, of: track1, at: kCMTimeZero)
            
        }
        catch {
            print("Error insertTimeRange for audio track \(error)")
        }

        // add video
        let compositionVideoTrack = mixComposition.addMutableTrack(withMediaType: AVMediaTypeVideo, preferredTrackID: kCMPersistentTrackID_Invalid)
        
        let timeRangeVideo = CMTimeRangeMake(kCMTimeZero, videoAsset.duration)
        let trackVideo = videoAsset.tracks(withMediaType: AVMediaTypeVideo)[0]
        do {
            try compositionVideoTrack.insertTimeRange(timeRangeVideo, of: trackVideo, at: kCMTimeZero)
        }
        catch {
            print("Error insertTimeRange for video track \(error)")
        }
        
        // export
        let assetExportSession = AVAssetExportSession(asset: mixComposition, presetName: AVAssetExportPresetPassthrough)
        let videoName = "export.mov"
        let exportPath = "\(NSTemporaryDirectory())/\(videoName)"
        let exportURL = NSURL(fileURLWithPath: exportPath)
        
        if FileManager.default.fileExists(atPath: exportPath) {
            do {
                try FileManager.default.removeItem(atPath: exportPath)
            }
            catch {
                print("Error deleting export.mov: \(error)")
            }
        }
        let audioVolume: AVMutableAudioMixInputParameters = AVMutableAudioMixInputParameters()
        audioVolume.setVolume(0, at: kCMTimeZero)
        audioVolume.trackID = compositionCommentaryTrack1.trackID
        let audioMix = AVMutableAudioMix()
        audioMix.inputParameters = [audioVolume]
        
        assetExportSession?.outputFileType = "com.apple.quicktime-movie"
        assetExportSession?.audioMix = audioMix
        assetExportSession?.outputURL = exportURL as URL
        assetExportSession?.shouldOptimizeForNetworkUse = true
        assetExportSession?.exportAsynchronously(completionHandler: { 
            print("Mixed audio and video!")
            
        })
        
    }

}

