package com.example.lab2_nativefilmroll

import android.app.Activity.RESULT_OK
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

class AddRollActivity:AppCompatActivity() {

    private lateinit var editTextName: EditText
    private lateinit var editTextType: EditText
    private lateinit var editTextIso: EditText
    private lateinit var editTextBrand: EditText
    private lateinit var editTextCapacity: EditText
    private lateinit var statusSpinner: Spinner
    private lateinit var editTextDate: EditText

    lateinit var saveButton: Button;
    lateinit var id: String;
    // idText

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_add_roll)

        editTextName = findViewById(R.id.etRollName)
        editTextType = findViewById(R.id.etType)
        editTextIso = findViewById(R.id.etISO)
        editTextBrand = findViewById(R.id.etBrand)
        editTextCapacity = findViewById(R.id.etCapacity)
        statusSpinner = findViewById(R.id.spinnerStatus)
        editTextDate = findViewById(R.id.etDateCreated)

        editTextDate.setOnClickListener{
            showDatePickerDialog()
        }

        val statusOptions = arrayOf("In Progress", "Developed", "Scanned")
        val adapter = ArrayAdapter(this, android.R.layout.simple_spinner_item, statusOptions)

        adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item)
        statusSpinner.adapter = adapter

        val saveRollButton: Button=findViewById(R.id.btnSaveRoll)

        saveRollButton.setOnClickListener{
            saveRoll()
        }


    }


    private fun showDatePickerDialog(){

        val calendar = Calendar.getInstance()
        val year = calendar.get(Calendar.YEAR)
        val month = calendar.get(Calendar.MONTH)
        val dayOfMonth = calendar.get(Calendar.DAY_OF_MONTH)

        val datePickerDialog = DatePickerDialog(this, { _, selectedYear, selectedMonth, selectedDay ->

            val formattedDate = String.format("%02d/%02d/%04d", selectedDay, selectedMonth + 1, selectedYear) // Month is 0-based
            editTextDate.setText(formattedDate)
        }, year, month, dayOfMonth)

        datePickerDialog.show()

    }

    private fun saveRoll(){
        if(validateInput()){
            val newRoll = Roll(
                editTextName.text.toString(),
                editTextType.text.toString(),
                editTextIso.text.toString(),
                editTextBrand.text.toString(),
                editTextCapacity.text.toString(),
                statusSpinner.selectedItem.toString(),
                editTextDate.text.toString()
            )
            val bundle = Bundle()
            bundle.putParcelable("newRoll", newRoll)
            intent.putExtra("rollBundle", bundle)
            Log.d("AddRollActivity", "New roll added: $newRoll")
            setResult(RESULT_OK, intent)
            finish()
        }
        else{
            Toast.makeText(this, "Complete all fields!", Toast.LENGTH_LONG).show()
        }

    }

    private fun validateInput(): Boolean{
        if(editTextName.text.isEmpty() or editTextType.text.isEmpty() or
            editTextIso.text.isEmpty() or editTextDate.text.isEmpty()
            or editTextCapacity.text.isEmpty() or editTextBrand.text.isEmpty()
            or statusSpinner.toString().isEmpty())
        {
            return false
        }
        return true
    }



}