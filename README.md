# Leasing Office

## Project Description

An application that is used to manage all the related functionalities of the leasing management company.

## Technologies Used

* Salesforce - version 49.0
* Apex - version 33.0
* SOQL - version 52.0
* xml - version 1.0
* Aura - version 52.0

## Features

List of features ready and TODOs for future development
* Account Management- Residents can view their information and edit some information if it changes.
* Repair Order - Residents can view the status of their repair order and make new repair orders.
* Prospective Residents - Allows prospective residents to make a new offer on a house to lease.
* Partnership Program - Allows residents or their friends to submit properties they own to be managed by the leasing company.
* Manage Campaigns- Allows internal users to make new campaigns and manage their existing campaigns

To-do list:
 * Enable community members to log in and view their information
 * Enable creating leads and assigning them to campaigns in the site
 * Ensure stylistic choices match


## Getting Started
   
Steps to port
  1. Create new playground
  2. Authorize Visual Studio Code into the playground created in step 1
  3. Pull git hub repository into playground created in step 1 
  4. Comment out Network CustomSite and ExperienceBuilder associated code from package.xml
  5. Deploy to org fixing each issue as run into.
  6. Create Experience cloud Site 
  7. Colors: Nav Overlay color `rgb(159, 159, 159)`, Nav Border Divider Color `rgba(0, 15, 89, 0.8)`, Nav Border Color, `rgb(130, 117, 102)`, and Nav link color `rgb(188, 227, 243)`
  8. Add pages to components `CaseComp`, `AddCaseComp`, `Account_Management`, `Partnership_Program`, `CampaignComp`, and `AddCampaignComp` to sitepages.
  9. Add the pages to navigation menue
  10. Add logo in Theme Images
    
   
## Usage
 > Set up Leasing Office to be default application, add tab for Campaigns. Add desired items to each page layout. 


## Contributors

> Nathan Tellez
> Laurent Sanou
> Saief Sayed
> James Patton

## License

All rights reserved 2021 
