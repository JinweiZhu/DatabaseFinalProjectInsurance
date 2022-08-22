thisYear=read.csv("/Users/waynezhu/Downloads/Covid-19/csse_covid_19_data/csse_covid_19_daily_reports_us/08-18-2022.csv")
lastYear=read.csv("/Users/waynezhu/Downloads/Covid-19/csse_covid_19_data/csse_covid_19_daily_reports_us/08-18-2021.csv")
#Script that checks if there is any correlation between state test rate and state case rate.
#Right now, there are none.
testVsCase=lm(thisYear$Incident_Rate~thisYear$Testing_Rate)
abline(plot(testVsCase))
plot(thisYear$Testing_Rate,thisYear$Incident_Rate)
summary(testVsCase)
anova(testVsCase)

conciseThisYear=data.frame(thisYear$Province_State, thisYear$Incident_Rate)
conciseLastYear=data.frame(lastYear$Province_State, lastYear$Incident_Rate)

#Multiply by 3 and divided by 100,000 to get the closest to real probability.
StateCovidInfo=data.frame(thisYear$Province_State,3*(conciseThisYear$thisYear.Incident_Rate-conciseLastYear$lastYear.Incident_Rate)/100000)

colnames(StateCovidInfo)=c("StateName", "CovidProbabilityPerPerson")
ProductPlan=data.frame(matrix(ncol=4, nrow=0))

for (row in 1:nrow(StateCovidInfo)){
  lowPricePlan=c(1,StateCovidInfo[row, 1],round(1.1*StateCovidInfo[row,2]*200),200)
  middlePricePlan=c(2,StateCovidInfo[row, 1],round(1.1*StateCovidInfo[row,2]*500),500)
  highPricePlan=c(3,StateCovidInfo[row, 1],round(1.1*StateCovidInfo[row,2]*1000),1000)
  ProductPlan=rbind(ProductPlan,lowPricePlan,middlePricePlan,highPricePlan)
}
colnames(ProductPlan)=c("ProductPlanId", "StateName","NonDiscountPremiumPerPerson", "PayOutPerCovidCase")