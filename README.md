# emotiscope
An iOS application that analyzes facial emotion using Microsoft Cognitive Service's API and generates a stream of GIFs based on it. Created with Caitlin Stanton, Joyce Vandrost, Mendy Wu, and Nina Eisenberg during the summer of 2016.

# Description
Have you ever felt some emotion, but not known what content you can look at to help you with that emotion? Look no further than emotiscope. emotiscope is an iOS app that asks users "How you doin'?" and recommends content based on the answer. Users open the app and determine their emotion, either by choosing it manually or taking a photo of your face and putting it through the Alamofire API to determine the emotion based on dozens of points on your face. This emotion is passed into the GIPHY API, which then displays GIFs tagged with that emotion. These GIFs are able to be swiped through by the user.

In the future, we'd like to expand the types of content recommended, including music from Spotify and videos from YouTube. In addition, we'd like to incorporate a machine-learning algorithm to recommend content based not only on the user's current emotion, but their preference for certain types of content (i.e.cat GIFs, rock music) and their previous actions (i.e. they like listening to happy music when they're feeling sad).
