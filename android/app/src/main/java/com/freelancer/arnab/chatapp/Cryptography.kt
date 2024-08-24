package com.freelancer.arnab.chatapp

import android.os.Environment
import java.security.SecureRandom
import javax.crypto.Cipher
import javax.crypto.KeyGenerator
import javax.crypto.spec.SecretKeySpec
import java.io.BufferedOutputStream
import java.io.File
import java.io.FileOutputStream


class Cryptography {

    companion object {

        @Throws(Exception::class)
        fun generateKey(password: String): ByteArray {
            val keyStart = password.toByteArray(charset("UTF-8"))

            val kgen = KeyGenerator.getInstance("AES")
            val sr = SecureRandom.getInstance("SHA1PRNG", "Crypto")
            sr.setSeed(keyStart)
            kgen.init(128, sr)
            val skey = kgen.generateKey()
            return skey.getEncoded()
        }

        @JvmStatic
        @Throws(Exception::class)
        fun encodeFile(key: ByteArray, fileData: ByteArray): ByteArray {

            val skeySpec = SecretKeySpec(key, "AES")
            val cipher = Cipher.getInstance("AES")
            cipher.init(Cipher.ENCRYPT_MODE, skeySpec)

            return cipher.doFinal(fileData)
        }

        @JvmStatic
        @Throws(Exception::class)
        fun decodeFile(key: ByteArray, fileData: ByteArray): ByteArray {
            val skeySpec = SecretKeySpec(key, "AES")
            val cipher = Cipher.getInstance("AES")
            cipher.init(Cipher.DECRYPT_MODE, skeySpec)

            return cipher.doFinal(fileData)
        }

        fun saveToFile(folderOnSdCard:String, fileName: String, byteArrayContainigDataToEncrypt: ByteArray,password: String){
            val file = File("${Environment.getExternalStorageDirectory()}${File.separator}$folderOnSdCard", fileName)
            val bos = BufferedOutputStream(FileOutputStream(file))
            val yourKey = generateKey(password)
            val fileBytes = encodeFile(yourKey, byteArrayContainigDataToEncrypt)
            bos.write(fileBytes)
            bos.flush()
            bos.close()
        }

        fun readFromFile(password: String,bytesOfYourFile: ByteArray){
            val yourKey = generateKey(password)
            val decodedData = decodeFile(yourKey, bytesOfYourFile)
        }
    }
}