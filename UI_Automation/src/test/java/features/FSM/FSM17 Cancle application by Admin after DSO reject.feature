Feature: FSM17 E2E Flow via Employee creator
	
@fsm17
Scenario: Employee Editor Create Collector and Editor Flow
	Given Open new web url "employee"
	When Select the language
	Then Enter eGov username as "CEC"
  And Enter eGov password
  And Select eGov city field
  And Select City
  And Click on Continue to proceed further
  And Click on FSM
  And Click on Inbox
  And Click on New Application
  And Select Application Channel
  And Enter Application Name
  And Enter Mobile Number
  And Select Property "Residential"
  And Select Property SubType "ResidentialSubType"
  And Enter Pincode Number
  And Select Locality Mohalla "Mohalla"
  Then Update Name of the Slum
  And Enter Street House and Landmark
  When Select Sanitation Type "Sanitation_Type1"
  Then Enter Length Breadth and Depth
  And Select Vehicle Type "Vehicle_Type"
  And Click Submit Application button
  Then Check Application Number
  And Click Collect Payment button
  When Select Card and Enter Details
  And Click on Genrate Receipt
  Then Check Receipt number
  And Click on Home Option Top
  And Click on Inbox
  When Enter Application Number
  Then Click On Search
  And Click on Application Number
  When Click On Take Action button
  And Click on Assign DSO
  And Click On DSO from dropdown
  Then Click On Assign button
  And Employee Logout and Close
  
 @fsm17
Scenario: DSO Assign Vehicle Number
	Given Open new web url "citizen"
	When Click On DSO Login
	And Feed mobile number as "dsonumber"
	And Feed Pin code
	Then Click On DSO Dashboard
	And Click On DSO Inbox
  When Enter Application Number
  Then Click On Search
  And Click on Application Number
  When Click On Take Action button
  Then Click On Assign Vehicle
  And Click On Vehicle Number from dropdown
  Then Click On Assign button
  And Logout from eGov and Close

@fsm17
Scenario: DSO Reject the Application
	Given Open new web url "citizen"
	When Click On DSO Login
	And Feed mobile number as "dsonumber"
	And Feed Pin code
	Then Click On DSO Dashboard
	And Click On DSO Inbox
  When Enter Application Number
  Then Click On Search
  And Click on Application Number
  When Click On Take Action button
  Then Click On Decline Request
  And Choose Decline Reason "reason1"
  And Enter Comment
  Then Click On Decline Request button
  And Logout from eGov and Close
 
   
 @fsm17
Scenario: Admin Reject the Application
	Given Open new web url "employee"
	When Select the language
	Then Enter eGov username as "ADMIN"
  And Enter eGov password
  And Select eGov city field
  And Select City
  And Click on Continue to proceed further
  And Click on FSM
  And Click on Inbox
  When Select Assign to all
  When Enter Application Number
  Then Click On Search
  And Select Status "status2"
  And Click on Application Number
  When Click On Take Action button
  Then Click On Cancel Request
  And Select Reason "adminReason3"
  And Enter Comment
  Then Click On Decline Request button
  And Employee Logout and Close
  