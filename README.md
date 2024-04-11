YOUTUBE LINK: 


# Database file
The tables I decided to create, alongside the first appearance of 
notable features of SQL I implemented within them:
- Patients
    - Primary keys
    - Auto increment fields
    - Enums
    - Unsigned integers
    - Not null constraints
- Staff
    - VARBINARY (Encrypted license numbers via AES_ENCRYPT)
    - ENUMs
    - TINYINT
- Dental Reports
    - Default values
    - Foreign keys
    - Timestamps
    - Storing JPEGs in BLOBs
- Appointments
    - All major features of this table already mentioned
- Billing
    - Sets

# Queries
My queries.php file contains **four** queries:
- Displaying bill amounts for patients, splitting name into first and last using SUBSTRING_INDEX(). Also displays patient ID, shortened to last digit with SUBSTR()
- List of appointments, inner joined with patients and staff using patient ID = appointment patient ID, and staff ID = appointment staff ID, ordered by appointment datetime.
- List of Dental Reports, inner joined with staff to display name of staff member who filed report, alongside outputting xray_image Blobs using Base64 encoding, outputting into an <img> tag.
- Table utilizing a left join, showing patients, with dental report data and the associated staff name alongside.
