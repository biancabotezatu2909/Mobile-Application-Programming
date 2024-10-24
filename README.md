## ProjectAR - Measuring App
### Project Idea

1. Short Description
This app is designed to assist users in calculating the surface area of objects, such as roofs or floors, 
and estimate the amount of material needed for the job. The app allows users to create multiple projects, 
each containing measurements of surfaces and the materials required. Users can either input the data manually 
or use their phone’s AR camera for automatic measurements. It aims to simplify tasks for construction professionals, 
particularly when measuring irregularly shaped surfaces.

2. Domain Details (Entities and Fields)
In this application, the main entity is the Project.
Each project contains fields that are saved and can be accessed later for calculation and analysis.
The key fields include:

-> Project Name: A user-defined name for the project.
-> Surface Area: The calculated area of the surface (e.g., in square meters).
-> Material Type: The type of material needed for the surface (e.g., tiles, metal sheets).
-> Material Quantity: The estimated amount of material required based on the surface area.
-> Measurement Method: Indicates whether the data was entered manually or via the AR camera.

3. CRUD Operations (Create, Read, Update, Delete)
The CRUD operations in the context of a Project involve the following:

Create: Users can add a new project by pressing the "+" button.
They must provide details like the project name, the material type,
and input surface area either manually or by using the AR camera.

Read: Users can view the details of an existing project by selecting it from the list on the main screen.
The surface area, material type, and quantity are displayed.

Update: Users can modify an existing project by changing the measurements or material type,
and the calculations will be updated accordingly.

Delete: Projects can be deleted from the list if they are no longer needed by clicking the trash bin button.

4. Persistence Details (Local DB and Server)
The app ensures that project data is stored both on the device (local database)
and on the server for easy access and backup. Here’s how the persistence works:

Create: When a new project is created, it is saved both locally and on the server.

Update: Any changes to a project (such as recalculated measurements) are reflected in both the local storage and on the server.

Delete: When a project is deleted, the data is removed from both the local database and the server, ensuring synchronization.


5. Details on what is happening when the device is offline.
1. Create
Scenario: The user attempts to create a new project while offline.
What Happens:
The new project data (project name, surface area, material type, etc.) is saved locally on the device in the app’s local database.
A sync operation is queued in the background. Once the device reconnects to the internet, the app will automatically push the
project data to the server, ensuring the new project is saved both locally and remotely.
The user can continue adding projects offline, but the app will display a notification or icon indicating the app is
offline and that syncing will occur later.
Example:

A user in a remote area adds a new project for measuring a roof, inputs the surface area and material details.
The project is saved locally, and as soon as internet access is available again, the project syncs with the server.

2. Read
Scenario: The user attempts to view existing projects while offline.
What Happens:
The app allows the user to access previously saved projects from the local database. Any project stored on the device before
going offline will be available.
If a project was created on another device or hasn’t yet synced to the local database, it won’t be accessible until the user
is back online.
Users can view all project details, such as surface measurements, material types, and quantities, as long as the data was
saved locally before going offline.
Example:

A user on a construction site without internet access can review all projects that were previously saved on
the device, including the details for surface area and materials. However, newly created or updated projects from other
devices cannot be accessed until online again.

3. Update
Scenario: The user attempts to modify a project while offline.
What Happens:
The user can edit existing project details, such as updating the surface area or changing the material type.
These changes are saved locally in the app’s database.
Similar to the Create operation, the changes are queued to sync once the device reconnects to the internet.
When back online, the updated information is automatically pushed to the server, ensuring all data remains consistent across devices.
The app may notify the user that the updates are pending sync with the server to avoid confusion.
Example:

While offline, a user modifies the surface measurement for a project stored locally. The updated measurement
is saved, and once back online, the server will receive the updated data.

4. Delete
Scenario: The user attempts to delete a project while offline.
What Happens:
The app allows the user to delete a project locally from the device’s database. The project will disappear from the list immediately.
A delete request is queued to sync with the server once the device reconnects to the internet. The project is permanently removed from
the server at that point, ensuring consistency between the local database and the server.
The user may receive a notification that the delete action is pending sync to ensure they understand that the project is still on the server temporarily.
Example:

The user deletes an unnecessary project while offline. The project is removed locally from their list, and once the app detects an
internet connection, the deletion is completed on the server.

