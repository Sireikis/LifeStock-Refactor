# LifeStock-Refactor

This is an architectural refactor of my first project. Below I layout some of my thoughts on the project.

My general approach was to contain the state of my app along with any services that may be performed outside of the presentation layer in a single object that is instantiated as the app is launched in main. AppState is a class that's observable and contains my models, to facilitate passing around shared state to views that require them. Many views share a viewModel if they are related or consist of separate components. These viewModel can be subdivided further than they already are. The issue this presented is that AppState was held by a view's viewModel, which is also a class. Nested ObservableObjects don't behave very well as far as notifying views of an update to the model (they don't cause the view to redraw). To fix this each viewModel had to utilize Combine to listen to the model contained within AppState.

Much of my view generation logic utilizes conditional statements instead of polymorphism. Generating different views for varying numbers of players could be handled by a factory rather than functions in a view. Some components could be made more generic, particularly CheckBox and LifeChangerView/CalculatorView. I recall attempting this, but ran into issues with views updating when viewModel methods were passed into generic versions of these views as dependencies.

The viewrouting for this app is overly complicated, as it does not use built in SwiftUI navigation (NavigationView). I wanted to create transitions between views that depended on which view came before the destination view. Perhaps this is my lack of experience, but I'm under the impression that SwiftUI can't do this using NavigationView. My attempts at achieving this have failed, because I was not able to hide the visual influence that NavigationViews have on the rest of the views they contain. Perhaps the new addition of Scene could make this simpler. The current implementation was taken from the post linked below. It's important to note that my approach is not scalable. This is because Group and other viewbuilders may only house up to 10 views. Perhaps return viewing as the result of a switch statement as the article shows gets around this, but I don't know if layering views on top of each other would work well. This seems like a situation where the switch statement would face a cartesian product scenario.

https://blckbirds.com/post/how-to-navigate-between-views-in-swiftui-by-using-an-environmentobject/

Inspiration for the refactor came from nalexn's clean architecture project below. Much of what makes his architecture clean was omitted due to a lack of understanding on my part (EnvironmentKeys, Combine, DeepLinksHandler). Granted this particular project has a much smaller scope and does not require much of what his project showcases. However it would certainly benefit from a deeper integration with native iOS features.

https://github.com/nalexn/clean-architecture-swiftui/tree/mvvm