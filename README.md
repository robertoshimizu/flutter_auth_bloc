# Flutter Auth Bloc

This project aim to use Bloc for authenticate Users in a application using Otp (Phone Verification), also known as passwordless mode.

There will be two versions: one using Firebase and other using Http/OAuth.

It also an opportunity to use Clean Architecture, DDD, TDD and deploy in a CI/CD tool.

## Flutter Clean Architecture

![alt text](https://blog.cleancoder.com/uncle-bob/images/2012-08-13-the-clean-architecture/CleanArchitecture.jpg "source: https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html
")

The overriding rule that makes this architecture work is *The Dependency Rule*. This rule says that source code dependencies can only point inwards. Nothing in an inner circle can know anything at all about something in an outer circle. In particular, the name of something declared in an outer circle must not be mentioned by the code in the an inner circle. That includes, functions, classes. variables, or any other named software entity.

By the same token, data formats used in an outer circle should not be used by an inner circle, especially if those formats are generate by a framework in an outer circle. We don’t want anything in an outer circle to impact the inner circles.

### Contents of Domain
`Domain` is made up of several things.

#### Entities
- Enterprise-wide business rules
- Made up of classes that can contain methods
- Business objects of the application
Used application-wide
- Least likely to change when something in the application changes
#### Usecases
- Application-specific business rules
- Encapsulate all the usecases of the application
- Orchestrate the flow of data throughout the app
- Should not be affected by any UI changes whatsoever
- Might change if the functionality and flow of application change
- This should differ when using BloC, more clarifications later on.
#### Repositories
- Abstract classes that define the expected functionality of outer layers
- Are not aware of outer layers, simply define expected functionality
    - E.g. The Login usecase expects a Repository that has login functionality
- Passed to Usecases from outer layers
`Domain` represents the inner-most layer. Therefore, it the most abstract layer in the architecture.

### Presentation

`Presentation` is the layer outside `Domain`. `Presentation` crosses the boundaries of the layers to communicate with `Domain`. However, *the Dependency Rule* is never violated. Using polymorphism, `Presentation` communicates with `Domain` using inherited class: classes that implement or extend the Repositories present in the `Domain` layer. Since polymorphism is used, the Repositories passed to `Domain` still adhere to the *Dependency Rule* since as far as `Domain` is concerned, they are abstract. The implementation is hidden behind the polymorphism.

### Contents of Presentation
Since `Presentation` is the presentation layer of the application, it is the most framework-dependent layer, as it contains the UI and the event handlers of the UI.  It is this layer, for example, that will wholly contain the **MVC architecture of a GUI**. The Presenters, Views, and Controllers all belong in here. For **every page** in the application, `Presentation` defines at least 3 classes: a Controller, a Presenter, and a View.

This format differs when using Bloc, whose details and interrelationships will be clarified later on.

