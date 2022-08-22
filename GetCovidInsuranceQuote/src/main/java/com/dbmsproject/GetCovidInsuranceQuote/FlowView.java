package com.dbmsproject.GetCovidInsuranceQuote;

import com.vaadin.flow.component.Text;
import com.vaadin.flow.component.button.Button;
import com.vaadin.flow.component.combobox.ComboBox;
import com.vaadin.flow.component.formlayout.FormLayout;
import com.vaadin.flow.component.grid.Grid;
import com.vaadin.flow.component.orderedlayout.VerticalLayout;
import com.vaadin.flow.component.radiobutton.RadioButtonGroup;
import com.vaadin.flow.component.textfield.TextField;
import com.vaadin.flow.router.PageTitle;
import com.vaadin.flow.router.Route;

import com.vaadin.ui.ListSelect;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

//@SpringUI
@PageTitle("Flow")
@Route("")
public class FlowView extends VerticalLayout{
    @Autowired
    private ApplicationToDatabase service;

    private ProductPlan productPlan;

   // private Binder<ProductPlan> binder= new Binder<>(ProductPlan.class);

    private ComboBox<String> stateName = new ComboBox<>("The US state or territory that all members belong to");
    ArrayList<String> states=new ArrayList<>(Arrays.asList("Wyoming", "Wisconsin","West Virginia","Washington","Virginia", "Virgin Islands","Vermont","Utah", "Texas",
            "Tennessee", "South Dakota", "South Carolina", "Rhode Island", "Puerto Rico", "Pennsylvania", "Oregon", "Oklahoma",
            "Ohio", "Northern Mariana Islands", "North Dakota", "North Carolina", "New York", "New Mexico", "New Jersey", "New Hampshire",
            "Nevada", "Nebraska", "Montana", "Missouri", "Mississippi", "Minnesota", "Michigan", "Massachusetts", "Maryland", "Maine",
            "Louisiana", "Kentucky", "Kansas", "Iowa", "Indiana", "Illinois", "Idaho", "Hawaii", "Guam", "Georgia", "Florida",
            "District of Columbia", "Delaware", "Connecticut", "Colorado", "California", "Arkansas", "Arizona", "American Samoa",
            "Alaska", "Alabama"));

    private RadioButtonGroup<Integer> payout = new RadioButtonGroup<>("How much do you expect the payout per covid case to be?");


    private TextField numOfMembers=new TextField("Number of plan members (1 to 10000)");

    private Button getQuoteButton = new Button("Get Quote", e -> getQuoteUI());

    private TextField perPersonPremiumTextField=new TextField("Premium Per Person is $:");

    private TextField overallPremiumTextField=new TextField("Overall Premium is $:");
    public FlowView(ApplicationToDatabase service){
        add("Welcome to the Covid Insurance offered by Zhu's Gambling Inc.\n");
        add("You heard it right. If you get sick during the next policy year, send us pcr test proof, we pay you.\n");
        add("Exactly how sick you will be and how to get better is none of our business. Have fun. :)\n");
        payout.setItems(200,500,1000);
        add(new Form());
        add(perPersonPremiumTextField);
        add(overallPremiumTextField);
    }

    class Form extends FormLayout {

        Form(){
            stateName.setItems(states);
            add(stateName, numOfMembers, payout, getQuoteButton);

        }
    }
    private void getQuoteUI(){
        int perPersonPremium=service.getQuote(stateName.getValue(), payout.getValue(), Integer.parseInt(numOfMembers.getValue()));
        perPersonPremiumTextField.setValue(Integer.toString(perPersonPremium));
        overallPremiumTextField.setValue(Integer.toString(perPersonPremium*Integer.parseInt(numOfMembers.getValue())));

    }

}
