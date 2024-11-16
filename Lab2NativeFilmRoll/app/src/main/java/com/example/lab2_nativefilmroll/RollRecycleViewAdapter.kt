package com.example.lab2_nativefilmroll

import android.app.Dialog
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.EditText
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.example.lab2_nativefilmroll.RollsList
import com.google.android.material.floatingactionbutton.FloatingActionButton

class RollRecycleViewAdapter(
    private val rolls: MutableList<Roll>,
    private val context: RollsList
    // Pass the updated list from LiveData
) : RecyclerView.Adapter<RollRecycleViewAdapter.RollViewHolder>() {


    override fun onCreateViewHolder(
        parent: ViewGroup,
        viewType: Int
    ): RollViewHolder {
        Log.d("RollRecycleViewAdapter", "Got into view holder")

        val view = LayoutInflater.from(parent.context).inflate(R.layout.item_roll, parent, false)

        return RollViewHolder(view)
    }

    override fun onBindViewHolder(
        holder: RollViewHolder,
        position: Int
    ) {
        val rollItem = rolls[position]
        holder.name.text = rollItem.name
        holder.type.text = rollItem.type
        holder.iso.text = rollItem.iso
        holder.brand.text = rollItem.brand
        holder.capacity.text = rollItem.capacity
        holder.status.text = rollItem.status
        holder.dateCreated.text = rollItem.dateCreated

        Log.d("RollRecycleViewAdapter", "Roll to add: $rollItem")

        holder.updateButton.setOnClickListener{
            Log.i("RollRecycleViewAdapter", "Got into update")
            val bundle = Bundle()
            val intent = Intent(context, UpdateRollActivity::class.java)

            bundle.putParcelable("updatedRoll", rolls[position])
            intent.putExtra("rollBundle", bundle)
            context.startActivityForResult(intent, 5)

        }

        holder.deleteButton.setOnClickListener{
            val dialog = Dialog(context)
            dialog.setCancelable(true)
            dialog.setContentView(R.layout.activity_delete_roll)

            val yesView = dialog.findViewById(R.id.confirmedDeleteButton) as View

            val noView = dialog.findViewById(R.id.cancelButton) as View

            yesView.setOnClickListener{
                rolls.removeAt(position)
                notifyDataSetChanged()
                dialog.dismiss()
            }

            noView.setOnClickListener{
                dialog.dismiss()
            }

            dialog.show()

        }

    }

    override fun getItemCount(): Int {
        return rolls.size
    }

    class RollViewHolder(itemView: View): RecyclerView.ViewHolder(itemView){
        val name: TextView = itemView.findViewById(R.id.editTextName)
        val type: TextView = itemView.findViewById(R.id.editTextType)
        val iso: TextView = itemView.findViewById(R.id.editTextISO)
        val brand: TextView = itemView.findViewById(R.id.editTextBrand)
        val capacity: TextView = itemView.findViewById(R.id.editTextCapacity)
        val status: TextView = itemView.findViewById(R.id.editTextStatus)
        val dateCreated: TextView = itemView.findViewById(R.id.editTextDateCreated)

        val updateButton: FloatingActionButton = itemView.findViewById(R.id.editButton)
        val deleteButton: FloatingActionButton = itemView.findViewById(R.id.deleteButton)

    }
}
