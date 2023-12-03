package com.example.parkban

import com.example.parkban.model.Response

interface CallbackData {


    fun onResponse(response: Response)
    fun checkPaper(havePaper:Boolean)
    fun paymentSuccessful(){}
    fun paymentFailed(){}
}