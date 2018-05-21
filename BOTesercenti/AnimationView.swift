//
// AnimationView.swift
// Generated by Core Animator version 1.5.2 on 21/05/2018.
//
// DO NOT MODIFY THIS FILE. IT IS AUTO-GENERATED AND WILL BE OVERWRITTEN
//

import UIKit

private class _AnimationPassthroughView: UIView {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        for subview in subviews as [UIView] {
            if subview.point(inside: convert(point, to: subview), with: event) { return true }
        }
        return false
    }
}

@IBDesignable
class AnimationView : UIView, CAAnimationDelegate {


    var animationCompletions = Dictionary<CAAnimation, (Bool) -> Void>()
    var viewsByName: [String : UIView]!

    // - MARK: Life Cycle

    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 1500, height: 1500))
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupHierarchy()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupHierarchy()
    }

    // - MARK: Scaling

    override func layoutSubviews() {
        super.layoutSubviews()

        if let scalingView = self.viewsByName["__scaling__"] {
            var xScale = self.bounds.size.width / scalingView.bounds.size.width
            var yScale = self.bounds.size.height / scalingView.bounds.size.height
            switch contentMode {
            case .scaleToFill:
                break
            case .scaleAspectFill:
                let scale = max(xScale, yScale)
                xScale = scale
                yScale = scale
            default:
                let scale = min(xScale, yScale)
                xScale = scale
                yScale = scale
            }
            scalingView.transform = CGAffineTransform(scaleX: xScale, y: yScale)
            scalingView.center = CGPoint(x:self.bounds.midX, y:self.bounds.midY)
        }
    }

    // - MARK: Setup

    func setupHierarchy() {
        var viewsByName: [String : UIView] = [:]
        let bundle = Bundle(for:type(of: self))
        let __scaling__ = UIView()
        __scaling__.bounds = CGRect(x:0, y:0, width:1500, height:1500)
        __scaling__.center = CGPoint(x:750.0, y:750.0)
        __scaling__.clipsToBounds = true
        self.addSubview(__scaling__)
        viewsByName["__scaling__"] = __scaling__

        let body2__root = _AnimationPassthroughView()
        let body2__xScale = _AnimationPassthroughView()
        let body2__yScale = _AnimationPassthroughView()
        let body2 = UIImageView()
        let imgBody2 = UIImage(named:"body2.png", in: bundle, compatibleWith: nil)
        if imgBody2 == nil {
            print("** Warning: Could not create image from 'body2.png'")
        }
        body2.image = imgBody2
        body2.contentMode = .center
        body2.bounds = CGRect(x:0, y:0, width:1701.0, height:1212.0)
        body2__root.layer.position = CGPoint(x:750.000, y:962.969)
        body2__xScale.transform = CGAffineTransform(scaleX: 0.35, y: 1.00)
        body2__yScale.transform = CGAffineTransform(scaleX: 1.00, y: 0.35)
        body2__root.transform = CGAffineTransform(rotationAngle: 0.035)
        body2__root.addSubview(body2__xScale)
        body2__xScale.addSubview(body2__yScale)
        body2__yScale.addSubview(body2)
        __scaling__.addSubview(body2__root)
        viewsByName["body2__root"] = body2__root
        viewsByName["body2__xScale"] = body2__xScale
        viewsByName["body2__yScale"] = body2__yScale
        viewsByName["body2"] = body2

        let face__root = _AnimationPassthroughView()
        let face__xScale = _AnimationPassthroughView()
        let face__yScale = _AnimationPassthroughView()
        let face = UIImageView()
        let imgFace = UIImage(named:"face.png", in: bundle, compatibleWith: nil)
        if imgFace == nil {
            print("** Warning: Could not create image from 'face.png'")
        }
        face.image = imgFace
        face.contentMode = .center
        face.bounds = CGRect(x:0, y:0, width:990.0, height:585.0)
        face__root.layer.position = CGPoint(x:803.832, y:473.075)
        face__xScale.transform = CGAffineTransform(scaleX: 0.80, y: 1.00)
        face__yScale.transform = CGAffineTransform(scaleX: 1.00, y: 0.80)
        face__root.transform = CGAffineTransform(rotationAngle: 0.017)
        face__root.addSubview(face__xScale)
        face__xScale.addSubview(face__yScale)
        face__yScale.addSubview(face)
        __scaling__.addSubview(face__root)
        viewsByName["face__root"] = face__root
        viewsByName["face__xScale"] = face__xScale
        viewsByName["face__yScale"] = face__yScale
        viewsByName["face"] = face

        let eyes__root = _AnimationPassthroughView()
        let eyes__xScale = _AnimationPassthroughView()
        let eyes__yScale = _AnimationPassthroughView()
        let eyes = UIImageView()
        let imgEyes = UIImage(named:"eyes.png", in: bundle, compatibleWith: nil)
        if imgEyes == nil {
            print("** Warning: Could not create image from 'eyes.png'")
        }
        eyes.image = imgEyes
        eyes.contentMode = .center
        eyes.bounds = CGRect(x:0, y:0, width:417.0, height:99.0)
        eyes__root.layer.position = CGPoint(x:796.536, y:416.500)
        eyes__xScale.transform = CGAffineTransform(scaleX: 0.70, y: 1.00)
        eyes__yScale.transform = CGAffineTransform(scaleX: 1.00, y: 0.70)
        eyes__root.transform = CGAffineTransform(rotationAngle: 0.000)
        eyes__root.addSubview(eyes__xScale)
        eyes__xScale.addSubview(eyes__yScale)
        eyes__yScale.addSubview(eyes)
        __scaling__.addSubview(eyes__root)
        viewsByName["eyes__root"] = eyes__root
        viewsByName["eyes__xScale"] = eyes__xScale
        viewsByName["eyes__yScale"] = eyes__yScale
        viewsByName["eyes"] = eyes

        let closEyes__root = _AnimationPassthroughView()
        let closEyes__xScale = _AnimationPassthroughView()
        let closEyes__yScale = _AnimationPassthroughView()
        let closEyes = UIImageView()
        let imgClosEyes = UIImage(named:"closEyes.png", in: bundle, compatibleWith: nil)
        if imgClosEyes == nil {
            print("** Warning: Could not create image from 'closEyes.png'")
        }
        closEyes.image = imgClosEyes
        closEyes.contentMode = .center
        closEyes.bounds = CGRect(x:0, y:0, width:384.0, height:57.0)
        closEyes__root.layer.position = CGPoint(x:796.068, y:404.716)
        closEyes__root.alpha = 0.00
        closEyes__xScale.transform = CGAffineTransform(scaleX: 0.75, y: 1.00)
        closEyes__yScale.transform = CGAffineTransform(scaleX: 1.00, y: 0.70)
        closEyes__root.transform = CGAffineTransform(rotationAngle: 0.000)
        closEyes__root.addSubview(closEyes__xScale)
        closEyes__xScale.addSubview(closEyes__yScale)
        closEyes__yScale.addSubview(closEyes)
        __scaling__.addSubview(closEyes__root)
        viewsByName["closEyes__root"] = closEyes__root
        viewsByName["closEyes__xScale"] = closEyes__xScale
        viewsByName["closEyes__yScale"] = closEyes__yScale
        viewsByName["closEyes"] = closEyes

        let amrDue__root = _AnimationPassthroughView()
        let amrDue__xScale = _AnimationPassthroughView()
        let amrDue__yScale = _AnimationPassthroughView()
        let amrDue = UIImageView()
        let imgAmrDue = UIImage(named:"amrDue.png", in: bundle, compatibleWith: nil)
        if imgAmrDue == nil {
            print("** Warning: Could not create image from 'amrDue.png'")
        }
        amrDue.image = imgAmrDue
        amrDue.contentMode = .center
        amrDue.layer.anchorPoint = CGPoint(x:0.122, y:0.213)
        amrDue.bounds = CGRect(x:0, y:0, width:294.0, height:288.0)
        amrDue__root.layer.position = CGPoint(x:920.348, y:848.141)
        amrDue__xScale.transform = CGAffineTransform(scaleX: 0.92, y: 1.00)
        amrDue__yScale.transform = CGAffineTransform(scaleX: 1.00, y: 0.92)
        amrDue__root.transform = CGAffineTransform(rotationAngle: 6.233)
        amrDue__root.addSubview(amrDue__xScale)
        amrDue__xScale.addSubview(amrDue__yScale)
        amrDue__yScale.addSubview(amrDue)
        __scaling__.addSubview(amrDue__root)
        viewsByName["amrDue__root"] = amrDue__root
        viewsByName["amrDue__xScale"] = amrDue__xScale
        viewsByName["amrDue__yScale"] = amrDue__yScale
        viewsByName["amrDue"] = amrDue

        self.viewsByName = viewsByName
    }

    // - MARK: 2

    func add_2Animation() {
        add_2Animation(beginTime: 0, fillMode: kCAFillModeBoth, removedOnCompletion: false, completion: nil)
    }

    func add_2Animation(completion: ((Bool) -> Void)?) {
        add_2Animation(beginTime: 0, fillMode: kCAFillModeBoth, removedOnCompletion: false, completion: completion)
    }

    func add_2Animation(removedOnCompletion: Bool) {
        add_2Animation(beginTime: 0, fillMode: removedOnCompletion ? kCAFillModeRemoved : kCAFillModeBoth, removedOnCompletion: removedOnCompletion, completion: nil)
    }

    func add_2Animation(removedOnCompletion: Bool, completion: ((Bool) -> Void)?) {
        add_2Animation(beginTime: 0, fillMode: removedOnCompletion ? kCAFillModeRemoved : kCAFillModeBoth, removedOnCompletion: removedOnCompletion, completion: completion)
    }

    //animation
    func add_2Animation(beginTime: CFTimeInterval, fillMode: String, removedOnCompletion: Bool, completion: ((Bool) -> Void)?) {
        let linearTiming = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        let easeOutTiming = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        let instantTiming = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
        let easeInTiming = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        if let complete = completion {
            let representativeAnimation = CABasicAnimation(keyPath: "not.a.real.key")
            representativeAnimation.duration = 5.000
            representativeAnimation.delegate = self
            self.layer.add(representativeAnimation, forKey: "_2")
            self.animationCompletions[layer.animation(forKey: "_2")!] = complete
        }

        let closEyesOpacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        closEyesOpacityAnimation.duration = 5.000
        closEyesOpacityAnimation.values = [0.000, 0.000, 1.000, 1.000, 0.000, 0.000, 0.000] as [Float]
        closEyesOpacityAnimation.keyTimes = [0.000, 0.200, 0.200, 0.250, 0.250, 0.500, 1.000] as [NSNumber]
        closEyesOpacityAnimation.timingFunctions = [instantTiming, instantTiming, instantTiming, instantTiming, linearTiming, linearTiming]
        closEyesOpacityAnimation.beginTime = beginTime
        closEyesOpacityAnimation.fillMode = fillMode
        closEyesOpacityAnimation.repeatCount = 50
        closEyesOpacityAnimation.isRemovedOnCompletion = removedOnCompletion
        self.viewsByName["closEyes__root"]?.layer.add(closEyesOpacityAnimation, forKey:"2_Opacity")

        let closEyesTranslationYAnimation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        closEyesTranslationYAnimation.duration = 5.000
        closEyesTranslationYAnimation.values = [0.000, -43.000, 0.000] as [Float]
        closEyesTranslationYAnimation.keyTimes = [0.000, 0.500, 1.000] as [NSNumber]
        closEyesTranslationYAnimation.timingFunctions = [easeOutTiming, easeInTiming]
        closEyesTranslationYAnimation.beginTime = beginTime
        closEyesTranslationYAnimation.fillMode = fillMode
        closEyesTranslationYAnimation.repeatCount = 50
        closEyesTranslationYAnimation.isRemovedOnCompletion = removedOnCompletion
        self.viewsByName["closEyes__root"]?.layer.add(closEyesTranslationYAnimation, forKey:"2_TranslationY")

        let amrDueRotationAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        amrDueRotationAnimation.duration = 5.000
        amrDueRotationAnimation.values = [6.233, 6.233, 5.220, 5.465, 5.220, 6.233, 6.233] as [Float]
        amrDueRotationAnimation.keyTimes = [0.000, 0.300, 0.400, 0.450, 0.500, 0.780, 1.000] as [NSNumber]
        amrDueRotationAnimation.timingFunctions = [linearTiming, linearTiming, linearTiming, linearTiming, easeOutTiming, linearTiming]
        amrDueRotationAnimation.beginTime = beginTime
        amrDueRotationAnimation.fillMode = fillMode
        amrDueRotationAnimation.repeatCount = 1
        amrDueRotationAnimation.isRemovedOnCompletion = removedOnCompletion
        self.viewsByName["amrDue__root"]?.layer.add(amrDueRotationAnimation, forKey:"2_Rotation")

        let amrDueTranslationYAnimation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        amrDueTranslationYAnimation.duration = 5.000
        amrDueTranslationYAnimation.values = [0.000, -43.000, 0.000] as [Float]
        amrDueTranslationYAnimation.keyTimes = [0.000, 0.500, 1.000] as [NSNumber]
        amrDueTranslationYAnimation.timingFunctions = [easeOutTiming, easeInTiming]
        amrDueTranslationYAnimation.beginTime = beginTime
        amrDueTranslationYAnimation.fillMode = fillMode
        amrDueTranslationYAnimation.repeatCount = 50
        amrDueTranslationYAnimation.isRemovedOnCompletion = removedOnCompletion
        self.viewsByName["amrDue__root"]?.layer.add(amrDueTranslationYAnimation, forKey:"2_TranslationY")

        let body2TranslationYAnimation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        body2TranslationYAnimation.duration = 5.000
        body2TranslationYAnimation.values = [0.000, -43.000, 0.000] as [Float]
        body2TranslationYAnimation.keyTimes = [0.000, 0.500, 1.000] as [NSNumber]
        body2TranslationYAnimation.timingFunctions = [easeOutTiming, easeInTiming]
        body2TranslationYAnimation.beginTime = beginTime
        body2TranslationYAnimation.fillMode = fillMode
        body2TranslationYAnimation.repeatCount = 50
        body2TranslationYAnimation.isRemovedOnCompletion = removedOnCompletion
        self.viewsByName["body2__root"]?.layer.add(body2TranslationYAnimation, forKey:"2_TranslationY")

        let eyesRotationAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        eyesRotationAnimation.duration = 5.000
        eyesRotationAnimation.values = [0.000, 0.000, -0.143, -0.192, 0.000, 0.000] as [Float]
        eyesRotationAnimation.keyTimes = [0.000, 0.400, 0.500, 0.580, 0.690, 1.000] as [NSNumber]
        eyesRotationAnimation.timingFunctions = [linearTiming, linearTiming, easeOutTiming, easeInTiming, linearTiming]
        eyesRotationAnimation.beginTime = beginTime
        eyesRotationAnimation.fillMode = fillMode
        eyesRotationAnimation.repeatCount = 1
        eyesRotationAnimation.isRemovedOnCompletion = removedOnCompletion
        self.viewsByName["eyes__root"]?.layer.add(eyesRotationAnimation, forKey:"2_Rotation")

        let eyesOpacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        eyesOpacityAnimation.duration = 5.000
        eyesOpacityAnimation.values = [1.000, 1.000, 0.000, 0.000, 1.000, 1.000, 1.000] as [Float]
        eyesOpacityAnimation.keyTimes = [0.000, 0.200, 0.200, 0.250, 0.250, 0.500, 1.000] as [NSNumber]
        eyesOpacityAnimation.timingFunctions = [instantTiming, instantTiming, instantTiming, instantTiming, linearTiming, linearTiming]
        eyesOpacityAnimation.beginTime = beginTime
        eyesOpacityAnimation.fillMode = fillMode
        eyesOpacityAnimation.repeatCount = 50
        eyesOpacityAnimation.isRemovedOnCompletion = removedOnCompletion
        self.viewsByName["eyes__root"]?.layer.add(eyesOpacityAnimation, forKey:"2_Opacity")

        let eyesTranslationYAnimation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        eyesTranslationYAnimation.duration = 5.000
        eyesTranslationYAnimation.values = [0.000, -43.000, 0.000] as [Float]
        eyesTranslationYAnimation.keyTimes = [0.000, 0.500, 1.000] as [NSNumber]
        eyesTranslationYAnimation.timingFunctions = [easeOutTiming, easeInTiming]
        eyesTranslationYAnimation.beginTime = beginTime
        eyesTranslationYAnimation.fillMode = fillMode
        eyesTranslationYAnimation.repeatCount = 50
        eyesTranslationYAnimation.isRemovedOnCompletion = removedOnCompletion
        self.viewsByName["eyes__root"]?.layer.add(eyesTranslationYAnimation, forKey:"2_TranslationY")

        let faceRotationAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        faceRotationAnimation.duration = 5.000
        faceRotationAnimation.values = [0.017, 0.017, -0.125, -0.175, 0.017, 0.017] as [Float]
        faceRotationAnimation.keyTimes = [0.000, 0.400, 0.500, 0.580, 0.690, 1.000] as [NSNumber]
        faceRotationAnimation.timingFunctions = [linearTiming, linearTiming, easeOutTiming, easeInTiming, linearTiming]
        faceRotationAnimation.beginTime = beginTime
        faceRotationAnimation.fillMode = fillMode
        faceRotationAnimation.repeatCount = 1
        faceRotationAnimation.isRemovedOnCompletion = removedOnCompletion
        self.viewsByName["face__root"]?.layer.add(faceRotationAnimation, forKey:"2_Rotation")

        let faceTranslationYAnimation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        faceTranslationYAnimation.duration = 5.000
        faceTranslationYAnimation.values = [0.000, -43.000, 0.000] as [Float]
        faceTranslationYAnimation.keyTimes = [0.000, 0.500, 1.000] as [NSNumber]
        faceTranslationYAnimation.timingFunctions = [easeOutTiming, easeInTiming]
        faceTranslationYAnimation.beginTime = beginTime
        faceTranslationYAnimation.fillMode = fillMode
        faceTranslationYAnimation.repeatCount = 50
        faceTranslationYAnimation.isRemovedOnCompletion = removedOnCompletion
        self.viewsByName["face__root"]?.layer.add(faceTranslationYAnimation, forKey:"2_TranslationY")
    }

    func remove_2Animation() {
        self.layer.removeAnimation(forKey: "_2")
        self.viewsByName["closEyes__root"]?.layer.removeAnimation(forKey: "2_Opacity")
        self.viewsByName["closEyes__root"]?.layer.removeAnimation(forKey: "2_TranslationY")
        self.viewsByName["amrDue__root"]?.layer.removeAnimation(forKey: "2_Rotation")
        self.viewsByName["amrDue__root"]?.layer.removeAnimation(forKey: "2_TranslationY")
        self.viewsByName["body2__root"]?.layer.removeAnimation(forKey: "2_TranslationY")
        self.viewsByName["eyes__root"]?.layer.removeAnimation(forKey: "2_Rotation")
        self.viewsByName["eyes__root"]?.layer.removeAnimation(forKey: "2_Opacity")
        self.viewsByName["eyes__root"]?.layer.removeAnimation(forKey: "2_TranslationY")
        self.viewsByName["face__root"]?.layer.removeAnimation(forKey: "2_Rotation")
        self.viewsByName["face__root"]?.layer.removeAnimation(forKey: "2_TranslationY")
    }
    
    func sayHi(){
        
        
        
    }

    // MARK: CAAnimationDelegate
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let completion = self.animationCompletions[anim] {
            self.animationCompletions.removeValue(forKey: anim)
            completion(flag)
        }
    }

    func removeAllAnimations() {
        for subview in viewsByName.values {
            subview.layer.removeAllAnimations()
        }
        self.layer.removeAnimation(forKey: "_2")
    }
}
