//
//  OperatorCallViewController.swift
//  BOTesercenti
//
//  Created by Mirko Pennone on 21/05/18.
//  Copyright © 2018 spark-ios-sdk. All rights reserved.
//

import UIKit
import SparkSDK
import CallKit

class OperatorCallViewController: UIViewController {

    var currentCall: Call?
    
    var time: Int = 0
    
    var callTimer: Timer?
    
    var blurEffectView: UIVisualEffectView?
    
    @IBOutlet weak var callLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var disconnectButton: UIButton!
    
    @IBOutlet weak var contactImage: UIImageView!
    
    @IBOutlet weak var muteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.timeLabel.text = ""
        
        self.muteButton.isHidden = true
        
        sparkSDK?.phone.dial("mirko@pennone.org", option: MediaOption.audioOnly(), completionHandler: { (result) in
            
            switch result {
                
                case .success(let call):
                    self.currentCall = call
                    call.sendingAudio = true
                    self.callLabel.text = "Connecting..."
                    self.callStateChangeCallBacks(call: call)
                
                case .failure(let _):
                    print("Failed to call.")
                
            }
            
        })

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let _ = currentCall {
            endCall(currentCall!)
        }
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @objc func updateTimer(){
        
        time = time + 1
        
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        var formattedTime = String(format: "%02i:%02i", minutes, seconds)
        print(formattedTime)
        timeLabel.text = formattedTime
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func callStateChangeCallBacks(call: Call) {
        
        /* Callback when remote participant(s) answered and this *call* is connected. */
        call.onConnected = { [weak self] in
            print("Call ======= > Connected")
            
            self?.activityIndicator.isHidden = true
            self?.blurEffectView?.isHidden = true
            self?.callLabel.text = "Operator"
            self?.timeLabel.text = "00:00"
            self?.muteButton.isHidden = false
            self?.callTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self?.updateTimer), userInfo: nil, repeats: true)
            self?.disconnectButton.isHidden = false
            
        }
        
        /* Callback when this *call* is disconnected (hangup, cancelled, get declined or other self device pickup the call). */
        call.onDisconnected = { [weak self] reason in
            print("Call ======= > DisConnected")
            var reasonStr = "Disconnecting"
            switch reason {
            case .remoteLeft:
                reasonStr = "Remote HangUp"
                break;
            case .remoteDecline:
                reasonStr = "Declined Call"
                break
            case .localDecline:
                reasonStr = "Declining"
                break
            case .localLeft:
                reasonStr = "Hanging Up"
                return
            case .localCancel:
                reasonStr = "Canceling"
                break
            default:
                break
            }
            
            print(reasonStr)
            
            self?.endCall(call, reasonStr)
        }
        
        /* Callback when the media types of this *call* have changed. */
        call.onMediaChanged = {[weak self] mediaChangeType in
            switch mediaChangeType {
                /* Local/Remote video rendering view size has changed */
            case .localVideoViewSize,.remoteVideoViewSize:
                break
                /* This might be triggered when the remote party muted or unmuted the audio. */
            case .remoteSendingAudio:
                break
                /* This might be triggered when the remote party muted or unmuted the video. */
            case .remoteSendingVideo:
                break
                /* This might be triggered when the local party muted or unmuted the video. */
            case .sendingAudio:
                break
                /* This might be triggered when the local party muted or unmuted the aideo. */
            case .sendingVideo:
                break
                /* Camera FacingMode on local device has switched. */
            case .cameraSwitched:
                break
                /* Whether loud speaker on local device is on or not has switched. */
            case .spearkerSwitched:
                break
            case .receivingAudio:
                break
            case .receivingScreenShare:
                break
            case .remoteSendingScreenShare(let isSending):
                break
            default:
                break
            }
        }
        
        /* Callback when remote participant(s) join/left/decline connected. */
        call.onCallMembershipChanged = { [weak self] memberShipChangeType  in
            if self != nil {
                switch memberShipChangeType {
                    /* This might be triggered when membership joined the call */
                case .joined(let memberShip):
                    print("memberShip=======>\(memberShip.email!) joined")
                    break
                    /* This might be triggered when membership left the call */
                case .left(let memberShip):
                    print("memberShip=======>\(memberShip.email!) left")
                    break
                    /* This might be triggered when membership declined the call */
                case .declined(let memberShip):
                    print("memberShip========> \(memberShip.email!) declined")
                    break
                default:
                    break
                }
            }
        }
    }
    
    func endCall(_ call: Call, _ endReason: String? = nil){
        let isCurrentCall = (call.uuid.uuidString == self.currentCall?.uuid.uuidString)
        
        self.muteButton.isHidden = true
        callLabel.text = "Disconnecting..."
        
        if call.status == .connected {
            if(isCurrentCall){
                print(endReason)
            }
            call.hangup(completionHandler: { (_ error) in
                if(isCurrentCall){
                    self.currentCall = nil
//                    self.dismiss(animated: true, completion: {})
                    print("Call hangup.")
                    self.callTimer?.invalidate()
                    self.callLabel.text = "Disconnected"
                    Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.popOverDisconnected), userInfo: nil, repeats: false)
                }
            })
        }else{
            call.reject(completionHandler: { (_ error) in
                if(isCurrentCall){
                    self.currentCall = nil
//                    self.dismiss(animated: true, completion: {})
                    print("Call rejected.")
                    self.callTimer?.invalidate()
                    self.callLabel.text = "Disconnected..."
                    Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.popOverDisconnected), userInfo: nil, repeats: false)
                }
            })
        }
    }
    
    @objc func popOverDisconnected(){
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func onDisconnectButton(_ sender: Any) {
        if let _ = currentCall {
            endCall(currentCall!)
        } else {
            Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.popOverDisconnected), userInfo: nil, repeats: false)
        }
        
    }
    
    @IBAction func onMuteButton(_ sender: Any) {
        if let _ = currentCall {
            if (currentCall?.sendingAudio)!{
                currentCall?.sendingAudio = false
            } else {
                currentCall?.sendingAudio = true
            }
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
