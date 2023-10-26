# Dogs App

This app uses the Stacked state management architecture.
The folders are organized as follows, and each folder has its own README.md file:

 - lib
    - api
       - common
       - endpoint specific folders (dogs_api, users_api)
    - app
    - data_model
       - type specific folders (dogs, breeds, user)
    - enums
    - exceptions
    - extenstions
    - mixins
    - services
    - ui
       - bottom_sheets if any
       - dialogs if any
       - common
       - views
          - page specific folders (dogs, show_full_image, home, login, startup)
    - utils



## Requirements

The following requirements must be installed in your environment before continuing:

- Languages & Framework: [Flutter (incl. Dart)](https://flutter.dev/docs/get-started/install)
- Emulation: [Android SDK (Android Studio)](https://developer.android.com/studio/install)
- IDE: [Visual Studio Code](https://code.visualstudio.com/download)
- Source Control: [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- CLI: [GitHub](https://cli.github.com/)


To get started all you have to do is run the following commands.

```
flutter pub upgrade
flutter pub run build_runner build --delete-conflicting-outputs
```



### **Running locally using Emulation**

To run the app locally an emulator or simulator is required.


1. Open your emulator or simulator 
2. Select the Virtual Device located at bottom right corner of your VS-Code
3. Navigate to the `Run` view
4. Select Run Without Debugging 




### **DOGs GET API Logic  **

```
Future<Dogs> getDogs(
    String breed, {
    bool isRandom = false,
    String subBreed = '',
  }) async {  
    String randomPath = isRandom ? randomSuffix : '';
    String commonUrl = byBreedUrl +
        '/$breed/$subBreed/images/$randomPath'.replaceAll('//', '/');
    return await apiClient.get<Dogs>(
      commonUrl,
      key: jsonKey,
      modelKey: 'imageUrls',
    );
  }```

/* 
     **
      Because all API calls return dogs based on the given query parameters,
      we can construct a single common URL to get dogs. 
      The pattern is baseUrl + '/breed/subBreed/images/random'.

      Let's see some scenarios:

    1. If the sub-breed is empty and the fetch type is all, we will have:
      commonUrl = baseUrl/breed//images//
      This is an invalid URL, so we need to replace the double slashes (//) with a single slash (/).

      commonUrl = baseUrl/breed//images//.replaceAll('//', '/');
      This gives us the URL baseUrl/breed/images/, which returns a list of images for the specified breed.

    2. If the sub-breed is empty and the fetch type is random, we will have:
      commonUrl = baseUrl//breed/images/random/
      This is also an invalid URL, so we need to replace the double slashes (//) with a single slash (/).

      commonUrl = baseUrl/breed//images/random/50.replaceAll('//', '/');
      This gives us the URL baseUrl/breed/images/random/50, which returns a random image for the specified breed.

    3. If the sub-breed is not empty and the fetch type is random, we will have:
      commonUrl = baseUrl/breed/subBreed/images/random/
      This is a valid URL, so we don't need to make any changes.

      commonUrl = baseUrl/breed/subBreed/images/random/50
      This URL returns a random image for the specified breed and sub-breed.

    4.  If the sub-breed is not empty and the fetch type is all, we will have:
      commonUrl = baseUrl/breed/subBreed/images//
      This is an invalid URL, so we need to replace the double slashes (//) with a single slash (/).

      commonUrl = baseUrl/breed/subBreed/images//.replaceAll('//', '/');
      This gives us the URL baseUrl/breed/subBreed/images/, which returns a list of images for the specified breed and sub-breed.

      The key and modelKey parameters are used to extract and customize JSON responses. For example, if the JSON data is like this:

      {
          "message": [
              "https://images.dog.ceo/breeds/labrador/n02099712_5657.jpg",
              "https://images.dog.ceo/breeds/greyhound-italian/n02091032_9131.jpg",
              "https://images.dog.ceo/breeds/saluki/n02091831_7957.jpg"
          ],
          "status": "success"
      }

      We can extract the image URLs using the following code:

      key = "message"
      rawData = {
          "message": [
              "https://images.dog.ceo/breeds/labrador/n02099712_5657.jpg",
              "https://images.dog.ceo/breeds/greyhound-italian/n02091032_9131.jpg",
              "https://images.dog.ceo/breeds/saluki/n02091831_7957.jpg"
          ],
          "status": "success"
      }

      parsedData = rawData[key]

      This will give us the following list of image URLs:

 
      [
         "https://images.dog.ceo/breeds/labrador/n02099712_5657.jpg",
         "https://images.dog.ceo/breeds/greyhound-italian/n02091032_9131.jpg",
          "https://images.dog.ceo/breeds/saluki/n02091831_7957.jpg"
        ]

      We can then pass this list to the Breeds.fromJson() method to create a Breeds object

  */



