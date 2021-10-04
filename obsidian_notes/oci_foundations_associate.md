#### Setting up your Tenancy

Tenancy(account)/Root Compartment

Users (Tenancy Admin) > Groups (Administrators) > Policies (Allow group adminstrators manage all resources in tenancy)

**Best practice: Create dedicated compartments to isolate resources to provide the right level of access to users for those resources.
Don't put all your cloud resources in the root compartment**

Users Tenancy Admin must create users with Service Admins into groups with policies control for Storage-Admin, Network-admin...

**Don't use the Tenancy Admin account for day-to-day operations and enforce the use of Multi-Factor Authentication (MFA)**

Obs: There is two authentication app supported for MFA, Oracle Mobile Authentication and Google Authenticator.

#### Physical Architecture

Region is a localized geographic area comprising of one or more availability domains. Availability means are one or more fault tolerant data centers located within a region, but connected to each other by a low latency, high bandwidth network. Fault domains is a grouping of hardware and infrastructure within an availability domain to provide anti-affinity. So think about these as logical data centers.

First thing is choosing a region, you choose a region closest to your users for lowest latency and highest performance. So that's a key criteria.

The second key criteria is data residency and compliance requirements. Many countries have strict data residency requirements, and you have to comply to them. And so you choose a region based on these compliance requirements.

The third key criteria is service availability. New cloud services are made available based on regional demand at times, regulatory compliance reasons, and resource availability, and several other factors. Keep these three criterias in mind when choosing a region.

Availability domains are isolated from each other, fault tolerant, and very unlikely to fail simultaneously. Because availability domains do not share physical infrastructure, such as power or cooling or the internal network, a failure that impacts one availability domain is unlikely to impact the availability of others. Think about each availability domain has three fault domains. So think about fault domains as logical data centers within availability domain.

A fault domain is a grouping of hardware and infrastructure within an availability domain. Each availability domain contains three fault domains. Fault domains provide anti-affinity: they let you distribute your instances so that the instances are not on the same physical hardware within a single availability domain. A hardware failure or Compute hardware maintenance event that affects one fault domain does not affect instances in other fault domains. In addition, the physical hardware in a fault domain has independent and redundant power supplies, which prevents a failure in the power supply hardware within one fault domain from affecting other fault domains.

So the idea is you put the resources in different fault domains, and they don't share a single point of hardware failure, like physical servers, physical rack, type of rack switches, a power distribution unit. You can get high availability by leveraging fault domains.

So you have an application tier which is replicated across fault domains. And then you have a database, which is also replicated across fault domains.

Why do you do that? Well, it gives you that extra layer of redundancy. So something happens to a fault domain, your application is still up and running.

Now, to take it to the next step, you could replicate the same design in another availability domain. So you could have two copies of your application running. And you can have two copies of your database running.

Now, one thing which will come up is how do you make sure your data is synchronized between these copies? And so you could use various technologies like Oracle Data Guard to make sure that your primary and standby-- the data is kept in sync here. And so that-- you can design your application-- your architectures like these to avoid single points of failure. Even for regions where we have a single availability domain, you could still leverage fault domain construct to achieve high availability and avoid single points of failure.

Fault domain provide protection against failure within an availability domain.

Availability domain themselves provide protection from entire availability domain failures, particularly in a multi-AD region. And then you have this concept of region pair, where in every country we operate or most of the countries we operate, we have at least two data centers. So you could use the second data center for disaster recovery or backup or it also helps you with-- to comply with data residency and compliance requirements. And then not only this, we also have SLAs on availability, management, and performance.