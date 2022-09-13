<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="content-type" content="text/html; charset=utf-8" />
        <title>邀請碼列表</title>
        <link rel="stylesheet" href="https://cdn.nikm.cn/js/layui/css/layui.css" media="all" />
    </head>
    <body class="layui-layout-body" style="overflow-y: visible; background: #FFF">
        <div class="layui-form">
            <blockquote class="layui-elem-quote quoteBox">
                <div class="layui-inline" style="margin-left: 2rem">
                    <a class="layui-btn" id="create"><i class="layui-icon">&#xe608;</i> 新增邀請碼</a>
                </div>
                <div class="layui-inline" style="margin-left: 1rem">
                    <select id="search_status">
                        <option value="0">全部</option>
                        <option value="1">已使用</option>
                        <option value="2">未使用</option>
                    </select>
                </div>
                <div class="layui-inline" style="margin-left: 1rem">
                    <a class="layui-btn layui-btn-normal" id="search"><i class="layui-icon">&#xe615;</i> 搜尋</a>
                </div>
                <div class="layui-inline" style="margin-left: 1rem">
                    <button type="button" class="layui-btn" id="export"><i class="layui-icon">&#xe67d;</i> 導出</button>
                </div>
                <div class="layui-inline" style="margin-left: 1rem">
                    <button type="button" class="layui-btn" id="logout">登出</button>
                </div>
            </blockquote>
        </div>

        <table class="layui-hide" id="table" lay-filter="table">
        </table>

        <div id="create_content" class="layui-form layui-form-pane" style="display: none; margin: 1rem 3rem">
            <div class="layui-form-item">
                <label class="layui-form-label">建立次數</label>
                <div class="layui-input-block">
                    <input type="text" placeholder="請輸入建立次數" class="layui-input" value="0" id="num" />
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-filter="formDemo" id="submit">送出</button>
                </div>
            </div>
        </div>
    </body>

    <script type="text/html" id="buttons">
        <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="accountactive">允許</a>
        <a class="layui-btn layui-btn-warm layui-btn-xs" lay-event="accountinactive">禁止</a>
        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">刪除</a>
    </script>

    <script src="https://cdn.nikm.cn/js/layui/layui.js"></script>
    <script src="https://cdn.nikm.cn/js/jquery.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/dompurify/dist/purify.min.js"></script>
    <script type="text/javascript" charset="utf-8">
        layui.use(["table", "form", "layer"], function () {
            var table = layui.table;
            var layer = layui.layer;
            table.render({
                elem: "#table",
                url: "./admin.php?a=invitation_code_list",
                cellMinWidth: 80,
                height: "full-120",
                page: true,
                limits: [18, 50, 80, 100],
                limit: 18,
                cols: [[{
                            field: "id",
                            title: "ID",
                            align: "center"
                        }, {
                            field: "code",
                            title: "邀請碼",
                            align: "center"
                        }, {
                            field: "status",
                            title: "狀態",
                            align: "center",
                            templet: function (d) {
                                if (d.status == 0) {
                                    return "<span style=\"color: green\">未使用</span>";
                                } else {
                                    return "<span style=\"color: red\">已使用</span>";
                                }
                            }
                        }, {
                            field: "email",
                            title: "註冊帳號",
                            align: "center",
                            templet: function (d) {
                                if (d.email) {
                                    return d.email;
                                } else {
                                    return "-";
                                }
                            }
                        }, {
                            field: "account_status",
                            title: "帳號狀態",
                            align: "center",
                            templet: function (d) {
                                if (d.account_status == -1) {
                                    return "<span style=\"color: red\">已禁用</span>";
                                } else if (d.account_status == 0) {
                                    return "<span style=\"color: green\">正常</span>";
                                } else {
                                    return "-";
                                }
                            }
                        }, {
                            field: "create_time",
                            title: "建立時間",
                            align: "center"
                        }, {
                            field: "update_time",
                            title: "最後修改時間",
                            align: "center"
                        }, {
                            fixed: "right",
                            title: "操作",
                            align: "center",
                            toolbar: "#buttons"
                        }
                    ]]
            });

            table.on("tool(table)", function (obj) {
                if (obj.event === "del") {
                    layer.confirm("刪除邀請碼將刪除關聯的帳號，確定刪除嗎 ?", function (index) {
                        $.post("./admin.php?a=invitation_code_delete", {
                            id: obj.data.id,
                            email: obj.data.email
                        }, function (res) {
                            if (res.code == 0) {
                                obj.del();
                            }
                            layer.msg(DOMPurify.sanitize(res.msg));
                        }, "json");
                    });
                }

                if (obj.event === "accountactive") {
                    layer.confirm("確定允許登入 ?", function (index) {
                        $.post("./admin.php?a=invitation_code_account_enable", {
                            email: obj.data.email
                        }, function (res) {
                            if (res.code == 1) {
                                layer.closeAll();
                                layui.use("table", function () {
                                    var table = layui.table;
                                    table.reload("table", {
                                        url: "./admin.php?a=invitation_code_list"
                                    });
                                });
                            }
                            layer.msg(DOMPurify.sanitize(res.msg));
                        }, "json");
                    });
                }

                if (obj.event === "accountinactive") {
                    layer.confirm("確定禁止登入 ?", function (index) {
                        $.post("./admin.php?a=invitation_code_account_disable", {
                            email: obj.data.email
                        }, function (res) {
                            if (res.code == 1) {
                                layer.closeAll();
                                layui.use("table", function () {
                                    var table = layui.table;
                                    table.reload("table", {
                                        url: "./admin.php?a=invitation_code_list"
                                    });
                                });
                            }
                            layer.msg(DOMPurify.sanitize(res.msg));
                        }, "json");
                    });
                }
            });

            $("#logout").click(function () {
                layer.confirm("確定登出 ?", function (index) {
                    $.post("./admin.php?a=logout", function (res) {
                        if (res.code == 1) {
                            layer.closeAll();
                        }
                        layer.msg(DOMPurify.sanitize(res.msg));
                        window.location.reload();
                    }, "json");
                });
            });

            $("#search").click(function () {
                layui.use("table", function () {
                    var table = layui.table;
                    table.reload("table", {
                        url: "./admin.php?a=invitation_code_list",
                        where: {
                            status: $("#search_status").val()
                        }
                    });
                });
            });

            $(document).on("keydown", function (e) {
                if (e.keyCode == 13) {
                    $("#search").click();
                }
            });

            $("#create").click(function () {
                layer.open({
                    type: 1,
                    title: "新增邀請碼",
                    skin: "layui-layer-rim",
                    area: ["50rem", "12rem"],
                    content: $("#create_content")
                });
            });

            $("#submit").click(function () {
                var data = {
                    num: $("#num").val()
                };
                $.post("./admin.php?a=invitation_code_create", data, function (res) {
                    if (res.code == 0) {
                        layer.closeAll();
                        layui.use("table", function () {
                            var table = layui.table;
                            table.reload("table", {
                                url: "./admin.php?a=invitation_code_list"
                            });
                        });
                    }
                    layer.msg(DOMPurify.sanitize(res.msg));
                }, "json");
            });

            $("#export").click(function () {
                var count = $(".layui-laypage-count").text().replace("共 ", "").replace(" 条", "");
                $.get("./admin.php?a=invitation_code_list&page=1&limit=" + count, function (res) {
                    if (res.code == 0) {
                        for (let k in res.data) {
                            res.data[k].status == 1 ? res.data[k].status = "已使用" : res.data[k].status = "未使用";
                            res.data[k].eamil ? res.data[k].eamil = res.data[k].eamil : "-";
                        }
                        table.exportFile(["ID", "邀請碼", "建立時間", "修改時間", "是否使用", "註冊帳號"], res.data, "csv");
                    }
                }, "json");
            });
        });
    </script>
</html>