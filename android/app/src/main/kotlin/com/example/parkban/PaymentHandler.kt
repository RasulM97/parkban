package com.example.parkban

import android.annotation.TargetApi
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.os.Build
import android.util.Log
import java.util.Date

/**
 * this object handel  payment poz and checked paper application
 *  requirement  all functions  brodCast receiver in the project
 */
object PaymentHandler {
    /**
     * this function start payment
     *  add context  , company name and amount price
     *
     */
    fun startPayment(context: MainActivity, nameCompany:String, amount:String?, plate:String?, time:String?, place:String?){
        val intent= Intent(Constants.Action)
        intent.putExtra(Constants.CompanyName,nameCompany)
        intent.putExtra(Constants.transactionType, Constants.Sale)
        intent.putExtra(Constants.AM,amount.toString())
        if(time == "0"){
            intent.putExtra(Constants.AdditionalData, "شماره پلاک : $plate\nزمان پارک : $time \n جایگاه : $place ")
        }else{
            intent.putExtra(Constants.AdditionalData, "شماره پلاک : $plate\nزمان پارک : $time دقیقه\n جایگاه : $place ")
        }

        intent.putExtra("paymentType", "CARD")
        context.startActivity(intent)
    }

    /**
     * this function for check paper poz card
     * requirement brodCast receiver  is action  pkg name  com.pec.smartpos
     */
    @TargetApi(Build.VERSION_CODES.O)
    fun checkPaper(main: Context, companyName:String){
        val intent = Intent()
        val cName = ComponentName("com.pec.smartpos", "com.pec.smartpos.cpsdk.PecService")
        intent.component = cName
        intent.putExtra(Constants.CompanyName, companyName)
        intent.putExtra(Constants.checkPaper,"checkPaper")
       main. startForegroundService(intent)
    }
}