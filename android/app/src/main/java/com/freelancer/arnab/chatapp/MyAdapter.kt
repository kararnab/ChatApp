package com.freelancer.arnab.chatapp

import android.view.LayoutInflater
import android.view.ViewGroup
import android.widget.TextView
import android.support.v7.widget.CardView
import android.support.v7.widget.RecyclerView
import android.view.View


class MyAdapter// Provide a suitable constructor (depends on the kind of dataset)
(private val mDataset: Array<String>) : RecyclerView.Adapter<MyAdapter.MyViewHolder>() {

    // Provide a reference to the views for each data item
    // Complex data items may need more than one view per item, and
    // you provide access to all the views for a data item in a view holder
    class MyViewHolder(v: View) : RecyclerView.ViewHolder(v) {
        var mCardView: CardView
        var mTextView: TextView

        init {

            mCardView = v.findViewById(R.id.card_view)
            mTextView = v.findViewById(R.id.tv_text)
        }
    }

    // Create new views (invoked by the layout manager)
    override fun onCreateViewHolder(parent: ViewGroup,
                                    viewType: Int): MyAdapter.MyViewHolder {
        // create a new view
        val v = LayoutInflater.from(parent.context)
                .inflate(R.layout.card_item, parent, false)
        // set the view's size, margins, paddings and layout parameters
        return MyViewHolder(v)
    }

    override fun onBindViewHolder(holder: MyViewHolder, position: Int) {
        holder.mTextView.text = mDataset[position]
    }

    override fun getItemCount(): Int {
        return mDataset.size
    }
}
