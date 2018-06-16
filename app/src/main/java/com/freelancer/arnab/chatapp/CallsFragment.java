package com.freelancer.arnab.chatapp;

import android.content.DialogInterface;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.v4.app.Fragment;
import android.support.v7.app.AlertDialog;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.text.Spannable;
import android.text.SpannableStringBuilder;
import android.text.style.ImageSpan;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.HashMap;

/**
 * Created by Arnab Kar on 11/06/18.
 * Email   : arnabrocking@gmail.com
 */
public class CallsFragment extends Fragment {

    public CallsFragment() {
        // Required empty public constructor
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setHasOptionsMenu(true);

    }

    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View rootView = inflater.inflate(R.layout.fragment_calls, container, false);

        RecyclerView callsRecyclerView = rootView.findViewById(R.id.rv_recycler_view);
        TextView emptyView = rootView.findViewById(R.id.emptyView);
        setImgSpan(emptyView,getString(R.string.empty_msg_begin),getString(R.string.empty_msg_end));

        callsRecyclerView.setHasFixedSize(true);

        //This is just a prototype, we will use live data to show the list according to google i/o 2017
        ArrayList<HashMap<String,String>> myCallList = new ArrayList<>();

        HashMap<String,String> hashMap1 = new HashMap<>();
        hashMap1.put("name","Arnab Kar");
        hashMap1.put("actionType","video");
        hashMap1.put("callSummery","(3) Yesterday, 10:51 PM");

        HashMap<String,String> hashMap2 = new HashMap<>();
        hashMap2.put("name","Rahul Kumar Yadav");
        hashMap2.put("actionType","audio");
        hashMap2.put("callSummery","Yesterday, 9:29 PM");

        /*myCallList.add(hashMap1);
        myCallList.add(hashMap2);
        myCallList.add(hashMap2);
        myCallList.add(hashMap2);
        myCallList.add(hashMap1);
        myCallList.add(hashMap1);
        myCallList.add(hashMap2);*/

        CallsAdapter adapter = new CallsAdapter(myCallList);
        addDataListener(adapter,emptyView);
        callsRecyclerView.setAdapter(adapter);

        LinearLayoutManager llm = new LinearLayoutManager(getActivity());
        callsRecyclerView.setLayoutManager(llm);

        return rootView;
    }

    @Override
    public void onCreateOptionsMenu(Menu menu, MenuInflater inflater) {
        inflater.inflate(R.menu.menu_calls_fragment, menu);
        super.onCreateOptionsMenu(menu, inflater);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch(item.getItemId()){
            case R.id.action_clear_log:
                AlertDialog.Builder builder = new AlertDialog.Builder(getContext());
                builder.setMessage("Do you want to clear your entire call log?");
                builder.setPositiveButton("OK", new DialogInterface.OnClickListener() {
                            @Override
                            public void onClick(DialogInterface dialogInterface, int i) {
                                clearCallLog();
                            }
                        });
                builder.setNegativeButton("CANCEL", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {

                    }
                });
                AlertDialog alert = builder.create();
                alert.show();
        break;
            default:

        }
        return super.onOptionsItemSelected(item);
    }

    void clearCallLog(){

    }

    void setImgSpan(TextView emptyView,String start,String end){

        SpannableStringBuilder builder = new SpannableStringBuilder();
        builder.append(start).append(" ");
        builder.setSpan(new ImageSpan(getActivity(), R.drawable.ic_call_24dp),
                builder.length() - 1, builder.length(), 0);
        builder.append(end);

        emptyView.setText(builder);
    }

    void addDataListener(final RecyclerView.Adapter mAdapter,final View mEmptyView){
        mAdapter.registerAdapterDataObserver(new RecyclerView.AdapterDataObserver() {

            @Override
            public void onChanged() {
                super.onChanged();
                checkEmpty();
            }

            @Override
            public void onItemRangeInserted(int positionStart, int itemCount) {
                super.onItemRangeInserted(positionStart, itemCount);
                checkEmpty();
            }

            @Override
            public void onItemRangeRemoved(int positionStart, int itemCount) {
                super.onItemRangeRemoved(positionStart, itemCount);
                checkEmpty();
            }

            void checkEmpty() {
                mEmptyView.setVisibility(mAdapter.getItemCount() == 0 ? View.VISIBLE : View.GONE);
            }
        });
    }
}