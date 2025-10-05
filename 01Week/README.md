# Class7EC2Script
Class7EC2Script

Screenshot: <img width="1440" height="900" alt="Screen Shot 2025-09-11 at 7 56 39 PM" src="https://github.com/user-attachments/assets/730d9b28-1b87-4c2d-ad30-63ecd2b68148" />

Configuration Instructions:

  1. Go into EC2 Dashboard
  
  2. Click on Launch Instance
  <img width="296" height="234" alt="Screen Shot 2025-09-11 at 8 14 13 PM" src="https://github.com/user-attachments/assets/7550dafe-eb76-48ab-b811-eb7dcb567dac" />
  
  3. Name your instance
  <img width="862" height="235" alt="Screen Shot 2025-09-11 at 8 16 48 PM" src="https://github.com/user-attachments/assets/1cbeee5a-0d2d-4ae6-8a22-eb928ba24d89" />
  
  4. Continue down to Key pair(login), and create new key pair
  <img width="845" height="215" alt="Screen Shot 2025-09-11 at 8 19 49 PM" src="https://github.com/user-attachments/assets/b70296c4-cc64-4a2d-97f1-c6c0c5de8984" />
  
  5. Name your Key pair, leave RSA and .pem selected, then Create your key pair
  <img width="599" height="575" alt="Screen Shot 2025-09-11 at 8 22 00 PM" src="https://github.com/user-attachments/assets/ec37d88f-cf3f-43a8-a4e2-c30362274df9" />
  
  6. Go down to Advanced Settings, go down to User Data, and paste userdata.txt
  <img width="638" height="464" alt="Screen Shot 2025-09-11 at 8 25 55 PM" src="https://github.com/user-attachments/assets/79714cc8-9914-47fd-a52f-95018684ff95" />
  
  7. Launch your instance!


Teardown Instructions

  1. Select your instance
  <img width="1198" height="161" alt="Screen Shot 2025-09-11 at 8 33 51 PM" src="https://github.com/user-attachments/assets/56bedac1-164f-4674-a3e4-c41c08e9f0f9" />

  2. Go to Instane State, select Terminate (delete) instance
  <img width="1196" height="336" alt="Screen Shot 2025-09-11 at 8 35 29 PM" src="https://github.com/user-attachments/assets/8dfd1248-c0e9-4136-91bb-3955dbfa5d1f" />

  3. Select Terminate (delete)
  <img width="193" height="52" alt="Screen Shot 2025-09-11 at 8 37 53 PM" src="https://github.com/user-attachments/assets/79f9b384-0b3d-4eff-ae05-25150874130f" />

  4. (Optional) You can delete the security group but you are not charged for it



  
