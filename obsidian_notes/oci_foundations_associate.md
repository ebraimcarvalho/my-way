#### Setting up your Tenancy

Tenancy(account)/Root Compartment

Users (Tenancy Admin) > Groups (Administrators) > Policies (Allow group adminstrators manage all resources in tenancy)

**Best practice: Create dedicated compartments to isolate resources to provide the right level of access to users for those resources.
Don't put all your cloud resources in the root compartment**

Users Tenancy Admin must create users with Service Admins into groups with policies control for Storage-Admin, Network-admin...

**Don't use the Tenancy Admin account for day-to-day operations and enforce the use of Multi-Factor Authentication (MFA)**

Obs: There is two authentication app supported for MFA, Oracle Mobile Authentication and Google Authenticator.