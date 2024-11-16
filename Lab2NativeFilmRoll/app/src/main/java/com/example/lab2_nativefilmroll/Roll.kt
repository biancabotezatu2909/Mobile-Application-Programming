package com.example.lab2_nativefilmroll

import android.os.Parcelable
import android.util.Log
import kotlinx.parcelize.Parcelize

@Parcelize
data class Roll(
    var id: Int,
    var name: String,
    var type: String,
    var iso: String,
    var brand: String,
    var capacity: String,
    var status: String,
    var dateCreated: String
): Parcelable{

    companion object{
        var currentId = 0
    }

    constructor(
        name: String,
        type: String,
        iso: String,
        brand: String,
        capacity: String,
        status: String,
        dateCreated: String
    ):this(currentId++, name, type, iso, brand, capacity, status, dateCreated){
        Log.i("Model roll class: ", "Current ID is $(currentId-1)")
    }

}
