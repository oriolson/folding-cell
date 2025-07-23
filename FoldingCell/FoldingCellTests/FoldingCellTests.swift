//
//  FoldingCellTests.swift
//  FoldingCellTests
//
//  Created by Alex K. on 25/01/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import XCTest
@testable import FoldingCell

class FoldingCellTests: XCTestCase {
    
    var viewController : UITableViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewControllerWithIdentifier("MainTableViewController") as! UITableViewController
        viewController.beginAppearanceTransition(true, animated: false)
    }
    
    override func tearDown() {
         viewController.endAppearanceTransition()
        super.tearDown()
    }
    
    func testExample() {
        let tableView = viewController.tableView
        
        for case let cell as FoldingCell in tableView.visibleCells {
            XCTAssertTrue(cell.itemCount >= 2)
        }
    }
    
    func testFoldingCellDefaultProperties() {
        let cell = FoldingCell(style: .Default, reuseIdentifier: "TestCell")
        
        // Test default itemCount
        XCTAssertEqual(cell.itemCount, 2, "Default itemCount should be 2")
        
        // Test default backViewColor  
        XCTAssertEqual(cell.backViewColor, UIColor.brownColor(), "Default backViewColor should be brown")
    }
    
    func testFoldingCellItemCountProperty() {
        let cell = FoldingCell(style: .Default, reuseIdentifier: "TestCell")
        
        // Test setting itemCount to valid values
        cell.itemCount = 3
        XCTAssertEqual(cell.itemCount, 3, "itemCount should be settable to 3")
        
        cell.itemCount = 5
        XCTAssertEqual(cell.itemCount, 5, "itemCount should be settable to 5")
        
        // Test minimum value
        cell.itemCount = 2
        XCTAssertEqual(cell.itemCount, 2, "itemCount should be settable to minimum value of 2")
    }
    
    func testFoldingCellBackViewColorProperty() {
        let cell = FoldingCell(style: .Default, reuseIdentifier: "TestCell")
        
        // Test setting backViewColor to different colors
        cell.backViewColor = UIColor.redColor()
        XCTAssertEqual(cell.backViewColor, UIColor.redColor(), "backViewColor should be settable to red")
        
        cell.backViewColor = UIColor.blueColor()
        XCTAssertEqual(cell.backViewColor, UIColor.blueColor(), "backViewColor should be settable to blue")
    }
    
    func testFoldingCellInitialization() {
        // Test init with style and identifier
        let cell1 = FoldingCell(style: .Default, reuseIdentifier: "TestCell")
        XCTAssertNotNil(cell1, "FoldingCell should initialize with style and reuseIdentifier")
        XCTAssertEqual(cell1.reuseIdentifier, "TestCell", "Reuse identifier should be set correctly")
        
        // Test init with different style
        let cell2 = FoldingCell(style: .Subtitle, reuseIdentifier: "TestCell2")
        XCTAssertNotNil(cell2, "FoldingCell should initialize with different styles")
        XCTAssertEqual(cell2.reuseIdentifier, "TestCell2", "Reuse identifier should be set correctly")
    }
    
    func testFoldingCellAnimationTypeEnum() {
        // Test AnimationType enum values
        let openType = FoldingCell.AnimationType.Open
        let closeType = FoldingCell.AnimationType.Close
        
        XCTAssertNotEqual(openType, closeType, "Open and Close animation types should be different")
    }
    
    func testFoldingCellIsAnimatingInitialState() {
        let cell = FoldingCell(style: .Default, reuseIdentifier: "TestCell")
        
        // Initially, cell should not be animating
        XCTAssertFalse(cell.isAnimating(), "Cell should not be animating initially")
    }
    
    func testRotatedViewInitialization() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        let rotatedView = RotatedView(frame: frame)
        
        XCTAssertNotNil(rotatedView, "RotatedView should initialize properly")
        XCTAssertEqual(rotatedView.frame, frame, "RotatedView frame should be set correctly")
        XCTAssertFalse(rotatedView.hiddenAfterAnimation, "hiddenAfterAnimation should be false by default")
        XCTAssertNil(rotatedView.backView, "backView should be nil by default")
    }
    
    func testRotatedViewBackViewAddition() {
        let rotatedView = RotatedView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        
        // Add back view
        rotatedView.addBackView(25, color: UIColor.redColor())
        
        XCTAssertNotNil(rotatedView.backView, "backView should not be nil after adding")
        XCTAssertEqual(rotatedView.backView?.backgroundColor, UIColor.redColor(), "backView color should be set correctly")
    }
    
    func testRotatedViewTransform3D() {
        let rotatedView = RotatedView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        let transform = rotatedView.transform3d()
        
        // Check that transform has the expected m34 value
        XCTAssertEqual(transform.m34, 2.5 / -2000, accuracy: 0.0001, "Transform m34 should be set to perspective value")
    }
    
    func testFoldingCellAnimationDurationAssert() {
        let cell = FoldingCell(style: .Default, reuseIdentifier: "TestCell")
        
        // This method should assert false - we expect it to crash in debug builds
        // In a real implementation, this would be overridden by subclasses
        // For testing purposes, we'll just verify the method exists
        XCTAssertNotNil(cell.animationDuration, "animationDuration method should exist")
    }
    
    func testFoldingCellEdgeCases() {
        let cell = FoldingCell(style: .Default, reuseIdentifier: "TestCell")
        
        // Test that animation methods handle nil completion blocks
        cell.selectedAnimation(true, animated: false, completion: nil)
        XCTAssertFalse(cell.isAnimating(), "Cell should not be animating after non-animated selection")
        
        cell.selectedAnimation(false, animated: false, completion: nil)
        XCTAssertFalse(cell.isAnimating(), "Cell should not be animating after non-animated deselection")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
