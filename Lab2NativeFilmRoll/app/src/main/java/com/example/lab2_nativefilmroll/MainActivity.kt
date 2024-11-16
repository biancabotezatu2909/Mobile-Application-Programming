package com.example.lab2_nativefilmroll

import android.animation.ObjectAnimator
import android.content.Intent
import android.os.Bundle
import android.os.Handler
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import com.example.lab2_nativefilmroll.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        // Set the new text for the intro screen
        binding.textView.text = ""

        // Start the typing animation
        typingEffect(binding.textView, "Film Photo Journal")
    }

    private fun typingEffect(textView: TextView, text: String) {
        val handler = Handler()
        val delay = 150 // Milliseconds delay between each letter

        // Loop through each character in the string
        var index = 0
        handler.postDelayed(object : Runnable {
            override fun run() {
                // Append one character to the text view
                textView.text = text.substring(0, index + 1)
                index++
                if (index < text.length) {
                    // Keep typing until all characters are added
                    handler.postDelayed(this, delay.toLong())
                } else {
                    // Once typing is complete, fade out the text
                    Handler().postDelayed({
                        fadeOutText(textView)
                    }, 1000) // 1-second delay before fading out
                }
            }
        }, delay.toLong())
    }

    private fun fadeOutText(textView: TextView) {
        // Fade out the text by decreasing the alpha value
        val fadeOutAnim = ObjectAnimator.ofFloat(textView, "alpha", 1f, 0f).apply {
            duration = 1500
        }
        fadeOutAnim.start()

        // After the fade-out animation finishes, navigate to the next activity
        Handler().postDelayed({
            val intent = Intent(this@MainActivity, RollsList::class.java)
            startActivity(intent)
            finish()
        }, 1500) // Ensure that the fade-out completes before moving to the next screen
    }
}
