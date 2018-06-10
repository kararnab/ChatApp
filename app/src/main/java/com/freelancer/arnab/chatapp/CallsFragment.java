package com.freelancer.arnab.chatapp;

import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.v4.app.Fragment;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.View;
import android.view.ViewGroup;

import java.util.ArrayList;
import java.util.HashMap;

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
        View rootView = inflater.inflate(R.layout.fragment_blank, container, false);

        RecyclerView rv = rootView.findViewById(R.id.rv_recycler_view);
        rv.setHasFixedSize(true);

        ArrayList<HashMap<String,String>> myCallList = new ArrayList<>();

        HashMap<String,String> hashMap1 = new HashMap<>();
        hashMap1.put("name","Arnab Kar");
        hashMap1.put("actionType","video");
        hashMap1.put("callSummery","(3) Yesterday, 10:51 PM");

        HashMap<String,String> hashMap2 = new HashMap<>();
        hashMap2.put("name","Rahul Kumar Yadav");
        hashMap2.put("actionType","audio");
        hashMap2.put("callSummery","Yesterday, 9:29 PM");

        myCallList.add(hashMap1);
        myCallList.add(hashMap2);
        myCallList.add(hashMap2);
        myCallList.add(hashMap2);
        myCallList.add(hashMap1);
        myCallList.add(hashMap1);
        myCallList.add(hashMap2);

        CallsAdapter adapter = new CallsAdapter(myCallList);
        rv.setAdapter(adapter);

        LinearLayoutManager llm = new LinearLayoutManager(getActivity());
        rv.setLayoutManager(llm);

        return rootView;
    }

    @Override
    public void onCreateOptionsMenu(Menu menu, MenuInflater inflater) {
        inflater.inflate(R.menu.menu_calls_fragment, menu);
        super.onCreateOptionsMenu(menu, inflater);
    }
}

