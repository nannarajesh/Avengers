//
//  TagConstants.swift
//  ESI
//
//  Created by Administrator on 28/11/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

import UIKit

class TagConstants: NSObject {
    
    enum NEW_ADMISSION : Int{
        case TAG_TBL_HISTORY_ASSESSMENT = 532;
        case TAG_TBL_ALLERGIES = 533;
        case TAG_TBL_MEDICATIONS = 534;
        case TAG_TBL_CARE_PLANNING = 535;
        case TAG_TBL_PREPOST_MEDICATION_GIVEN = 536;
        case TAG_TBL_THERAPY = 537;
        case TAG_TBL_THERAPY_HEMOPHILIA_DETAILS = 538;
    }

    enum INITIAL_HEMOPHILIA : Int{
        case TAG_COAGULATION_HISTORY = 632;
        case TAG_BLEEDS_HISTORY = 633;
        case TAG_GENERAL_MEDICAL = 634;
        case TAG_INFUSION_HISTORY = 635;
        case TAG_ASSESSMENTS = 636;
    }

    enum MENU_SUBMENU_TAGS : Int{
        //MENU1
        case TAG_BLANK_NURSE_NOTE = 700;
        case TAG_BLANK_PATIENT_CONSENT = 701;
        case TAG_BLANK_LIVING_WITH_PAH = 702;

        case TAG_PATIENT_LIST = 703;
        case TAG_PATIENT_DETAILS = 704;
        case TAG_VISIT_INFORMATION = 705;
        case TAG_PATIENT_CONSENT = 706;
        case TAG_ACTIVITIES = 707;
        
        //submenu
        case TAG_ASSESSMENT = 708;
        case TAG_ASSESSMENT_NEW_ADMISSION = 800;
        case TAG_ASSESSMENT_CARE_PLANNING = 801;
        case TAG_ASSESSMENT_PHYSICAL = 802;
        case TAG_ASSESSMENT_PAIN = 803;
        case TAG_ASSESSMENT_SAFETY = 804;
        case TAG_ASSESSMENT_FULL_SAFETY_RISK = 805;
        case TAG_ASSESSMENT_NUTRITIONAL = 806;
        case TAG_ASSESSMENT_INITIAL_HEMOPHILIA = 807;
        case TAG_ASSESSMENT_NEW_CONTINUINJG_BLEED = 808;
        case TAG_ASSESSMENT_PRE_POST_ACTIVITY_PROCEDURE = 809;
        case TAG_ASSESSMENT_LIVING_WITH_PAH = 810;

        case TAG_MEDICATIONS = 709;

        //submenu
        case TAG_ACCESS = 710;
        case TAG_ACCESS_ACCESS_IN_PLACE = 900;
        case TAG_ACCESS_ACCESS_INSERTED = 901;
        case TAG_ACCESS_SUBCUTANEOUS_ACCESS = 902;
        case TAG_ACCESS_ACCESS_REMOVED = 903;

        
        case TAG_LABS = 711;
        
        //submenu
        case TAG_THERAPY_ADMINISTERED = 712;
        case TAG_THERAPY_ADMINISTERED_THERAPY_ADMINISTERED = 1000;
        case TAG_THERAPY_ADMINISTERED_THERAPY_DELIVERY_DEVICE = 1001;
        case TAG_THERAPY_ADMINISTERED_VITALS = 1002;
        
        case TAG_PROBLEMS = 713;
        case TAG_PROBLEMS_ADVERSE_DRUG_EVENT = 1100;
        case TAG_PROBLEMS_GENERAL_INFECTION = 1101;
        
        case TAG_FUTURE_PLANS = 714;
        case TAG_FUTURE_PLANS_PATIENT_PROGRESS = 1200;
        case TAG_FUTURE_PLANS_FUTURE_PLANS = 1201;
        
        case TAG_PATIENT_TRAINING = 715;
        case TAG_SIGNATURE = 716;
        

        
        
    }
    
    enum PARSING_TAGS : Int{
        //MENU1
        case TAG_LOGIN_PARSER = 1000;
        case TAG_GET_PATIENT_LIST_PARSER = 1001;
        case TAG_GET_VISIT_AND_VALIDATION_PARSER = 1002;
    }
    
    enum SELECTED_MENU : Int{
        case MENU1_BLANKMENU = 600;
        case MENU2_MAINMENU = 601;
        case MENU3_SUBMENU = 602;
    }
}
