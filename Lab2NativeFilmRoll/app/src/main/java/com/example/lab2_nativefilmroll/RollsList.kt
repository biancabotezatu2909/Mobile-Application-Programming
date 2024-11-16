package com.example.lab2_nativefilmroll

import android.app.ComponentCaller
import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.widget.Adapter
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.google.android.material.floatingactionbutton.FloatingActionButton

class RollsList: AppCompatActivity() {

    private lateinit var recyclerView: RecyclerView
    private lateinit var adapter: RollRecycleViewAdapter

    private var rolls: MutableList<Roll> = mutableListOf()

    override fun onCreate(savedInstanceState: Bundle?){
        super.onCreate(savedInstanceState)
        setContentView(R.layout.rolls_recycler_view)

        initRolls()

        Log.d("RollsList", "Initial rolls: $rolls")

        recyclerView = findViewById(R.id.rollsRecyclerView)
        recyclerView.layoutManager = LinearLayoutManager(this)

        adapter = RollRecycleViewAdapter(rolls,
            context = this)

        recyclerView.adapter = adapter

        val addActivity: FloatingActionButton = findViewById(R.id.addButton)
        addActivity.setOnClickListener{
            val intent = Intent(this@RollsList, AddRollActivity::class.java)
            startActivityForResult(intent, 3)
        }
    }

    override fun onActivityResult(
        requestCode: Int,
        resultCode: Int,
        data: Intent?
    ) {
        super.onActivityResult(requestCode, resultCode, data)
        if(requestCode == 3){
            Log.i(data.toString(), " ")
            if(resultCode == RESULT_OK){
                if(data != null){
                    val bundle = data.getBundleExtra("rollBundle")
                    val roll = bundle?.getParcelable<Roll>("newRoll")
                    if(roll != null){
                        addRoll(roll)
                    }
                }
                Toast.makeText(this, "Roll added!", Toast.LENGTH_SHORT).show()
                recyclerView.adapter?.notifyItemInserted(rolls.size - 1)

            }

        }
        else if(requestCode == 5){
            if(resultCode == android.app.Activity.RESULT_OK){
                if(data != null){
                    val bundle = data.getBundleExtra("rollBundle")
                    val roll = bundle?.getParcelable<Roll>("updatedRoll")
                    val id = data.getIntExtra("id", -1)
                    if(roll != null && id != -1){
                        updateRoll(roll, id)
                    }
                }
            }
        }
    }

    private fun addRoll(roll: Roll){
        rolls.add(roll)
    }

    private fun updateRoll(roll: Roll, id: Number){
        for(i in 0 until rolls.size){
            if(rolls[i].id == id){
                rolls[i] = roll
                Toast.makeText(this, "Roll Updated!", Toast.LENGTH_SHORT).show()
                recyclerView.adapter?.notifyItemChanged(i)
            }
        }
    }

    fun initRolls(){
        val roll1 = Roll("Roll 1", "color", "100", "Kodak", "36", "Scanned", "12-12-2012")
        val roll2 = Roll("Roll 2", "BW", "200", "Fujifilm", "24", "Developed", "10-11-2020")
        val roll3 = Roll("Roll 3", "color", "100", "Ilford", "72", "In progress", "17-04-2023")

        rolls.add(roll1)
        rolls.add(roll2)
        rolls.add(roll3)

    }
}
