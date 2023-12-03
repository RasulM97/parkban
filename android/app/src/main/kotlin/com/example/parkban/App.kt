package com.example.parkban

import android.app.Application
import android.content.IntentFilter
import com.example.parkban.brodcast.BrodCastPayment

class App : Application() {
    override fun onCreate() {
        super.onCreate()
        val myRadarReceiver = BrodCastPayment()
        val intentFilter = IntentFilter()
        intentFilter.addAction("com.pec.ThirdCompany")
      applicationContext.registerReceiver(myRadarReceiver, intentFilter)
     //   startActivity(Intent(applicationContext,MainActivity::class.java))
    }
}