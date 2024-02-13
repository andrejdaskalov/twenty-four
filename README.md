# twenty_four

A novel social media experience. A Mobile Information Systems project for FCSE

## What is it?

TwentyFour is a social media app that limits the user to a single topic a day. The topic is
generated by the app and is the same for all users. The user can post, like, and comment on posts,
but only about the topic of the day. The app is designed to encourage users to think and talk about
a single topic, and to see how different people interpret the same topic.

It is a project for the Mobile Information Systems course at the Faculty of Computer Science and
Engineering, Skopje.


# Getting Started

## Installation

After cloning the repository and having installed the necessary tools for flutter applications:
[Installation Instructions](https://docs.flutter.dev/get-started/install), run:

```bash
flutter pub get

```

and then run the application with:

```bash 
flutter run
```

# Firebase

This app uses a Firebase backend. It's setup with the free Spark plan.
To clone the app, you must provide your own credentials and activate the necessary services.

The services used are:

- Firebase Authentication: with email and password provider
- Cloud Firestore: the noSQL database used to store the posts, comments, topics, and likes
- Firebase Storage: used to store the images of the posts

# Packages used

The full list of packages used:

- [firebase_core](https://pub.dev/packages/firebase_core)
- [firebase_auth](https://pub.dev/packages/firebase_auth)
- [cloud_firestore](https://pub.dev/packages/cloud_firestore)
- [firebase_storage](https://pub.dev/packages/firebase_storage)
- [flutter_bloc](https://pub.dev/packages/flutter_bloc)
- [get_it](https://pub.dev/packages/get_it)
- [injectable](https://pub.dev/packages/injectable)
- [go_router](https://pub.dev/packages/go_router)
- [camerawesome](https://pub.dev/packages/camerawesome)
- [geolocator](https://pub.dev/packages/geolocator)
- [geocoding](https://pub.dev/packages/geocoding)
- [better_open_file](https://pub.dev/packages/better_open_file)
- [google_fonts](https://pub.dev/packages/google_fonts)
- [flutter_image_compress](https://pub.dev/packages/flutter_image_compress)

# Architecture

## BLoC pattern

The app uses the BLoC pattern for state management.
The BLoC pattern is used to separate the business logic from the UI.
The app uses the flutter_bloc package to implement the BLoC pattern.
Each bloc takes events from the UI, processes them and returns a state to the UI.

## Repository pattern

The app uses the repository pattern to abstract the data layer from the rest of the app.
There is an *_api class for each different type of data exchange (posts, comments, topics, likes,
users), but they are grouped into the post, comment and topic repositories.

## Dependency Injection and Factory pattern

The app uses the get_it package for dependency injection.
The app uses the injectable package to *generate the necessary **factories*** for the dependency
injection.
Each dependency injected class is annotated with @injectable, and the necessary factories are
generated with the command:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

This command executes the build_runner package, which generates the necessary factories for the
dependency injection.

# Firebase singletons

The app uses the firebase_core package to initialize the firebase app.
Each firebase plugin exposes a singleton instance of the plugin, which is used to interact with the
firebase services.

# Routing

The app uses the go_router package for routing.
The go_router package is a simple and easy to use package for routing in flutter applications.

# Camera

The app uses the camerawesome package to take pictures.
THe camerawesome package allows for a lot of customization and is easy to use.
In this app, it is used to create a custom camera screen, where the user can take a picture.
It has many features like flash, focus, and zoom, as well as filters!

## Compression

The app uses the flutter_image_compress package to compress the images before uploading them to the
firebase storage.
The images are compressed to reduce the size and the time it takes to upload them to the storage.

# Geolocation and reverse geocoding

The app uses the geolocator package to get the user's location. This provides the app with
coordinates.
The app then uses the geocoding package to reverse geocode the coordinates into a human-readable
address. The app uses localities like cities and municipalities. Only the name of the city is
persisted into the database, making it **privacy friendly**.

# Custom UI components
The app features many custom UI components, like the custom camera screen, the custom post screen,
the custom comment screen, and the custom cards.
