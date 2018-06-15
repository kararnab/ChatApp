package com.freelancer.arnab.chatapp

import android.content.Context
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.support.v7.widget.Toolbar
import android.view.View
import android.support.design.widget.TabLayout
import android.support.v4.app.Fragment
import android.support.v4.app.FragmentManager
import android.support.v4.view.ViewPager
import android.widget.TextView
import android.support.v4.app.FragmentPagerAdapter
import android.view.Menu
import android.view.MenuItem
import kotlinx.android.synthetic.main.activity_main.*
import android.app.SearchManager
import android.support.v7.widget.SearchView

/**
 * Created by Arnab Kar on 11/06/18.
 * Email   : arnabrocking@gmail.com
 */
class MainActivity : AppCompatActivity() {

    private var tabTitles = arrayOf("CHATS", "STATUS", "CALLS")
    var unreadCount = intArrayOf(1, 5, 0)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val toolbar = findViewById<View>(R.id.toolbar) as Toolbar
        setSupportActionBar(toolbar)


        // Get the ViewPager and set it's PagerAdapter so that it can display items
        val viewPager = findViewById<View>(R.id.viewpager) as ViewPager
        viewPager.offscreenPageLimit=3
        setupViewPager(viewPager,tabTitles)

        // Give the TabLayout the ViewPager
        val tabLayout = findViewById<View>(R.id.tab_layout) as TabLayout
        tabLayout.setupWithViewPager(viewPager)

        try{
            setupTabIcons(tabLayout,tabTitles)
        }catch (e:Exception){
            e.printStackTrace()
        }

        val onTabSelectedListener = object : TabLayout.OnTabSelectedListener {
            override fun onTabSelected(tab: TabLayout.Tab) {
                viewPager.currentItem = tab.position
                animateFab(tab.position)
            }

            override fun onTabUnselected(tab: TabLayout.Tab) {

            }

            override fun onTabReselected(tab: TabLayout.Tab) {

            }
        }
        tabLayout.addOnTabSelectedListener(onTabSelectedListener)
    }

    private fun setupViewPager(viewPager: ViewPager,tabTitles: Array<String>) {
        val pagerAdapter = PagerAdapter(supportFragmentManager, this@MainActivity,tabTitles)
        viewPager.adapter = pagerAdapter
    }

    private fun prepareTabView(pos: Int,tabTitle: Array<String>): View {
        val view = layoutInflater.inflate(R.layout.custom_tab, null)
        val tvTitle = view.findViewById(R.id.tv_title) as TextView
        val tvCount = view.findViewById(R.id.tv_count) as TextView
        tvTitle.text = tabTitle[pos]
        if (unreadCount[pos] > 0) {
            tvCount.visibility = View.VISIBLE
            tvCount.text = String.format("%d", unreadCount[pos])
        } else
            tvCount.visibility = View.GONE


        return view
    }

    private fun setupTabIcons(tabLayout:TabLayout,tabTitle: Array<String>) {
        for (i in 0 until tabTitle.size) {
            tabLayout.getTabAt(i)!!.customView=prepareTabView(i,tabTitle)
        }
    }

    public override fun onResume() {
        super.onResume()
    }

    override fun onCreateOptionsMenu(menu: Menu): Boolean {
        menuInflater.inflate(R.menu.menu_main, menu)
        // Retrieve the SearchView and plug it into SearchManager
        val searchView = menu.findItem(R.id.action_search).actionView as SearchView
        val searchManager = getSystemService(Context.SEARCH_SERVICE) as SearchManager
        searchView.setSearchableInfo(searchManager.getSearchableInfo(componentName))
        return true
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        val id = item.itemId

        return if (id == R.id.action_settings) {
            true
        } else super.onOptionsItemSelected(item)

    }

    internal inner class PagerAdapter(fm: FragmentManager, var context: Context, private var tabTitles:Array<String>) : FragmentPagerAdapter(fm) {

        override fun getCount(): Int {
            return tabTitles.size
        }

        override fun getItem(position: Int): Fragment? {

            when (position) {
                0 -> return ChatsFragment()
                1 -> return BlankFragment()
                2 -> return CallsFragment()
            }

            return null
        }

        override fun getPageTitle(position: Int): CharSequence? {
            // Generate title based on item position
            return tabTitles[position]
        }

        /*fun getTabView(position: Int): View {
            val tab = LayoutInflater.from(this@MainActivity).inflate(R.layout.custom_tab, null)
            val tv = tab.findViewById(R.id.custom_text) as TextView
            tv.text = tabTitles[position]
            return tab
        }*/

    }

    private fun animateFab(position: Int) {
        when (position) {
            0 -> {
                fabChat.show()
                fabStatusCamera.hide()
                fabStatusEdit.hide()
                fabCall.hide()

            }
            1 -> {
                fabChat.hide()
                fabStatusCamera.show()
                fabStatusEdit.show()
                fabCall.hide()
            }
            2 -> {
                fabChat.hide()
                fabStatusCamera.hide()
                fabStatusEdit.hide()
                fabCall.show()
            }

            else -> {
                fabChat.hide()
                fabStatusCamera.hide()
                fabStatusEdit.hide()
                fabCall.hide()
            }
        }
    }
}