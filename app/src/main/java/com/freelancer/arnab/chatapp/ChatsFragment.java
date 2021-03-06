package com.freelancer.arnab.chatapp;

import android.content.Intent;
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

import com.freelancer.arnab.chatapp.customviews.RecyclerViewEmptySupport;

import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import java.util.ArrayList;
import java.util.HashMap;

public class ChatsFragment extends Fragment {

    public ChatsFragment() {
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

        RecyclerViewEmptySupport rv = rootView.findViewById(R.id.rv_recycler_view);
        rv.setHasFixedSize(true);
        /*rv.addItemDecoration(new DividerItemDecoration(getContext(), DividerItemDecoration.VERTICAL));*/

        final ArrayList<HashMap<String,String>> myChatList = new ArrayList<>();
        initChatListWithData(myChatList);

        ChatsAdapter adapter = new ChatsAdapter(myChatList,getContext());
        rv.setAdapter(adapter);

        LinearLayoutManager llm = new LinearLayoutManager(getActivity());
        //llm.setStackFromEnd(true); //Do try this too if you want to achieve the other thing, same as app:stackFromEnd="true"
        //llm.setReverseLayout(true); //This makes the list get reversed like in chats, same as app:reverseLayout="true"

        rv.setLayoutManager(llm);

        rv.addOnItemTouchListener(new RecyclerItemClickListener(getContext(),rv,new RecyclerItemClickListener.OnItemClickListener(){

            @Override
            public void onItemLongClick(@Nullable View view, int position) {

            }

            @Override
            public void onItemClick(@NotNull View view, int position) {
                Intent intent = new Intent(getContext(),ChatDetail.class);
                intent.putExtra("userOrGroupName",myChatList.get(position).get("name"));
                startActivity(intent);
            }
        }));

        return rootView;
    }

    @Override
    public void onCreateOptionsMenu(Menu menu, MenuInflater inflater) {
        inflater.inflate(R.menu.menu_chat_fragment, menu);
        super.onCreateOptionsMenu(menu, inflater);
    }

    void initChatListWithData(ArrayList<HashMap<String,String>> myChatList){
        HashMap<String,String> hashMap1 = new HashMap<>();
        hashMap1.put("name","Riaz Khan");
        hashMap1.put("imgUrl","https://dummyimage.com/160x160&text=R");
        hashMap1.put("typingStatus","typing...");
        hashMap1.put("message","Hello! How are you? Did you see my progress so far in the quest?");
        hashMap1.put("timeOfChat","12:50 AM");
        hashMap1.put("unreadCount","3");
        hashMap1.put("deliveryStatus","");
        hashMap1.put("muteStatus","");

        HashMap<String,String> hashMap2 = new HashMap<>();
        hashMap2.put("name","Arnab Kar");
        hashMap2.put("imgUrl","https://dummyimage.com/160x160&text=A");
        hashMap2.put("message","Hello! How are you? Did you see my progress so far in the quest?");
        hashMap2.put("timeOfChat","12:44 AM");
        hashMap2.put("unreadCount",null);
        hashMap2.put("deliveryStatus","sent");
        hashMap2.put("muteStatus","");

        HashMap<String,String> hashMap3 = new HashMap<>();
        hashMap3.put("name","Rodrigo Diaz");
        hashMap3.put("message","I think you can read my msg. But why have you not replied still now. WWHere are you?");
        hashMap3.put("timeOfChat","12:01 AM");
        hashMap3.put("unreadCount",null);
        hashMap3.put("deliveryStatus","delivered");
        hashMap3.put("muteStatus","");

        HashMap<String,String> hashMap4 = new HashMap<>();
        hashMap4.put("name","Xiemena Diaz");
        hashMap4.put("message","Ha! ha ha! You did see my msg. I can see from here");
        hashMap4.put("timeOfChat","YESTERDAY");
        hashMap4.put("unreadCount","1");
        hashMap4.put("deliveryStatus","seen");
        hashMap4.put("muteStatus","mute");

        myChatList.add(hashMap1);
        myChatList.add(hashMap2);
        myChatList.add(hashMap3);
        myChatList.add(hashMap4);
        myChatList.add(hashMap3);
        myChatList.add(hashMap3);
        myChatList.add(hashMap2);
    }
}