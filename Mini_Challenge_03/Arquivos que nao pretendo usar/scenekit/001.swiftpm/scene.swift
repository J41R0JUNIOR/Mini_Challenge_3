import SwiftUI
import SceneKit

struct GameView: UIViewRepresentable {
    
    
    var ball : SCNNode = {
        let object = SCNNode(geometry: SCNSphere(radius: 0.6))
        let ballMaterial = SCNMaterial()
        ballMaterial.diffuse.contents = UIColor.red
        object.geometry?.materials = [ballMaterial]
        object.position = SCNVector3(x: 0, y: 0, z: -2)
        
        return object
    }()
    
    let orbitingBall: SCNNode = {
        let object = SCNNode(geometry: SCNSphere(radius: 0.4))
        let orbitingBallMaterial = SCNMaterial()
        orbitingBallMaterial.diffuse.contents = UIColor.blue
        object.geometry?.materials = [orbitingBallMaterial]
        object.position = SCNVector3(x: 1, y: 0, z: -2)

        return object
    }()
    
    var gridNode = SCNNode()

    let scene: SCNScene = SCNScene()
    let sceneView = SCNView()
    
   

    func makeUIView(context: Context) -> SCNView {
        sceneView.scene = scene
        sceneView.backgroundColor = .clear
        sceneView.autoenablesDefaultLighting = true

        sceneView.allowsCameraControl = true
        sceneView.defaultCameraController.interactionMode = .orbitTurntable
        sceneView.defaultCameraController.inertiaEnabled = true
    

        scene.rootNode.addChildNode(ball)
        ball.addChildNode(orbitingBall)


        addSpaceTimeGrid()
        

        scene.rootNode.addChildNode(gridNode)

        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: ball.position.x, y: 0, z: 5)
        scene.rootNode.addChildNode(cameraNode)

        let ambientLight = SCNLight()
        ambientLight.type = .ambient
        ambientLight.color = UIColor.white
        ambientLight.intensity = 100

        let ambientLightNode = SCNNode()
        ambientLightNode.light = ambientLight
        scene.rootNode.addChildNode(ambientLightNode)

        return sceneView
    }


    func updateUIView(_ uiView: SCNView, context: Context) {
        let rotationAction = SCNAction.rotateBy(x: 0, y: CGFloat(2 * Double.pi), z: 0, duration: 5.0)
        let repeatAction = SCNAction.repeatForever(rotationAction)
        ball.runAction(repeatAction)
        orbitingBall.runAction(repeatAction)
        
        
    }

    func addSpaceTimeGrid() {
        let gridMaterial = SCNMaterial()
        gridMaterial.diffuse.contents = UIColor.gray.withAlphaComponent(0.5)

        let gridLineMaterial = SCNMaterial()
        gridLineMaterial.diffuse.contents = UIColor.black

        let gridSize: CGFloat = 10.0
        let divisions: CGFloat = 2

        let halfSize = gridSize / 2.0
        let divisionSize = gridSize / divisions

        let gridPosition = SCNVector3(x: 0, y: ball.position.y, z: -2)
        let rotation = SCNMatrix4MakeRotation(Float(-Double.pi / 2), 1, 0, 0)

        for i in 0..<Int(divisions) {
            for j in 0..<Int(divisions) {
                let x = -halfSize + CGFloat(i) * divisionSize
                let y = -halfSize + CGFloat(j) * divisionSize

                // Define os vértices do quadrado
                let vertices: [SCNVector3] = [
                    SCNVector3(x: Float(x), y: Float(y), z: 0),
                    SCNVector3(x: Float(x + divisionSize), y: Float(y), z: 0),
                    SCNVector3(x: Float(x), y: Float(y + divisionSize), z: 0),
                    SCNVector3(x: Float(x + divisionSize), y: Float(y + divisionSize), z: 0)
                ]

                // Define os índices dos triângulos do quadrado
                let indices: [UInt16] = [0, 1, 2, 2, 1, 3]

                // Itera sobre os índices dos triângulos
                for triangleIndex in stride(from: 0, to: indices.count, by: 3) {
                    let vertexIndex1 = Int(indices[triangleIndex])
                    let vertexIndex2 = Int(indices[triangleIndex + 1])
                    let vertexIndex3 = Int(indices[triangleIndex + 2])

                    // Acesse os vértices usando os índices
                    let vertex1 = vertices[vertexIndex1]
                    let vertex2 = vertices[vertexIndex2]
                    let vertex3 = vertices[vertexIndex3]

                    // Imprima as posições dos vértices do triângulo
                    print("Triangle \(triangleIndex / 3 + 1):")
                    print("Vertex 1: \(vertex1)")
                    print("Vertex 2: \(vertex2)")
                    print("Vertex 3: \(vertex3)")
                    print("---")
                }

                // Cria a geometria do quadrado
                let element = SCNGeometryElement(indices: indices, primitiveType: .triangles)
                let geometry = SCNGeometry(sources: [SCNGeometrySource(vertices: vertices)], elements: [element])
                geometry.materials = [gridMaterial]

                // Cria o nó do quadrado
                let squareNode = SCNNode(geometry: geometry)
                squareNode.transform = SCNMatrix4Mult(rotation, squareNode.transform)
                squareNode.position = SCNVector3(x: 0, y: 0, z: 0)

                gridNode.addChildNode(squareNode)

                // Adiciona as bordas
                let borderIndices: [UInt16] = [0, 1, 1, 3, 3, 2, 2, 0]
                let borderElement = SCNGeometryElement(indices: borderIndices, primitiveType: .line)
                let borderGeometry = SCNGeometry(sources: [SCNGeometrySource(vertices: vertices)], elements: [borderElement])
                borderGeometry.materials = [gridLineMaterial]

                let borderNode = SCNNode(geometry: borderGeometry)
                borderNode.transform = SCNMatrix4Mult(rotation, borderNode.transform)
                borderNode.position = SCNVector3(x: 0, y: 0, z: 0)

                gridNode.addChildNode(borderNode)
            }
        }

        gridNode.position = gridPosition
    }



    typealias UIViewType = SCNView
}
