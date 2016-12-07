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
    var walkEdgeCollection = [Edge]()
    var driveEdgeCollection = [Edge]()
    var description = ""
    
    init(name: String, id: Int, description: String) {
        self.name = name
        self.id = id
        self.description = description
    }
    
}

class Edge {
    var aID: Int = 0
    var bID: Int = 0
    var time: Int = 0
    
    init(aID: Int, bID: Int, time: Int) {
        self.aID = aID
        self.bID = bID
        self.time = time
    }
}

enum travelWay: Int {
    case walk = 0
    case drive = 1
}

class Storage {
    public var sceneCollection = [Scene]()
    
    public var walkEdgeMatrix = Array<Array<Int>>()
    public var driveEdgeMatrix = Array<Array<Int>>()
    
    init() {
        // Generate Scene and initial matrix
        for _ in 0...8 {
            walkEdgeMatrix.append([-1, -1, -1, -1, -1, -1, -1, -1, -1])
            driveEdgeMatrix.append([-1, -1, -1, -1, -1, -1, -1, -1, -1])
        }
        // Generate Scene
        sceneCollection.append(Scene(name: "工学院钟楼", id: 0, description: "工学院钟楼是个好钟楼！"))
        sceneCollection.append(Scene(name: "中山大学东校区图书馆", id: 1, description: "中山大学东校区图书馆是个好图书馆！"))
        sceneCollection.append(Scene(name: "逸仙大道 - 中山先生塑像", id: 2, description: "中山先生塑像是个好塑像！"))
        sceneCollection.append(Scene(name: "中心花坛", id: 3, description: "中心花坛是个好花坛！"))
        sceneCollection.append(Scene(name: "中山大学牌坊", id: 4, description: "中山大学牌坊是个好牌坊"))
        sceneCollection.append(Scene(name: "明德园六号", id: 5, description: "明德园六号是个好六号！"))
        sceneCollection.append(Scene(name: "月影坡", id: 6, description: "月影坡是个好坡！"))
        sceneCollection.append(Scene(name: "中山大学东校区体院馆", id: 7, description: "中山大学东校区体院馆是个好体育馆！"))
        sceneCollection.append(Scene(name: "落雁台", id: 8, description: "落雁台是个好台！"))
        // Generate Walk Edge
        
        // Generate Drive Edge
    }
    
    public func walk(aID: Int, bID: Int, time: Int) {
        if (aID >= sceneCollection.count || bID >= sceneCollection.count) { fatalError() }
        walkEdgeMatrix[aID][bID] = time
        walkEdgeMatrix[bID][aID] = time
    }
    
    public func drive(aID: Int, bID: Int, time: Int) {
        if (aID >= sceneCollection.count || bID >= sceneCollection.count) { fatalError() }
        driveEdgeMatrix[aID][bID] = time
        driveEdgeMatrix[bID][aID] = time
    }
    
    public func guide(aID: Int, bID: Int, option: travelWay) -> [Scene] {
        if option == .walk {
            return solveWalk(startID: aID, destinationID: bID)
        } else {
            return solveDrive(startID: aID, destinationID: bID)
        }
    }
    
    func solveDrive(startID: Int, destinationID: Int) -> [Scene] {
        return [Scene]()
    }
    
    func solveWalk(startID: Int, destinationID: Int) -> [Scene] {
        return [Scene]()
    }
}
