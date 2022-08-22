CREATE TABLE `Customer` (
  `CustSSN` varchar(255) PRIMARY KEY,
  `CustLastName` varchar(255),
  `CustFirstName` varchar(255),
  `CustMiddleInitial` varchar(255),
  `CustDOB` date,
  `CustMailAddress` varchar(255),
  `GroupAccountId` varchar(255)
);

CREATE TABLE `CustomerAddress` (
  `CustSSN` varchar(255),
  `CustAddress1` varchar(255),
  `CustAddress2` varchar(255),
  `CustCity` varchar(255),
  `CustState` varchar(255),
  `CustZip` integer,
  PRIMARY KEY (`CustSSN`, `CustAddress2`, `CustAddress1`)
);

CREATE TABLE `Claim` (
  `ClaimNumber` varchar(255) PRIMARY KEY,
  `CustSSN` varchar(255),
  `ClaimAmount` varchar(255),
  `HealthProviderInstituition` varchar(255),
  `InsuranceDiscountedActualAmount` varchar(255),
  `InsurancePaid` varchar(255),
  `MembersResponsibility` varchar(255),
  `ProductPlanid` varchar(255),
  `SettlementDueDate` date,
  `DateReceived` date,
  `ProcessedDate` date
);

CREATE TABLE `Payment` (
  `InvoiceNumber` varchar(255) PRIMARY KEY,
  `ClaimNumber` varchar(255),
  `BankAccountNumber` varchar(255),
  `MembersResponsibility` varchar(255),
  `DueDate` date,
  `PaidDate` date
);

CREATE TABLE `GroupAccount` (
  `AccountId` varchar(255) PRIMARY KEY,
  `GroupAddress1` varchar(255),
  `GroupAddress2` varchar(255),
  `GroupCity` varchar(255),
  `GroupState` varchar(255),
  `GroupZip` varchar(255),
  `NumberOfMembers` integer,
  `PlanStartDate` date,
  `PlanEndDate` date,
  `AnnualPremiumPaid` varchar(255),
  `ProductPlanId` varchar(255)
);

CREATE TABLE `ProductPlan` (
  `ProductPlanId` varchar(255) PRIMARY KEY,
  `PlanName` varchar(255),
  `LineOfBusiness` varchar(255),
  `Description` varchar(255),
  `Benefit` varchar(255),
  `AnnualPremiumQuote` varchar(255),
  `RateBookLocationCode` integer
);

CREATE TABLE `CustomerAddress_Customer` (
  `CustomerAddress_CustSSN` varchar NOT NULL,
  `Customer_CustSSN` varchar NOT NULL,
  PRIMARY KEY (`CustomerAddress_CustSSN`, `Customer_CustSSN`)
);

ALTER TABLE `CustomerAddress_Customer` ADD FOREIGN KEY (`CustomerAddress_CustSSN`) REFERENCES `CustomerAddress` (`CustSSN`);

ALTER TABLE `CustomerAddress_Customer` ADD FOREIGN KEY (`Customer_CustSSN`) REFERENCES `Customer` (`CustSSN`);


ALTER TABLE `Claim` ADD FOREIGN KEY (`CustSSN`) REFERENCES `Customer` (`CustSSN`);

ALTER TABLE `Claim` ADD FOREIGN KEY (`MembersResponsibility`) REFERENCES `Payment` (`MembersResponsibility`);

ALTER TABLE `Claim` ADD FOREIGN KEY (`ProductPlanid`) REFERENCES `ProductPlan` (`ProductPlanId`);

ALTER TABLE `Payment` ADD FOREIGN KEY (`ClaimNumber`) REFERENCES `Claim` (`ClaimNumber`);

ALTER TABLE `Customer` ADD FOREIGN KEY (`GroupAccountId`) REFERENCES `GroupAccount` (`AccountId`);

ALTER TABLE `GroupAccount` ADD FOREIGN KEY (`ProductPlanId`) REFERENCES `ProductPlan` (`ProductPlanId`);
