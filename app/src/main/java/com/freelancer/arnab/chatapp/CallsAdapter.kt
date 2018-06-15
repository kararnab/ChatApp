package com.freelancer.arnab.chatapp

import android.view.LayoutInflater
import android.view.ViewGroup
import android.widget.TextView
import android.support.v7.widget.RecyclerView
import android.view.View
import android.widget.ImageView

/**
 * Created by Arnab Kar on 11/06/18.
 * Email   : arnabrocking@gmail.com
 */
class CallsAdapter// Provide a suitable constructor (depends on the kind of dataset)
(private val mDataset: ArrayList<HashMap<String,String>>) : RecyclerView.Adapter<CallsAdapter.MyViewHolder>() {

    // Provide a reference to the views for each data item
    // Complex data items may need more than one view per item, and
    // you provide access to all the views for a data item in a view holder
    class MyViewHolder(v: View) : RecyclerView.ViewHolder(v) {
        var mName: TextView
        var mTimeOfCall: TextView
        var mActionTypeImage: ImageView

        init {

            //mCardView = v.findViewById(R.id.card_view)
            mName = v.findViewById(R.id.name)
            mTimeOfCall = v.findViewById(R.id.timeOfCall)
            mActionTypeImage = v.findViewById(R.id.actionImage)
        }
    }

    // Create new views (invoked by the layout manager)
    override fun onCreateViewHolder(parent: ViewGroup,
                                    viewType: Int): CallsAdapter.MyViewHolder {
        // create a new view
        val v = LayoutInflater.from(parent.context)
                .inflate(R.layout.calls_card_item, parent, false)
        // set the view's size, margins, paddings and layout parameters
        return MyViewHolder(v)
    }

    override fun onBindViewHolder(holder: MyViewHolder, position: Int) {
        holder.mName.text = mDataset[position]["name"]
        holder.mTimeOfCall.text = mDataset[position]["callSummery"]
        if(mDataset[position]["actionType"]=="audio"){
            holder.mActionTypeImage.setImageResource(R.drawable.ic_call_black_24dp)
        }else {
            holder.mActionTypeImage.setImageResource(R.drawable.ic_videocam_black_24dp)
        }
    }

    override fun getItemCount(): Int {
        return mDataset.size
    }
}