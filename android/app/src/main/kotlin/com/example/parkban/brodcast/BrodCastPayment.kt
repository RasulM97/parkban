package com.example.parkban.brodcast

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log
import android.widget.Toast
import com.example.parkban.CallbackData
import com.example.parkban.model.Response

class BrodCastPayment constructor() : BroadcastReceiver() {
    private var call: CallbackData?=null
    fun addListener( callBack: CallbackData){
        call=callBack
    }
    override fun onReceive(context: Context?, intent: Intent?) {
        val response = Response("")
        intent?.let { response.parseIntent(it) }
        Log.i("Kotlin", "onReceive: "+response.toString())
        call?.onResponse(response)
      if (response.checkPaper=="have not Paper"){
      call?.checkPaper(false)
       }else{
          call?.checkPaper(true)
       }
        when (response.responseCode) {
            "-1" -> {
                Toast.makeText(context, response.timeOut, Toast.LENGTH_SHORT).show()
            }
        }
    }
}