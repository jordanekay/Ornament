# Mensa: Smart Tables

Shows three simple techniques for modern UITableViews. The three techniques are each separate in concept but are combined in this demo project; you can use each independently.

## Computation of row height via auto-layout

The table view controller keeps a extra ‘metrics’ cell property that is used to populate and layout cells for height calculation purposes.

This is primarily useful for cells that use Auto Layout. You no longer have to perform clumsy and awkward height calculation - just use Auto Layout and you get height calculation for free.

The downside of this is that your cells are laid out twice and Auto Layout is potentially expensive. You could mitigate this by caching the results of the first lay out and then reusing it for the second. But caching metrics is somewhat tricky to get right. The cache needs to be abandoned or updated if the table is editable or table size changes, rotations, dynamic text size changes (iOS 7) and probably under many other situations too. 

In practice with the typical view you’d see in a table view (e.g. a complex tweet view) the double layout isn’t expensive.

## View controllers as cell prototypes

Use of UIViewControllers in table view cells and runtime generation of cell classes for specific view controllers

This is useful because table cells aren’t usable outside of tables. By hosting content inside a view controller and then hosting that view controller inside a cell you can reuse that UI in other parts of your app very easily. This is often handy.

The technique generates at runtime a subclass of MNSHostingTableViewCell that hosts a specific view controller class. This allows you to register a cell class with your table view as needed. This technique works very well with cell reuse.

## View controller registration for backing objects

To populate their table view’s content, `MNSTableViewController` instances define a `sections` array populated with `MNSTableViewSection` (to include a section header or footer) or `NSArray` instances. To display the objects in each section, the table view controller registers a `MNSHostedViewController` subclass to use with each model object class. The view controller references a view (or set of views if needed, to customize the display of the object based on its properties) whose contents are updated based on the model object to display.

This allows developers to consolidate display logic to a separate view controller for a view displaying that object in populating its contents and selecting it in a table view. Table view controller subclasses can customize this behavior further based on their own state or behavior specified wherever necessary.

## Requirements

Project uses Xcode 5b3 (specifically the nibs) - but the techniques used work fine on iOS 6+.
