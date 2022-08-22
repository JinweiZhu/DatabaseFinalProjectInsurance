package com.dbmsproject.GetCovidInsuranceQuote;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Component
public class ApplicationToDatabase {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public int getQuote(String state, int payout, int numMember){
        //Use primary index query to speed up.
        int productPlanId;
        if (payout==200) productPlanId=1;
        else if (payout==500) productPlanId=2;
        else productPlanId=3;
        ProductPlan productPlan= (jdbcTemplate.query(
                "SELECT * FROM ProductPlan WHERE StateName=? AND ProductPlanId=?",
                new Object[]{state, productPlanId},
                (rs, rowNum) -> new ProductPlan(rs.getInt("ProductPlanId"),
                rs.getString("StateName"),rs.getInt("NonDiscountPremiumPerPerson"),
                rs.getInt("PayOutPerCovidCase") ))).get(0);

        int nonDiscountedPayout=productPlan.getNonDiscountPremiumPerPerson();
        if (numMember>=10000) return (int) (nonDiscountedPayout*0.93);
        else if (numMember>=1000) return (int) (nonDiscountedPayout*0.95);
        else if (numMember>=100) return (int) (nonDiscountedPayout*0.97);
        else if (numMember>=10) return (int) (nonDiscountedPayout*0.99);
        else return nonDiscountedPayout;
    }
}
