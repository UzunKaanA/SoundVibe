//
//  AuthResponse.swift
//  Project
//
//  Created by Kaan Uzun on 30.01.2024.
//

import Foundation


struct AuthResponse: Codable {
  let access_token: String
  let expires_in: Int
  let refresh_token: String?
  let scope: String
  let token_type: String
}

//Created the struct to make it easy our code. 

// The code response when there is a Auth Login in App.
//{
//    "access_token" = "BQBowSiBMpYbyerhtMPU0vNovtW78Q9SNie35mFbQNpnJIAVSbXAb2_YspnqkHW_v4YBqjhmKRpswYCMVlgS2xH3inkTxsQKehTLfi0uImjW6JMEFbLl8Vdf724aYGRehAD7uOtK_jzmo_2i9HCxKJ2tFzR6dPC4hdKyDp2LRu45TEVUzGTkD-RFRfBnHGSKiX2zsxPP7nH4sC8X0PI";
//    "expires_in" = 3600;
//    "refresh_token" = "AQCrHdVgMksUksX9X6IcXh0oW3eIsS-556u48e9QJhdDiZr2Y67Ij-njVJl77_oTwTyLd8Y0c3cRhQNv0mR3bwU4YlV6peifoM6SzYLxfavCK4IxocKM-gJoFkS7uNIhsg8";
//    scope = "user-read-private";
//    "token_type" = Bearer;
//}
