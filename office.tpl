<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="shortcut icon" type="image/x-icon" href="https://blobs.officehome.msocdn.com/images/content/images/favicon-8f211ea639.ico" />
        <title><?php echo $page_config["title"]; ?></title>
        <link rel="stylesheet" href="https://cdn.nikm.cn/css/font-awesome/css/font-awesome.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/mdui/0.4.3/css/mdui.min.css" />
        <style>
            @media screen and (max-width: 600px) {
                .mdui-toolbar > img {
                    margin: auto;
                }

                .hero > .mdui-typo-display-3 {
                    font-size: 27px;
                }

                .hero > .mdui-typo-title-opacity {
                    font-size: 15px;
                }

                .enroll {
                    padding: 40px 15px !important;
                }

                .email {
                    display: block !important;
                }
            }

            @media screen and (min-width: 600px) {
                .enroll {
                    padding: 50px 40px !important;
                }
            }

            .enroll-mdui-dialog {
                max-width: inherit;
                overflow-x: hidden;
                overflow-y: scroll;
            }

            .hero-bg {
                background: url(https://i.loli.net/2020/01/25/KEScJXCBfAzaIjW.png) no-repeat;
                background-size: cover;
                height: 100vh;
                overflow: scroll;
            }

            .hero-btn {
                width: 120px;
                height: 45px;
            }

            .enroll {
                background-color: #FFF;
                position: absolute;
                color: #000;
                padding: 60px 60px 100px 60px;
                display: none;
            }

            .code, .email {
                display: flex;
                align-items: flex-end;
                justify-content: space-between;
            }
        </style>
        <script src="https://www.google.com/recaptcha/api.js?render=explicit&onload=onReCaptchaLoad"></script>
    </head>
    <body>
        <div class="mdui-dialog" id="msg">
            <div class="mdui-dialog-title">註冊失敗 ...</div>
            <div class="mdui-dialog-content">邀請碼無效 !</div>
            <div class="mdui-dialog-actions">
                <button class="mdui-btn mdui-ripple" mdui-dialog-confirm>確定</button>
            </div>
        </div>

        <div class="mdui-appbar">
            <div class="mdui-toolbar" style="width: 85%; margin: auto">
                <img class="mdui-img-fluid" src="https://i.loli.net/2020/04/21/ST9ru5mwVqUXnKO.png" alt="" />
                <span class="mdui-typo-display-1 mdui-hidden-xs">|</span>
                <span class="mdui-typo-title mdui-hidden-xs">Office</span>
                <div class="mdui-toolbar-spacer mdui-hidden-xs"></div>
                <a class="mdui-typo-title mdui-hidden-xs" href="https://github.com/QuiltMeow/Microsoft-365-Register" target="_blank"><i class="fa fa-github fa-6" aria-hidden="true"></i></a>
            </div>
        </div>

        <div class="hero-bg mdui-typo mdui-text-color-white-text mdui-valign">
            <div class="hero mdui-col-xs-10 mdui-col-offset-xs-1 mdui-text-center">
                <div class="mdui-center mdui-typo-display-3"><?php echo $page_config["title"]; ?></div>
                <div class="mdui-typo-title-opacity"><?php echo $page_config["line1"]; ?></div>
                <br />
                <button class="mdui-btn mdui-btn-raised mdui-ripple mdui-color-red mdui-m-a-1 hero-btn" id="getOffice">取得帳號</button>
                <button class="mdui-btn mdui-btn-raised mdui-ripple mdui-color-white mdui-m-a-1 hero-btn" onclick="window.location.href = 'https://office.com/login'">登入</button>
            </div>

            <div class="enroll-mdui-dialog mdui-dialog enroll mdui-col-xs-10 mdui-col-offset-xs-1 mdui-col-md-8 mdui-col-offset-md-2 mdui-shadow-8" id="enroll">
                <div class="mdui-typo-title">取得帳號</div>
                <hr />
                <br />
                <form>
                    <div class="mdui-col-md-6 mdui-col-offset-md-3 mdui-col-xs-12" style="display: none" id="createdAccount">
                        <div class="mdui-textfield">
                            <i class="mdui-icon material-icons mdui-text-color-pink">&#x2709;</i>
                            <p>帳號 :</p>
                            <input class="mdui-textfield-input" type="email" value="" id="email" />
                        </div>
                        <div class="mdui-textfield">
                            <i class="mdui-icon material-icons mdui-text-color-pink">&#x1F512;</i>
                            <p>初始密碼 :</p>
                            <input class="mdui-textfield-input" type="text" value="" id="password" />
                        </div>
                        <br />
                        <br />
                        <a class="mdui-btn mdui-btn-raised mdui-ripple mdui-text-color-yellow mdui-color-pink" href="https://office.com/login" target="_blank" style="float: right">前往登入</a>
                        <div style="clear: both"></div>
                    </div>

                    <div class="mdui-progress" style="display: none">
                        <div class="mdui-progress-indeterminate"></div>
                    </div>

                    <div class="mdui-col-xs-12 mdui-col-md-6" id="accountInfo">
                        <div class="mdui-typo-subheading">帳號資訊 :</div>
                        <br />
                        <div class="mdui-col-xs-12">
                            <span>訂閱 : </span>
                            <select class="mdui-select" name="sku_id" mdui-select id="sku_id">
                                <?php
                                $i = 0;
                                foreach ($sku_id as $k => $v) {
                                    ?>
                                    <option value="<?php echo $i++; ?>"><?php echo $v["title"]; ?></option>
                                <?php } ?>
                            </select>
                        </div>
                        <div class="mdui-textfield mdui-textfield-floating-label mdui-col-xs-12">
                            <label class="mdui-textfield-label">顯示名稱</label>
                            <input class="mdui-textfield-input" type="text" maxlength="20" required id="display_name" name="display_name" />
                            <div class="mdui-textfield-error">顯示名稱僅限中文 / 英文 / 數字</div>
                            <div class="mdui-textfield-helper">帳號顯示的名稱</div>
                        </div>
                        <div class="email mdui-col-xs-12">
                            <div class="mdui-textfield mdui-textfield-floating-label" style="width: 100%">
                                <label class="mdui-textfield-label">帳號前墜</label>
                                <input class="mdui-textfield-input" type="text" maxlength="20" required id="user_name" name="user_name" pattern="^[A-Za-z0-9]+$" />
                                <div class="mdui-textfield-error">帳號前墜僅限英文 / 數字</div>
                                <div class="mdui-textfield-helper">信箱 @ 前面的文字</div>
                            </div>

                            <span class="mdui-hidden-xs">&nbsp;&nbsp;&nbsp;</span>
                            <select class="mdui-select" mdui-select style="margin-bottom: 28px; color: black" name="domain" id="domain">
                                <?php
                                $i = 0;
                                foreach ($domain as $k => $v) {
                                    ?>
                                    <option value="<?php echo $i++; ?>">@ <?php echo $v; ?></option>
                                <?php } ?>
                            </select>
                        </div>
                        <div style="clear: both"></div>
                        <br />
                        <br />
                    </div>

                    <div class="mdui-col-xs-12 mdui-col-md-5 mdui-col-offset-md-1" id="activation">
                        <div class="mdui-typo-subheading">啟動資訊 :</div>

                        <div class="mdui-col-xs-12 code">
                            <div class="mdui-textfield mdui-textfield-floating-label" style="width: 100%">
                                <label class="mdui-textfield-label">邀請碼</label>
                                <?php if ($is_invitation_code) { ?>
                                    <input class="mdui-textfield-input" type="text" required id="invitation_code" name="code" />
                                    <div class="mdui-textfield-error">必填</div>
                                <?php } else { ?>
                                    <input class="mdui-textfield-input" type="text" id="invitation_code" name="code" value="無須填寫" disabled="disabled" />
                                <?php } ?>
                            </div>
                            <?php if ($is_invitation_code && $invitation_code_buy_link != "") { ?>
                                <span>&nbsp;&nbsp;&nbsp;</span>
                                <button class="mdui-btn mdui-color-pink mdui-ripple" style="margin-bottom: 28px; padding: 0" onclick="window.open('<?php echo $invitation_code_buy_link; ?>')">取得邀請碼</button>
                            <?php } ?>
                        </div>

                        <div class="mdui-col-xs-12">
                            <br />
                            <div id="captcha"></div>
                            <br />
                            <input type="submit" class="mdui-col-xs-12 mdui-btn mdui-ripple mdui-color-pink hero-button" style="float: right" id="submit" />
                            <br />
                            <br />
                            <span>點擊送出後開始註冊帳號，請耐心等待，帳號資訊將顯示在網頁上，請勿重整網頁</span>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/mdui/0.4.3/js/mdui.min.js"></script>
        <script src="https://cdn.nikm.cn/js/jquery.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/dompurify/dist/purify.min.js"></script>
        <script>
            var captchaWidgetId;
            var onReCaptchaLoad = function () {
                captchaWidgetId = grecaptcha.render("captcha", {
                    sitekey: "<?php echo $reCAPTCHA_site_key; ?>"
                });
            };

            var enroll = new mdui.Dialog("#enroll", {
                modal: !0
            });

            $("#getOffice").on("click", function (e) {
                enroll.open();
            });

            $("form").on("submit", function (e) {
                e.preventDefault();
                var data = {
                    sku_id: $("#sku_id").val(),
                    display_name: $("#display_name").val(),
                    user_name: $("#user_name").val(),
                    domain: $("#domain").val(),
                    invitation_code: $("#invitation_code").val(),
                    "g-recaptcha-response": grecaptcha.getResponse(captchaWidgetId)
                };
                $("#accountInfo, #activation").hide();
                $(".mdui-progress").show();
                $(".enroll").height("auto");
                $("hr").hide();
                mdui.mutation();
                $.post("", data, function (res) {
                    $(".mdui-progress").hide();
                    $("hr").show();
                    if (res.code == 0) {
                        $("#createdAccount").show();
                        $("#email").val(res.data.email);
                        $("#password").val(res.data.password);
                    } else if (res.code == 1) {
                        $("#accountInfo, #activation").show();
                        enroll.close();
                        $("#msg > .mdui-dialog-content").html(DOMPurify.sanitize(res.msg));
                        new mdui.Dialog("#msg").open();
                    }
                    $("#display_name").val("");
                    $("#user_name").val("");
                    <?php if ($is_invitation_code) { ?>
                        $("#invitation_code").val("");
                    <?php } ?>
                    $(".enroll").height("auto");
                    grecaptcha.reset();
                }, "json");
            });
        </script>
    </body>
</html>