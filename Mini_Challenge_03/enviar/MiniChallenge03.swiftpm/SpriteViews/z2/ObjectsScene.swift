import SpriteKit
import SwiftUI

class ObjectsScene: SKScene {
    var objects: [SKSpriteNode] = []
    @Binding var sceneSpeed: Double
    @Binding var witchObject: String
    @Binding var canClearChat: Bool
    
    let cameraNode = SKCameraNode()
    var waveNode: SKShapeNode?
    var currentTime: TimeInterval = 0.0


    var objectsName: [String] = ["earth", "jupiter", "earth", "jupiter", "earth", "jupiter", "earth", "jupiter","earth", "jupiter", "earth","earth", "jupiter", "earth"]
    
    var areThereObjectAtScreen: Bool = false
    
    init(sceneSpeed: Binding<Double>, witchObject: Binding<String>, canClearChat: Binding<Bool>) {
        self._sceneSpeed = sceneSpeed
        self._witchObject = witchObject
        self._canClearChat = canClearChat
        
        super.init(size: CGSize())
        scaleMode = .resizeFill
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = .clear
        self.addChild(cameraNode)
        cameraNode.position = CGPoint(x: 0, y: 0)
        cameraNode.setScale(1.0)
        self.camera = cameraNode
        
    }
    
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        _ = touch.location(in: self)
        _ = touch.previousLocation(in: self)
    }
    
    override func update(_ currentTime: TimeInterval) {
        //        print(self.view?.scene?.children.count)
        for (_, object) in self.children.enumerated().reversed() {
            if let objectFound = object as? SKSpriteNode{
                updateObjectWidth(object: objectFound)
            }
        }
        
        self.currentTime = currentTime
        if objects.count > 0{
            createWave()
        }else{
            if let node = self.childNode(withName: "waveShapeNode"){
                node.removeFromParent()
            }
        }
        
//        if let firstObject = objects.first {
//            waveNode?.position.x = firstObject.position.x
//        }
        
        moveObjects(withSpeed: CGFloat(sceneSpeed))
        removeObjectsOutOfBounds()
        changeColorsOfObjects()
        
        if self.witchObject == "Anything" {
            witchObject = "obj in scene"
            
            let delayAction = SKAction.wait(forDuration: 1)
            let callFunctionAction = SKAction.run { [weak self] in
                self?.scheduleObjectCreation()
            }
            self.run(SKAction.sequence([delayAction, callFunctionAction]))
        }
    }
    
    func scheduleObjectCreation() {
        guard let object = self.objectsName.first else {
            return
        }
        
        self.createObjects(nameOfObject: object)
        self.areThereObjectAtScreen = true
        self.witchObject = object
        
        if let indexToRemove = self.objectsName.firstIndex(of: object) {
            self.objectsName.remove(at: indexToRemove)
        }
    }
    
    func calculateRealSpeed(_ speed: Double) -> CGFloat {
        let realSpeed = CGFloat((speed * 299792 / 50) * 0.9)
        return realSpeed
    }

    func updateObjectWidth(object: SKSpriteNode) {
        let witchOne: [String: SizesEnum] = ["earth": .earth, "jupiter": .jupiter]
        let realSpeed = calculateRealSpeed(sceneSpeed)
        
        if let name = object.name, let originalSize: CGSize = (witchOne[name]?.size) {
            
            let contractedWidth = originalSize.width * sqrt(1 - pow((realSpeed / 299792), 2))
            
            let newWidth = contractedWidth
            
            object.size = CGSize(width: newWidth, height: originalSize.height)
        }
    }
    
    func createObjects(nameOfObject: String) {
        canClearChat = false
        let object: SKSpriteNode = {
            let node = SKSpriteNode(imageNamed: nameOfObject)
            
            if nameOfObject == "jupiter" {
                node.size = SizesEnum.jupiter.size
            } else if nameOfObject == "earth" {
                node.size = SizesEnum.earth.size
            }else{
                node.size = SizesEnum.defaultValue.size
            }
            node.name = nameOfObject
            
            let x = /*size.width*/ (CGFloat(self.view?.bounds.size.width ?? 700)/2) + (CGFloat(node.size.width )/2)
            node.position = CGPoint(x: x, y: 0)
            return node
        }()
        
        objects.append(object)
        addChild(object)
    }
    
    func removeObjectsOutOfBounds() {
        for object in objects {
            let x = object.position.x
            let screenWidth = CGFloat(self.view?.bounds.size.width ?? 700)
            if x < -screenWidth/2 - (CGFloat(objects.first?.size.width ?? 650)/2) {
                object.removeFromParent()
                
                if let indexToRemove = objects.firstIndex(of: object) {
                    objects.remove(at: indexToRemove)
                    areThereObjectAtScreen = false
                    witchObject = "Anything"
                    canClearChat = true
                }
            }
        }
    }
    
    func moveObjects(withSpeed speed: CGFloat) {
        for object in objects {
            if object.action(forKey: "moving") == nil {
                let speedFactor = 1
                let moveAction = SKAction.moveBy(x: -10 * (speed * 0.2) * CGFloat(speedFactor), y: 0, duration: 0.1)
                object.run(moveAction, withKey: "moving")
            }
        }
    }
    
    func createWave() {
        if let node = self.childNode(withName: "waveShapeNode"){
            node.removeFromParent()
        }
        let wavePath = UIBezierPath()
        var amplitude: CGFloat = sceneSpeed * 2
        var numberOfPoints = 10
        let waveVelocity: CGFloat = 5 + (sceneSpeed * 0.15)
        var complement: CGFloat = 0
        
        if let obj = objects.first{
            if obj.position.x > 0 {
                complement = 10
                numberOfPoints = 50
                amplitude = sceneSpeed * 2
            }else if obj.position.x < 0{
                complement = 50
                numberOfPoints = 5
                amplitude = sceneSpeed * 1
            }
        }
        
        for i in 0...numberOfPoints {
            let x = CGFloat(i) * complement
            let y = amplitude * sin(CGFloat(i) + currentTime * waveVelocity)
            let point = CGPoint(x: x, y: y)
            
            if i == 0 {
                wavePath.move(to: point)
            } else {
                wavePath.addLine(to: point)
            }
        }
    
        let waveShapeNode = SKShapeNode(path: wavePath.cgPath)
        waveShapeNode.position = CGPoint(x: self.frame.minX - (waveShapeNode.frame.width/2), y: (self.frame.height / 2) - (waveShapeNode.frame.height))
        
        if let object = objects.first{
            waveShapeNode.strokeColor = object.position.x > 0 ? SKColor.blue : SKColor.red
        }
        
        waveShapeNode.name = "waveShapeNode"
        
        if self.childNode(withName: "waveShapeNode") == nil{
            addChild(waveShapeNode)
        }
        
        self.waveNode = waveShapeNode
        
    }
    
    func changeColorsOfObjects(){
        let screenWidth = CGFloat(self.view?.bounds.width ?? 700) - 550
        
        let x = objects.first?.position.x ?? CGFloat()
        let normalizedX = x / (screenWidth / 2) * sceneSpeed - (x > 0 ? 2 : -2)
        
        
        let redColor = max(0.0, 1.0 - normalizedX)
        
        
        let blueColor = max(0.0, 1.0 + normalizedX)
        
        let viewW = (view?.bounds.size.width ?? CGFloat(200))
        
        
        objects.first?.color = SKColor(red: redColor, green: 0.0, blue: blueColor, alpha: 1.0)
        
        if let position = objects.first?.position.x{
            let percentV = abs((position * 100) / (viewW / 2) / 100)
            let value =  ((percentV) / 2)
            
            objects.first?.colorBlendFactor = value
        }
        
        let mult = 0.1
        
        if objects.first?.position.x ?? CGFloat() < viewW * mult && objects.first?.position.x ?? CGFloat() > -viewW * mult{
            objects.first?.colorBlendFactor = 0
        }
    }
}



struct ObjectsSceneView: UIViewRepresentable {
    @Binding var sceneSpeed: Double
    @Binding var witchObject: String
    @Binding var canClearChat: Bool
    
    func makeUIView(context: Context) -> SKView {
        let skView = SKView()
        skView.isMultipleTouchEnabled = true
        skView.backgroundColor = .clear
        let sceneSize = CGSize(width: 700, height: 500)
        let gameScene = ObjectsScene(sceneSpeed: $sceneSpeed, witchObject: $witchObject, canClearChat: $canClearChat)
        gameScene.size = sceneSize
        skView.presentScene(gameScene)
        
        return skView
    }
    
    func updateUIView(_ uiView: SKView, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    func updateUIView(_ uiView: ObjectsScene, context: Context) {
    }
}
