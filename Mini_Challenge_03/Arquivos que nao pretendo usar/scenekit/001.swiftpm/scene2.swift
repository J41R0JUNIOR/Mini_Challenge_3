import SpriteKit
import SwiftUI

class GameView2: SKScene {
    var planets: [SKSpriteNode] = []
    var isTrue = true

    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }

        let touchLocation = touch.location(in: self)
        let previousLocation = touch.previousLocation(in: self)

        for planet in planets {
            if planet.contains(previousLocation) {
                let deltaX = touchLocation.x - previousLocation.x
                let deltaY = touchLocation.y - previousLocation.y
                let impulse = CGVector(dx: deltaX, dy: deltaY)
                planet.physicsBody?.applyImpulse(impulse)
            }
        }
    }

//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let touch = touches.first {
//            let touchLocation = touch.location(in: self.view)
//            if(planets.count < 4 && isTrue == true){
//                createPlanet(x: Float(touchLocation.x), y: Float(touchLocation.y))
//            }
//        }
//    }

    func createPlanet(x: Float, y: Float) {
        guard size.width > 0 && size.height > 0 else {
            return
        }

        let planet = SKSpriteNode(imageNamed: "planet")
        let mass = CGFloat.random(in: 1.8...2.0)
        let sizeFactor = 30.0
        let planetSize = CGSize(width: mass * sizeFactor, height: mass * sizeFactor)

        planet.size = planetSize
        planet.position = CGPoint(x: CGFloat(x),
                                  y: CGFloat(y))
        planet.physicsBody = SKPhysicsBody(circleOfRadius: planetSize.width / 2)
        planet.physicsBody?.affectedByGravity = false
        planet.physicsBody?.mass = mass
        addChild(planet)
        planets.append(planet)
    }
    
    func addPlanetButtonPressed() {
        let screenWidth = size.width
        let screenHeight = size.height
        let randomX = Float.random(in: 0...Float(screenWidth))
        let randomY = Float.random(in: 0...Float(screenHeight))
        createPlanet(x: randomX, y: randomY)
    }
    
    override func update(_ currentTime: TimeInterval) {
        for planet in planets {
            applyGravity(to: planet)
        }
    }

    func applyGravity(to planet: SKSpriteNode) {
        for otherPlanet in planets {
            if planet != otherPlanet {
                let distance = planet.position.distance(to: otherPlanet.position)
                let attractionRadius = max(planet.physicsBody!.mass, otherPlanet.physicsBody!.mass) * 60.0

                if distance < attractionRadius {
                    let gravityForce = CGFloat(1000) / distance
                    let angle = atan2(otherPlanet.position.y - planet.position.y,
                                      otherPlanet.position.x - planet.position.x)
                    let gravityVector = CGVector(dx: cos(angle) * gravityForce,
                                                 dy: sin(angle) * gravityForce)

                    planet.physicsBody?.applyForce(gravityVector)
                }
            }
        }
    }
}

extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        return hypot(point.x - x, point.y - y)
    }
}

struct SpriteKitView: UIViewRepresentable {
    func makeUIView(context: Context) -> SKView {
        let skView = SKView()
        skView.isMultipleTouchEnabled = true
        let sceneSize = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        let gameScene = GameView2(size: sceneSize)
        skView.presentScene(gameScene)

        let addPlanetButton = UIButton(type: .system)
        addPlanetButton.setTitle("Adicionar Planeta", for: .normal)
        addPlanetButton.frame = CGRect(x: 20, y: 20, width: 150, height: 30)
        addPlanetButton.addTarget(context.coordinator, action: #selector(Coordinator.addPlanetButtonPressed), for: .touchUpInside)
        skView.addSubview(addPlanetButton)

        context.coordinator.scene = gameScene

        return skView
    }

    func updateUIView(_ uiView: SKView, context: Context) {
    }

    class Coordinator: NSObject {
        var scene: GameView2?

        @objc func update(_ sender: UITapGestureRecognizer) {
            // Você pode adicionar interações ou manipulações aqui
        }

        @objc func addPlanetButtonPressed() {
            scene?.addPlanetButtonPressed()
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    func updateUIView(_ uiView: GameView, context: Context) {
    }
}
