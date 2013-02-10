
hints_display_url_panel = false;

//hint_background_color = '#A59461';
//active_hint_background_color = '#344B1B';

register_user_stylesheet(
    "data:text/css," +
        escape(
            "@namespace url(\"http://www.w3.org/1999/xhtml\");\n" +
            "span.__conkeror_hint {\n"+
            "  font-size: 10px !important;\n"+
            "  line-height: 10px !important;\n"+
            "}"));
/*
register_user_stylesheet(
    "data:text/css," +
        escape (
            "span.__conkeror_hint {" +
            " border: 1px solid #0F0F0F !important;" +
            " color: #0F0F0F !important;" +
            " background-color: #B45B00 !important;" +
            "}"));
*/
require("casual-spelling");
