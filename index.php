<?php

require("common.php");

function check_index($data, $index) {
    return $index >= 0 && $index < count($data);
}

if (empty($_POST)) {
    require("office.tpl");
    exit();
}

if (empty($_POST["g-recaptcha-response"])) {
    response(1, "驗證失敗");
}

include_once("re_captcha_lib.php");
$re_captcha = new ReCaptcha($reCAPTCHA_secret_key);
$re_captcha_res = $re_captcha->verifyResponse($_SERVER["REMOTE_ADDR"], $_POST["g-recaptcha-response"]);
if (!isset($re_captcha_res) || !$re_captcha_res->success) {
    response(1, "驗證失敗");
}

if ($is_invitation_code) {
    if (empty($_POST["invitation_code"])) {
        response(1, "請輸入邀請碼");
    }
    $conn = mysql_conn();
    $code = mysqli_real_escape_string($conn, $_POST["invitation_code"]);
    $invitation_code = mysqli_fetch_assoc(mysqli_query($conn, "select * from invitation_code where `code` = \"$code\""));
    if (empty($invitation_code)) {
        response(1, "邀請碼不存在");
    }
    if ($invitation_code["status"] != 0) {
        response(1, "邀請碼已被使用");
    }
}

$display_name = trim($_POST["display_name"]);
$user_name = trim($_POST["user_name"]);
if (empty($display_name) || empty($user_name)) {
    response(1, "請輸入所有必填資訊");
}
if (strlen($display_name) >= 20 || strlen($user_name) >= 20 || preg_match("/[^A-Za-z0-9]/", $user_name)) {
    response(1, "請確保所有欄位皆符合格式");
}

$domain_index = $_POST["domain"];
if (!is_numeric($domain_index)) {
    response(1, "域名資訊輸入錯誤");
}
$domain_index = intval($domain_index);
if (!check_index($domain, $domain_index)) {
    response(1, "域名索引資訊輸入錯誤");
}

$sku_id_index = $_POST["sku_id"];
if (!is_numeric($sku_id_index)) {
    response(1, "訂閱資訊輸入錯誤");
}
$sku_id_index = intval($sku_id_index);
if (!check_index($sku_id, $sku_id_index)) {
    response(1, "訂閱索引資訊輸入錯誤");
}

$request = [
    "display_name" => $display_name,
    "user_name" => $user_name
];
$password = get_rand_string();
$token = get_ms_token($tenant_id, $client_id, $client_secret);
if (empty($token)) {
    response(1, "取得 Token 失敗，請檢查參數設定是否正確");
}
$email = create_user($request, $token, $domain[$domain_index], $sku_id[$sku_id_index]["sku_id"], $password);
if ($is_invitation_code) {
    $clean_email = mysqli_real_escape_string($conn, $email);
    mysqli_query($conn, "UPDATE `invitation_code` SET `update_time` = " . time() . ", `status` = 1, `email` = \"$clean_email\" WHERE `code` = \"$code\"");
}
response(0, "註冊帳號成功", ["email" => $email, "password" => $password]);