package com.freelancer.arnab.chatapp

import android.content.Context
import android.support.v4.content.ContextCompat
import android.view.LayoutInflater
import android.view.ViewGroup
import android.widget.TextView
import android.support.v7.widget.RecyclerView
import android.view.View
import android.widget.ImageView


class ChatsAdapter// Provide a suitable constructor (depends on the kind of dataset)
(private val mDataset: ArrayList<HashMap<String,String>>,private val mContext: Context) : RecyclerView.Adapter<ChatsAdapter.MyViewHolder>() {

    // Provide a reference to the views for each data item
    // Complex data items may need more than one view per item, and
    // you provide access to all the views for a data item in a view holder
    class MyViewHolder(v: View) : RecyclerView.ViewHolder(v) {
        var mName: TextView
        var mMessage: TextView
        var mUnreadCount: TextView
        var mTimeOfChat: TextView
        var deliveryStatus: ImageView

        init {

            //mCardView = v.findViewById(R.id.card_view)
            mName = v.findViewById(R.id.name)
            mMessage = v.findViewById(R.id.message)
            mUnreadCount = v.findViewById(R.id.unreadCount)
            mTimeOfChat = v.findViewById(R.id.timeOfChat)
            deliveryStatus = v.findViewById(R.id.deliveryStatus)
        }
    }

    // Create new views (invoked by the layout manager)
    override fun onCreateViewHolder(parent: ViewGroup,
                                    viewType: Int): ChatsAdapter.MyViewHolder {
        // create a new view
        val v = LayoutInflater.from(parent.context)
                .inflate(R.layout.chats_card_item, parent, false)
        // set the view's size, margins, paddings and layout parameters
        return MyViewHolder(v)
    }

    override fun onBindViewHolder(holder: MyViewHolder, position: Int) {
        holder.mName.text = mDataset[position]["name"]
        val attrs = intArrayOf(R.attr.colorSecondaryText)
        val typedArray = mContext.obtainStyledAttributes(attrs)
        val colorSecondaryText = typedArray.getColor(0,0)
        typedArray.recycle()

        if(mDataset[position]["typingStatus"]!=null){
            holder.mMessage.text = mDataset[position]["typingStatus"]
            holder.mMessage.setTextColor(ContextCompat.getColor(mContext,R.color.colorAccent))
        }else{
            holder.mMessage.text = mDataset[position]["message"]
            holder.mMessage.setTextColor(colorSecondaryText)
            holder.mMessage.setTextColor(colorSecondaryText)
        }
        if(mDataset[position]["unreadCount"]!=null){
            holder.mUnreadCount.text = mDataset[position]["unreadCount"]
            holder.mUnreadCount.visibility = View.VISIBLE
            holder.mTimeOfChat.setTextColor(ContextCompat.getColor(mContext,R.color.colorAccent))
        }else{
            holder.mUnreadCount.visibility = View.GONE
            holder.mTimeOfChat.setTextColor(colorSecondaryText)
        }

        holder.mTimeOfChat.text = mDataset[position]["timeOfChat"]
        when {
            mDataset[position]["deliveryStatus"]=="sent" -> holder.deliveryStatus.setImageResource(R.drawable.ic_sent_24dp)
            mDataset[position]["deliveryStatus"]=="delivered" -> holder.deliveryStatus.setImageResource(R.drawable.ic_delivered_24dp)
            mDataset[position]["deliveryStatus"]=="seen" -> holder.deliveryStatus.setImageResource(R.drawable.ic_seen_24dp)
            else -> holder.deliveryStatus.visibility = View.GONE
        }
    }

    override fun getItemCount(): Int {
        return mDataset.size
    }
}