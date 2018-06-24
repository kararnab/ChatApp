package com.freelancer.arnab.chatapp

import android.content.Context
import android.text.SpannableStringBuilder
import android.text.format.DateUtils
import android.text.style.ImageSpan
import android.util.Log
import android.view.View
import android.view.animation.Animation
import android.view.WindowManager
import android.view.animation.Transformation
import java.security.SecureRandom
import java.text.SimpleDateFormat
import java.util.*
import javax.crypto.Cipher
import javax.crypto.KeyGenerator
import javax.crypto.spec.SecretKeySpec


class Utility {

    companion object {

        @JvmStatic
        fun setImgSpan(context: Context,resourceId: Int ,start: String, end: String): SpannableStringBuilder {

            val builder = SpannableStringBuilder()
            builder.append(start).append(" ")
            builder.setSpan(ImageSpan(context, resourceId),
                    builder.length - 1, builder.length, 0)
            builder.append(end)
            return builder
        }

        @JvmStatic
        fun expand(v: View) {
            v.measure(WindowManager.LayoutParams.MATCH_PARENT, WindowManager.LayoutParams.WRAP_CONTENT)
            val targetHeight = v.measuredHeight

            // Older versions of android (pre API 21) cancel animations for views with a height of 0.
            v.layoutParams.height = 1
            v.visibility = View.VISIBLE
            val a = object : Animation() {
                override fun applyTransformation(interpolatedTime: Float, t: Transformation) {
                    v.layoutParams.height = if (interpolatedTime == 1f)
                        WindowManager.LayoutParams.WRAP_CONTENT
                    else
                        (targetHeight * interpolatedTime).toInt()
                    v.requestLayout()
                }

                override fun willChangeBounds(): Boolean {
                    return true
                }
            }

            // 1dp/ms
            a.duration = ((targetHeight / v.context.resources.displayMetrics.density).toInt()).toLong()
            v.startAnimation(a)
        }

        @JvmStatic
        fun collapse(v: View) {
            val initialHeight = v.measuredHeight

            val a = object : Animation() {
                override fun applyTransformation(interpolatedTime: Float, t: Transformation) {
                    if (interpolatedTime == 1f) {
                        v.visibility = View.GONE
                    } else {
                        v.layoutParams.height = initialHeight - (initialHeight * interpolatedTime).toInt()
                        v.requestLayout()
                    }
                }

                override fun willChangeBounds(): Boolean {
                    return true
                }
            }

            // 1dp/ms
            a.duration = ((initialHeight / v.context.resources.displayMetrics.density).toInt()).toLong()
            v.startAnimation(a)
        }

        @JvmStatic
        fun formattedDate(timeEllapsedTillEpoch: Long): String {

            val date = Date(timeEllapsedTillEpoch)
            return when {
                DateUtils.isToday(timeEllapsedTillEpoch) -> "Today"
                isYesterday(timeEllapsedTillEpoch) -> "Yesterday"
                else -> {
                    val formatter = SimpleDateFormat("dd MMMM yyyy", Locale.ENGLISH)
                    formatter.format(date)
                }
            }
        }

        /**
         * Since isToday is already provided by DateUtils we won't be reinventing the wheel, we still
         * need to write code for isYesterday
         */
        private fun isYesterday(date: Long): Boolean {
            val dtNow = Calendar.getInstance()
            val cDate = Calendar.getInstance()
            cDate.timeInMillis = date

            dtNow.add(Calendar.DATE, -1)

            return (dtNow[Calendar.YEAR] == cDate[Calendar.YEAR]
                    && dtNow[Calendar.MONTH] == cDate[Calendar.MONTH]
                    && dtNow[Calendar.DATE] == cDate[Calendar.DATE])
        }

        /**
         * Errors need to be reported for developers to fix. Hence, we need it here, abstracting
         * the reporting function, any call to this function will be sent to Crashlytics or other
         * crash reporting tool.
         */
        @JvmStatic
        fun reportExceptionForAnalytics(title: String, e: Exception?){
            Log.e("Exception Caught",title,e)
        }
    }

    //todo https://dummyimage.com/160x160&text=A to generate Dummy Image with content A.

}