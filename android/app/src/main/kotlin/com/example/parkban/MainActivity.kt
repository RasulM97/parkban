package com.example.parkban

import android.content.ContextWrapper
import android.content.IntentFilter
import android.os.Bundle
import android.util.Log
import androidx.annotation.NonNull
import com.example.parkban.brodcast.BrodCastPayment
import com.example.parkban.model.Response
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity : FlutterActivity(), CallbackData {
    private val CHANNEL = "send.flutter.transaction/pos"
    var resultCallback: MethodChannel.Result? = null
    var isPaper: Boolean = false
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        initBrodCast()
    }

    var amount: String? = ""
    var plate: String? = ""
    var time: String? = ""
    var place: String? = ""
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        //
        PaymentHandler.checkPaper(this, "ایمن پارک آذر")
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            resultCallback = result
            Log.i("Kotlin", "MethodChannel Called")
            Log.i("Kotlin", "plate: ${call.argument<String>("plate")}")
            if (call.method == "payment") {
                PaymentHandler.checkPaper(this, "ایمن پارک آذر")
                amount = call.argument<String>("amount")
                time = call.argument<String>("time")
                plate = call.argument<String>("plate")
                place = call.argument<String>("place")
                if (isPaper) {
                    payment(amount, plate, time, place)
                }else{
                    resultCallback!!.success("Paper")
                }
            }
//            else if(call.method == "SCONDE_METHOD_NAME"){
//                val variable = secodMethod()
//                if(variable != null && variable != "") {
//                    result.success(variable)
//                }else {
//                    result.error("UNAVAILABLE", "method not available.", null)
//                }
//            }
//            else {
//                result.notImplemented()
//            }
        }
    }

    fun payment(amount: String?, plate: String?, time: String?) {
        PaymentHandler.startPayment(context = this, "ایمن پارک آذر", amount, plate, time, place)
    }

    var myRadarReceiver: BrodCastPayment? = null
    fun initBrodCast() {
        if (myRadarReceiver == null) {
            myRadarReceiver = BrodCastPayment()
            myRadarReceiver!!.addListener(this)
            val intentFilter = IntentFilter()
            intentFilter.addAction("com.pec.ThirdCompany")
            ContextWrapper(this.context).registerReceiver(myRadarReceiver, intentFilter)
        }
    }

    override fun onResponse(response: Response) {
        if (!response.lastSaleSuccessFulTransaction.isNullOrBlank()) {
            Log.i("Kotlin", "onResponse: " + response.toString())
        }
        val res = when (response.responseCode) {
            "05" -> "Canceled"
            "-1" -> "TimeOut"
            "55" -> "WrongPassword"
            "00" -> "Success"
            "58" -> "Invalid"
            "61" -> "Range"
            "65" -> "Limited"
            null -> "Paper"

            else -> {
                "WentWrong"
            }
        }
        if (!response.responseCode.isNullOrEmpty()) {
            resultCallback!!.success(res)
        }
        println(res)
    }

    override fun checkPaper(havePaper: Boolean) {
        if (!havePaper) {
            isPaper = false
            Log.i("Kotlin", "not have paper ")
        }else{
            isPaper = true
        }
    }
}
