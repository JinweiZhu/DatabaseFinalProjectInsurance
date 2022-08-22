CREATE DATABASE Covid_insurance;
USE Covid_insurance;

CREATE TABLE `Customer` (
  `CustSSN` varchar(255) PRIMARY KEY,
  `CustLastName` varchar(255),
  `CustFirstName` varchar(255),
  `CustMiddleInitial` varchar(255),
  `CustDOB` date,
  `CustEmail` varchar(255),
  `GroupAccountId` varchar(255),
  `CustAddress1` varchar(255),
  `CustAddress2` varchar(255),
  `CustCity` varchar(255),
  `CustState` varchar(255),
  `CustZip` integer
);

CREATE TABLE `Claim` (
  `ClaimNumber` varchar(255) PRIMARY KEY,
  `CustSSN` varchar(255),
  `ClaimAmount` integer,
  `ProductPlanid` varchar(255),
  `SettlementDueDate` date,
  `DateReceived` date,
  `ProcessedDate` date,
  `Verified` boolean
);

CREATE TABLE `Payment` (
  `PaymentId` varchar(255) PRIMARY KEY,
  `ClaimNumber` varchar(255),
  `BankAccountNumber` varchar(255),
  `DueDate` date,
  `PaidDate` date
);

CREATE TABLE `IndividualOrGroupAccount` (
  `AccountId` varchar(255) PRIMARY KEY,
  `GroupAddress1` varchar(255),
  `GroupAddress2` varchar(255),
  `GroupCity` varchar(255),
  `ProductPlanId` varchar(255),
  `GroupState` varchar(255),
  `GroupZip` varchar(255),
  `GroupDiscount` float,
  `NumberOfMembers` integer,
  `ActualPremiumPerPerson` integer,
  `PlanStartDate` date,
  `PlanEndDate` date,
  `AnnualPremiumPaid` varchar(255)
);

CREATE TABLE `ProductPlan` (
  `ProductPlanId` varchar(255),
  `StateName` varchar(255),
  `NonDiscountPremiumPerPerson` integer,
  `PayOutPerCovidCase` integer,
  PRIMARY KEY (`ProductPlanId`, `StateName`)
);

CREATE TABLE `StateCovidInfo` (
  `StateName` varchar(255) PRIMARY KEY,
  `CovidProbabilityPerPerson` float
);

ALTER TABLE `Claim` ADD FOREIGN KEY (`CustSSN`) REFERENCES `Customer` (`CustSSN`);

ALTER TABLE `Claim` ADD FOREIGN KEY (`ProductPlanid`) REFERENCES `ProductPlan` (`ProductPlanId`);

ALTER TABLE `Payment` ADD FOREIGN KEY (`ClaimNumber`) REFERENCES `Claim` (`ClaimNumber`);

ALTER TABLE `Customer` ADD FOREIGN KEY (`GroupAccountId`) REFERENCES `IndividualOrGroupAccount` (`AccountId`);

ALTER TABLE `IndividualOrGroupAccount` ADD FOREIGN KEY (`ProductPlanId`, `GroupState`) REFERENCES `ProductPlan` (`ProductPlanId`, `StateName`);

ALTER TABLE `ProductPlan` ADD FOREIGN KEY (`StateName`) REFERENCES `StateCovidInfo` (`StateName`);

ALTER TABLE `IndividualOrGroupAccount` DROP COLUMN `GroupDiscount`;

ALTER TABLE `IndividualOrGroupAccount` DROP COLUMN `AnnualPremiumPaid`;

DESCRIBE Covid_insurance.StateCovidInfo;

SELECT * FROM Covid_insurance.StateCovidInfo;

SELECT * FROM Covid_insurance.ProductPlan;

SELECT * FROM Covid_insurance.IndividualOrGroupAccount;
SET SQL_SAFE_UPDATES = 0;
START TRANSACTION;

Update Covid_insurance.IndividualOrGroupAccount AS I
SET I.ActualPremiumPerPerson = (SELECT NonDiscountPremiumPerPerson
								FROM Covid_insurance.ProductPlan AS P
                                Where I.GroupState=P.StateName
                                AND I.ProductPlanId=P.ProductPlanid) * 
                                ( SELECT IF (I.NumberOfMembers>=10000,0.93,
												IF (I.NumberOfMembers>=1000,0.95,
														IF (I.NumberOfMembers>=100,0.97,
															IF (I.NumberOfMembers>=10,0.99,1))  ) ) 
                                )

COMMIT;


