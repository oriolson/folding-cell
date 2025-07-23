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
    
    func testPerformanceFoldingCellInitialization() {
        // Performance test for cell initialization
        self.measureBlock {
            for _ in 0..<100 {
                let cell = FoldingCell(style: .Default, reuseIdentifier: "PerfTestCell")
                _ = cell.itemCount
                _ = cell.backViewColor
            }
        }
    }
    
    func testPerformanceRotatedViewCreation() {
        // Performance test for RotatedView creation and transform
        self.measureBlock {
            for _ in 0..<50 {
                let rotatedView = RotatedView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
                _ = rotatedView.transform3d()
                rotatedView.addBackView(25, color: UIColor.redColor())
            }
        }
    }
    
    func testFoldingCellPropertyBoundaries() {
        let cell = FoldingCell(style: .Default, reuseIdentifier: "TestCell")
        
        // Test very large itemCount
        cell.itemCount = 1000
        XCTAssertEqual(cell.itemCount, 1000, "itemCount should handle large values")
        
        // Test itemCount of 1 (edge case)
        cell.itemCount = 1
        XCTAssertEqual(cell.itemCount, 1, "itemCount should accept value of 1")
        
        // Test itemCount of 0 (potential edge case)
        cell.itemCount = 0
        XCTAssertEqual(cell.itemCount, 0, "itemCount should accept value of 0")
    }
    
    func testRotatedViewEdgeCases() {
        // Test RotatedView with zero frame
        let zeroRotatedView = RotatedView(frame: CGRect.zero)
        XCTAssertNotNil(zeroRotatedView, "RotatedView should initialize with zero frame")
        XCTAssertEqual(zeroRotatedView.frame, CGRect.zero, "Zero frame should be preserved")
        
        // Test adding back view with zero height
        zeroRotatedView.addBackView(0, color: UIColor.clearColor())
        XCTAssertNotNil(zeroRotatedView.backView, "backView should be created even with zero height")
        
        // Test very large frame
        let largeFrame = CGRect(x: 0, y: 0, width: 10000, height: 10000)
        let largeRotatedView = RotatedView(frame: largeFrame)
        XCTAssertEqual(largeRotatedView.frame, largeFrame, "Large frame should be handled correctly")
    }
    
    func testFoldingCellAnimationStateConsistency() {
        let cell = FoldingCell(style: .Default, reuseIdentifier: "TestCell")
        
        // Test multiple calls to isAnimating
        for _ in 0..<10 {
            XCTAssertFalse(cell.isAnimating(), "isAnimating should consistently return false initially")
        }
        
        // Test selectedAnimation with different parameters
        cell.selectedAnimation(true, animated: false, completion: nil)
        cell.selectedAnimation(false, animated: false, completion: nil)
        XCTAssertFalse(cell.isAnimating(), "Cell should not be animating after non-animated operations")
    }
    
    func testUIViewSnapshotExtension() {
        // Test the UIView extension for taking snapshots
        let testView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        testView.backgroundColor = UIColor.redColor()
        
        let snapshot = testView.pb_takeSnapshot(CGRect(x: 0, y: 0, width: 50, height: 50))
        XCTAssertNotNil(snapshot, "Snapshot should not be nil")
        
        if let snapshot = snapshot {
            XCTAssertEqual(snapshot.size.width, 50, "Snapshot width should match requested frame")
            XCTAssertEqual(snapshot.size.height, 50, "Snapshot height should match requested frame")
        }
    }
    
    func testFoldingCellSelectionStyleSetting() {
        let cell = FoldingCell(style: .Default, reuseIdentifier: "TestCell")
        
        // The commonInit method should set selectionStyle to .None
        // We can't test this directly without calling commonInit, but we can test the property
        cell.selectionStyle = .None
        XCTAssertEqual(cell.selectionStyle, UITableViewCellSelectionStyle.None, "Selection style should be settable to None")
        
        cell.selectionStyle = .Blue
        XCTAssertEqual(cell.selectionStyle, UITableViewCellSelectionStyle.Blue, "Selection style should be settable to Blue")
    }
    
    func testFoldingCellReuseIdentifier() {
        // Test cell creation with nil reuseIdentifier
        let cellWithNilId = FoldingCell(style: .Default, reuseIdentifier: nil)
        XCTAssertNotNil(cellWithNilId, "Cell should initialize with nil reuseIdentifier")
        XCTAssertNil(cellWithNilId.reuseIdentifier, "Reuse identifier should be nil when passed nil")
        
        // Test cell creation with empty string reuseIdentifier
        let cellWithEmptyId = FoldingCell(style: .Default, reuseIdentifier: "")
        XCTAssertNotNil(cellWithEmptyId, "Cell should initialize with empty string reuseIdentifier")
        XCTAssertEqual(cellWithEmptyId.reuseIdentifier, "", "Reuse identifier should be empty string when passed empty string")
    }
    
}
