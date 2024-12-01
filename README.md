## App Concept: Film Roll Photo Journal
### 1. Overview
This app is a Film Roll Organizer and Photo Journal designed for analog photography enthusiasts. It allows users to catalog their film rolls, organize photos within each roll, and capture details specific to film photography. Users can also create subalbums for each roll, providing a flexible way to manage multiple themes or sessions within the same roll.
________________________________________
### 2. Core Features
1.	Roll Management
o	Users can create and manage multiple film rolls.
o	For each roll, they can specify the roll's type (e.g., color, black and white), film brand, ISO rating, and capacity (e.g., 24 or 36 exposures).
o	Rolls have a status indicator (e.g., "In Progress," "Developed," "Scanned").
2.	Photo Management within Rolls
o	Each roll contains a list of photos, where users can add details such as location, date, time, and notes.
o	Each photo can store camera settings (e.g., aperture, shutter speed) and additional metadata relevant to film photography.
3.	Subalbums within Rolls
o	Users can create multiple subalbums within each roll, grouping photos by themes, sessions, or locations.
o	Each subalbum can have its own title and description, allowing users to structure their photos by context.
o	Subalbums provide an easy way to organize different parts of a roll dedicated to separate photography projects or experiments.
4.	Detailed Metadata
o	Roll Metadata: Users can specify film type, capacity, ISO, brand, and other roll details.
o	Photo Metadata: Location, date/time, exposure settings, and any specific notes about the photo (e.g., lighting conditions, composition notes).
o	Subalbum Metadata: Title and description for each subalbum to give context to the photo group.
5.	User-friendly Navigation
o	A dashboard or home screen displays all rolls, showing quick details like roll type, number of photos, and status.
o	Tapping on a roll opens a detailed view where users can see photos, subalbums, and roll metadata.
o	Within each roll, users can tap into specific subalbums to see the photos grouped by that theme or session.
6.	Offline and Sync Capabilities
o	The app provides offline functionality to allow users to add rolls and photos without internet.
o	When online, users can sync data with a cloud service, ensuring they have a backup of their records.
________________________________________
### 3. Detailed Functional Specifications
Entities
1.	Film Roll:
o	Fields:
	Roll ID: Unique identifier for the roll.
	Roll Name: Name of the roll.
	Type: Type of film (e.g., color, black and white).
	ISO: ISO rating of the roll.
	Brand: Brand of the film (e.g., Kodak, Fujifilm).
	Capacity: Total exposures on the roll (e.g., 24, 36).
	Status: Status indicator (e.g., "In Progress," "Developed," "Scanned").
	Date Created: The date the roll was first used.
2.	Subalbum:
o	Fields:
	Subalbum ID: Unique identifier for the subalbum.
	Title: Title of the subalbum (e.g., "Beach Trip," "Cityscapes").
	Description: A brief description of the theme or purpose of the subalbum.
3.	Photo:
o	Fields:
	Photo ID: Unique identifier for each photo.
	Location: Geotag or location name where the photo was taken.
	Date and Time: The date and time the photo was taken.
	Exposure Settings: Camera settings for the photo (aperture, shutter speed, etc.).
	Notes: Additional notes about the photo, like lighting or mood.
	Subalbum ID: Reference to the subalbum this photo belongs to (if applicable).
CRUD Operations
1.	Film Roll CRUD Operations:
o	Create: Add a new film roll with metadata (type, ISO, brand, capacity, status).
o	Read: View all rolls in a list or grid view, with basic details displayed.
o	Update: Edit details of a roll, like status or capacity.
o	Delete: Delete a roll, which removes all associated subalbums and photos.
2.	Subalbum CRUD Operations:
o	Create: Add a subalbum within a roll, with a title and description.
o	Read: View all subalbums within a roll to see themes or sessions.
o	Update: Edit the title or description of a subalbum.
o	Delete: Delete a subalbum, which removes all photos associated with it.
3.	Photo CRUD Operations:
o	Create: Add a photo to a roll or subalbum, with location, date, exposure settings, and notes.
o	Read: View all photos in a roll or specific subalbum.
o	Update: Edit details of a photo, such as location or exposure settings.
o	Delete: Delete a specific photo from a roll or subalbum.
________________________________________
### 4. Data Persistence and Sync
•	Local Database: Use a local Room database in Kotlin to store all rolls, subalbums, and photos offline.
•	Cloud Sync: Sync functionality to back up rolls and photos to a cloud service (e.g., Firebase, AWS) when the device is connected.
•	Offline Functionality: CRUD operations are available offline and sync automatically when connectivity is restored.
________________________________________
### 5. Offline Access and Synchronization
•	Offline Scenarios:
o	Create: Users can create rolls, subalbums, and photos offline; data is saved locally and syncs to the cloud once online.
o	Read: Full access to locally stored rolls and photos without an internet connection.
o	Update: Changes made offline are saved locally and updated in the cloud once online.
o	Delete: Deletions are recorded offline and synchronized with the cloud when connectivity is available.
________________________________________
### 6. User Interface (UI) Mockups
To visualize the app’s layout, here are some suggested screens to design in Figma or Sketch:
1.	Home Screen (Film Roll List):
o	Displays a list of film rolls with quick details like type, ISO, status, and the number of photos.
o	Options to add a new roll or filter rolls by status.
2.	Roll Details Screen:
o	Shows details of the selected roll, including type, ISO, brand, and status.
o	Displays a list of subalbums and standalone photos within the roll.
o	Options to add a new subalbum or photo.
3.	Subalbum Screen:
o	Displays photos grouped under the selected subalbum, with metadata shown under each photo.
o	Option to add a new photo to the subalbum.
4.	Photo Details Screen:
o	Shows detailed information for a selected photo, including location, date, exposure settings, and notes.
o	Options to edit photo details or delete the photo.
________________________________________
###Summary
The Film Roll Photo Journal App is designed for photographers to organize and document their analog photography process. By supporting film roll organization, subalbums, and rich metadata for each photo, it offers a structured yet flexible approach to film photography. With offline functionality and cloud sync, the app ensures data is secure and accessible anytime, making it a valuable tool for film photography enthusiasts.
Read operation is implemented in a list
A recycler view is used linked to a view model using a live view object. Or the activity/fragment is marshaling only the affected object/operation. No rebuild of the list/adapter or activity/fragment.

