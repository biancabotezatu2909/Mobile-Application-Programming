package com.example.lab2_nativefilmroll

import android.app.DatePickerDialog
import android.os.Bundle
import android.util.Log
import android.widget.ArrayAdapter
import android.widget.Button
import android.widget.EditText
import android.widget.Spinner
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import java.util.Calendar

class UpdateRollActivity:AppCompatActivity() {

    private lateinit var initialRoll: Roll;
    private lateinit var editTextName: EditText
    private lateinit var editTextType: EditText
    private lateinit var editTextIso: EditText
    private lateinit var editTextBrand: EditText
    private lateinit var editTextCapacity: EditText
    private lateinit var spinnerStatus: Spinner
    private lateinit var editTextDateCreated: EditText

    lateinit var updateButton: Button;
    lateinit var id: Number
    private val statusOptions = arrayOf("In Progress", "Developed", "Scanned")

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_update_roll)
        Log.i("UpdateRollActivity", "Got into update activity")
        editTextName = findViewById(R.id.etRollName)
        editTextType = findViewById(R.id.etType)
        editTextIso = findViewById(R.id.etISO)
        editTextBrand = findViewById(R.id.etBrand)
        editTextCapacity = findViewById(R.id.etCapacity)
        spinnerStatus = findViewById(R.id.spinnerStatus)
        editTextDateCreated = findViewById(R.id.etDateCreated)

        editTextDateCreated.setOnClickListener{
            showDatePickerDialog()
        }

        val adapter = ArrayAdapter(this, android.R.layout.simple_spinner_item, statusOptions)

        adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item)
        spinnerStatus.adapter = adapter

        val bundle = intent.getBundleExtra("rollBundle")
        if(bundle != null){
            val roll = bundle.getParcelable<Roll>("updatedRoll")
            if(roll != null){
                initialRoll = roll
                id = roll.id
            }
        }

        populateInitialRoll()

        val updateButton: Button = findViewById(R.id.btnUpdateRoll)
        updateButton.setOnClickListener{
            updateRoll()
        }


    }

    private fun showDatePickerDialog(){

        val calendar = Calendar.getInstance()
        val year = calendar.get(Calendar.YEAR)
        val month = calendar.get(Calendar.MONTH)
        val dayOfMonth = calendar.get(Calendar.DAY_OF_MONTH)

        val datePickerDialog = DatePickerDialog(this, { _, selectedYear, selectedMonth, selectedDay ->

            val formattedDate = String.format("%02d/%02d/%04d", selectedDay, selectedMonth + 1, selectedYear) // Month is 0-based
            editTextDateCreated.setText(formattedDate)
        }, year, month, dayOfMonth)

        datePickerDialog.show()

    }

    private fun updateRoll(){
        if(validateInput()){
            initialRoll.name = editTextName.text.toString()
            initialRoll.type = editTextType.text.toString()
            initialRoll.iso = editTextIso.text.toString()
            initialRoll.brand = editTextBrand.text.toString()
            initialRoll.capacity = editTextCapacity.text.toString()
            initialRoll.status = spinnerStatus.selectedItem.toString()
            initialRoll.dateCreated = editTextDateCreated.text.toString()

            val bundle = Bundle()
            bundle.putParcelable("updatedRoll", initialRoll)
            intent.putExtra("rollBundle", bundle)
            intent.putExtra("id", id)
            setResult(RESULT_OK, intent)
            finish()

        }
        else{
            Toast.makeText(this, "Complete all fields!", Toast.LENGTH_LONG).show()
        }

    }

    private fun validateInput(): Boolean{
        if(editTextName.text.isEmpty() or editTextType.text.isEmpty() or
            editTextIso.text.isEmpty() or editTextDateCreated.text.isEmpty()
            or editTextCapacity.text.isEmpty() or editTextBrand.text.isEmpty()
            or spinnerStatus.toString().isEmpty())
        {
            return false
        }
        return true
    }

    private fun populateInitialRoll(){
        editTextName.setText(initialRoll.name)
        editTextType.setText(initialRoll.type)
        editTextIso.setText(initialRoll.iso)
        editTextBrand.setText(initialRoll.brand)
        editTextCapacity.setText(initialRoll.capacity)
        editTextDateCreated.setText(initialRoll.dateCreated)
        val statusPosition = statusOptions.indexOf(initialRoll.status)
        spinnerStatus.setSelection(statusPosition)

    }



}
