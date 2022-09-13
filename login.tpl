<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="content-type" content="text/html; charset=utf-8" />
        <title>後台登入</title>
        <script src="https://www.google.com/recaptcha/api.js" async defer></script>
    </head>
    <body>
        <form method="post" action="./admin.php?a=login">
            <span>帳號 : </span><input type="text" name="username" />
            <br />
            <span>密碼 : </span><input type="password" name="password" />
            <br />
            <div class="g-recaptcha" data-sitekey="<?php echo $reCAPTCHA_site_key; ?>"></div>
            <input type="submit" value="登入" />
        </form>
    </body>
</html>