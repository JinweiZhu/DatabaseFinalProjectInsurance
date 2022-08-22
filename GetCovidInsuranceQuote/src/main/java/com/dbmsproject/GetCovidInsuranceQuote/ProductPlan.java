package com.dbmsproject.GetCovidInsuranceQuote;

public class ProductPlan {
    private int productPlanId;
    private String stateName;
    private int nonDiscountPremiumPerPerson;
    private int payoutPerCovidCase;

    public ProductPlan(int productPlanId, String stateName, int nonDiscountPremiumPerPerson, int payoutPerCovidCase) {
        this.productPlanId = productPlanId;
        this.stateName = stateName;
        this.nonDiscountPremiumPerPerson = nonDiscountPremiumPerPerson;
        this.payoutPerCovidCase = payoutPerCovidCase;
    }

    public int getProductPlanId() {
        return productPlanId;
    }

    public void setProductPlanId(int productPlanId) {
        this.productPlanId = productPlanId;
    }

    public String getStateName() {
        return stateName;
    }

    public void setStateName(String stateName) {
        this.stateName = stateName;
    }

    public int getNonDiscountPremiumPerPerson() {
        return nonDiscountPremiumPerPerson;
    }

    public void setNonDiscountPremiumPerPerson(int nonDiscountPremiumPerPerson) {
        this.nonDiscountPremiumPerPerson = nonDiscountPremiumPerPerson;
    }

    public int getPayoutPerCovidCase() {
        return payoutPerCovidCase;
    }

    public void setPayoutPerCovidCase(int payoutPerCovidCase) {
        this.payoutPerCovidCase = payoutPerCovidCase;
    }
}
