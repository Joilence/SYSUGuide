//
//  Storage.swift
//  SYSUGuide
//
//  Created by Jonathan Yang on 02/12/2016.
//  Copyright © 2016 JoilencePersonal. All rights reserved.
//

import Foundation

class Scene {
    var name: String = ""
    var id: Int = 0
    var description = ""
    
    init(name: String, id: Int, description: String) {
        self.name = name
        self.id = id
        self.description = description
    }
    
}

enum travelWay: Int {
    case walk = 0
    case drive = 1
}

class Storage {
    public var sceneCollection = [Scene]()
    
    public var walkEdgeMatrix = Array<Array<Int>>()
    
    public var walkPassMatrix = Array<Array<Array<Int>>>()
    
    init() {
        initialMatrix()
        generateScene()
        generateWalkEdge()
        generateWalkPass()
    }
    
    
    
    public func walk(aID: Int, bID: Int, time: Int) {
        if (aID >= sceneCollection.count || bID >= sceneCollection.count) { fatalError() }
        walkEdgeMatrix[aID][bID] = time
        walkEdgeMatrix[bID][aID] = time
    }
    
    func solveWalk() {
        for k in 0...8 {
            for i in 0...8 {
                for j in 0...8 {
                    if (walkEdgeMatrix[i][j] > walkEdgeMatrix[i][k] + walkEdgeMatrix[k][j]) {
                        walkEdgeMatrix[i][j] = walkEdgeMatrix[i][k] + walkEdgeMatrix[k][j]
                        print("From \(i) to \(j), you can pass \(k)")
//                        print("From \(sceneCollection[i].name) to \(sceneCollection[j].name), you can pass \(sceneCollection[k].name)")
                        walkPassMatrix[i][j].removeAll()
                        walkPassMatrix[i][j] += walkPassMatrix[i][k]
                        print("From \(i) to \(k), you need pass \(walkPassMatrix[i][k])")
                        walkPassMatrix[i][j].append(k)
                        walkPassMatrix[i][j] += walkPassMatrix[k][j]
                        print("From \(k) to \(j), you need pass \(walkPassMatrix[k][j])")
                        print("So now from \(i) to \(j) you need pass\(walkPassMatrix[i][j])")
                        print("-----")
                    }
                }
            }
        }
    }
    
    func getPathCollection(startID: Int, destinationID: Int) -> [Scene] {
        var result = [Scene]()
        result.append(sceneCollection[startID])
        for id in walkPassMatrix[startID][destinationID] {
            result.append(sceneCollection[id])
        }
        result.append(sceneCollection[destinationID])
        return result
    }
    
    func getTime(startID: Int, destinationID: Int) -> Int {
        return walkEdgeMatrix[startID][destinationID]
    }
}

extension Storage {
    func generateScene() {
        sceneCollection.removeAll()
        sceneCollection.append(Scene(name: "工学院钟楼", id: 0, description: "工学院钟楼是个好钟楼！"))
        sceneCollection.append(Scene(name: "中山大学东校区图书馆", id: 1, description: "中山大学东校区图书馆是个好图书馆！"))
        sceneCollection.append(Scene(name: "逸仙大道 - 中山先生塑像", id: 2, description: "中山先生塑像是个好塑像！"))
        sceneCollection.append(Scene(name: "中心花坛", id: 3, description: "中心花坛是个好花坛！"))
        sceneCollection.append(Scene(name: "中山大学牌坊", id: 4, description: "中山大学牌坊是个好牌坊"))
        sceneCollection.append(Scene(name: "明德园六号", id: 5, description: "明德园六号是个好六号！"))
        sceneCollection.append(Scene(name: "月影坡", id: 6, description: "月影坡是个好坡！"))
        sceneCollection.append(Scene(name: "中山大学东校体育馆", id: 7, description: "中山大学东校区体育馆是个好体育馆！"))
        sceneCollection.append(Scene(name: "落雁台", id: 8, description: "落雁台是个好台！"))
    }
    
    func initialMatrix() {
        walkEdgeMatrix.removeAll()
        for _ in 0...8 {
            walkEdgeMatrix.append([1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000])
        }
        for i in 0...8 {
            walkEdgeMatrix[i][i] = 0
        }
    }
    
    func generateWalkEdge() {
        walk(aID: 4, bID: 2, time: 5)
        walk(aID: 2, bID: 1, time: 5)
        walk(aID: 2, bID: 8, time: 10)
        walk(aID: 8, bID: 0, time: 8)
        walk(aID: 0, bID: 6, time: 4)
        walk(aID: 1, bID: 6, time: 12)
        walk(aID: 8, bID: 7, time: 15)
        walk(aID: 8, bID: 5, time: 18)
        walk(aID: 7, bID: 5, time: 6)
        walk(aID: 7, bID: 3, time: 12)
        walk(aID: 5, bID: 3, time: 8)
        walk(aID: 1, bID: 7, time: 15)
    }
    
    func generateWalkPass() {
        for i in 0...8 {
            walkPassMatrix.append([])
            for _ in 0...8 {
                walkPassMatrix[i].append([])
            }
        }
    }
}
