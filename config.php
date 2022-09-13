<?php

return [
    // 全局帳號相關設定
    "client_id" => "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
    "tenant_id" => "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
    "client_secret" => "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
    "domain" => [
        "example.onmicrosoft.com"
    ],
    "sku_id" => [
        [
            "title" => "A1P 學生訂閱",
            "sku_id" => "e82ae690-a2d5-4d76-8d30-7c6e01e6022e"
        ],
        [
            "title" => "A1P 教職員訂閱",
            "sku_id" => "78e66a63-337a-4a9a-8959-41c6654dfb56"
        ]
    ],
    // 網站標題等文字
    "page_config" => [
        "title" => "Microsoft 365 子號自助開通",
        "line1" => "(1 TB Onedrive + 桌面版 Office)"
    ],
    // 如果不需要邀請碼相關功能，以上設定已足夠
    // 是否開啟邀請碼才可申請帳號
    "is_invitation_code" => true,
    // 邀請碼購買網址 (不顯示則填入空白字串)
    "invitation_code_buy_link" => "",
    // 後台相關設定
    "admin" => [
        "username" => "admin",
        "password" => "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", // 自行輸入密碼 https://miniwebtool.com/zh-tw/sha512-hash-generator 填入輸出
        "invitation_code_num" => 20 // 隨機產生的邀請碼位數
    ],
    // 資料庫設定
    "db" => [
        "host" => "127.0.0.1",
        "username" => "office",
        "password" => "example_mysql_password",
        "database" => "office"
    ],
    // "我不是機器人" 設定
    "reCAPTCHA_site_key" => "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
    "reCAPTCHA_secret_key" => "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
];