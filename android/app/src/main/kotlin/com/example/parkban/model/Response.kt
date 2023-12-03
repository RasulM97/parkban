package com.example.parkban.model

import android.content.Intent

/**
 * this  model parse response broadcast receiver
 */
data class Response(val paymentMessage:String){
     var cardInfo: String?=""
     var lastSaleFauliedTransaction: String?=""
     var lastSaleSuccessFulTransaction: String?=""
     var errorMessage: String?=""

    //    private var info mutableListOf<String>()
     var responseCode: String?=""
     var mifareResult: String?=""
     var printStatus: String?=""
     var barcodeStatus: String?=""
     var swipeCard: String?=""
     var timeOut: String?=""
     var companyName: String?=""
     var checkPaper: String?=""
   private val CompanyName = "CompanyName"
    private val TransactionType = "TransactionType"
    private   val ResponseCode = "ResponseCode"
    private   val CardNumber = "CardNumber"
    private  val RRN = "RRN"
    private val SerialNumber = "SerialNumber"
    private  val TerminalNumber = "TerminalNumber"
    private  val DateTime = "DateTime"
    private  val Amount = "Amount"
    private  val Balance = "Balance"
    private  val RealBalance = "RealBalance"
    private  val PrintStatus = "PrintStatus"
    private val CheckPaper = "CheckPaper"
    private val BarCodeStatus = "BarCodeStatus"
    private val MifareResult = "MifareResult"
    private val SwipeCard = "SwipeCard"
    private val TimeOut = "TimeOut"
    private val GetInfo = "GetInfo"
    private  val GetCardInfo = "CardInfo"
    private  val GetLastSaleSuccessfulTrx = "getLastSaleSuccessfulTrx"
    val GetLastSaleFailedTrx = "getLastSaleFailedTrx"
    private  val Error = "Error"
    private val Message = "Message"




    fun parseIntent(intent:Intent){

         companyName = intent.getStringExtra(CompanyName)
         errorMessage=intent.getStringExtra(Error)
          timeOut=intent.getStringExtra(TimeOut)
         swipeCard= intent.getStringExtra(SwipeCard)
         barcodeStatus=intent.getStringExtra(BarCodeStatus)
         checkPaper=intent.getStringExtra(CheckPaper)
        printStatus=intent.getStringExtra(PrintStatus)
      mifareResult  =intent.getStringExtra(MifareResult)
        responseCode=intent.getStringExtra(ResponseCode)
    //    info=intent.getShortArrayExtra(GetInfo)
        lastSaleSuccessFulTransaction=intent.getStringExtra(GetLastSaleSuccessfulTrx)
        lastSaleFauliedTransaction=intent.getStringExtra(GetLastSaleFailedTrx)
        cardInfo=intent.getStringExtra(GetCardInfo)

    }

    override fun toString(): String {
        return "Response(paymentMessage='$paymentMessage', cardInfo=$cardInfo, lastSaleFauliedTransaction=$lastSaleFauliedTransaction, lastSaleSuccessFulTransaction=$lastSaleSuccessFulTransaction, errorMessage=$errorMessage, responseCode=$responseCode, mifareResult=$mifareResult, printStatus=$printStatus, barcodeStatus=$barcodeStatus, swipeCard=$swipeCard, timeOut=$timeOut, companyName=$companyName, checkPaper=$checkPaper, GetLastSaleFailedTrx='$GetLastSaleFailedTrx')"
    }


}
