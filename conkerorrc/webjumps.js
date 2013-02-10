// -*- outline-minor-mode: t; outline-regexp: "/\\*+ "; -*-

// Notes:
//
//   The webjumps in this file are organized in outline form that can be
// used with outline-minor-mode in emacs.  To allow emacs to automatically
// turn on outline-minor-mode when you load this file, put this in your
// .emacs:
//
//   (add-to-list 'safe-local-variable-values '(outline-minor-mode . t))
//


/* fun */
define_webjump("9", "http://www.9gag.com");

/* astronomy */

define_webjump("nasa-hsf-sightings",
    "http://spaceflight1.nasa.gov/realdata/sightings/cities/view.cgi?"+
    "country=United_States&region=Michigan&city=Grand_Rapids");

/* biology */

// encyclopedia of life
define_webjump("eol", "http://eol.org/search?q=%s&ie=UTF-8&search_type=text");

/* music */


/** emacs **/
define_webjump("emacswiki",
    "http://www.google.com/cse?cx=004774160799092323420%3A6-ff2s0o6yi&q=%s&sa=Search&siteurl=emacswiki.org%2F",
    $alternative="http://www.emacswiki.org/");

/** imagemagick **/

// magick-options is a webjump for imagemagick command line options.
//
// magick-options caches its completions in a preference.  To clear the cache
// and force magick-options to fetch the information anew, just do:
//
//   clear_pref('conkeror.webjump.magick-options.cache');
//
// last modified: November 25, 2009
//
function magick_options_completer (input, cursor_position, conservative) {
    var completions;
    try {
        completions = get_pref('conkeror.webjump.magick-options.cache').split(' ');
    } catch (e) {}
    if (! completions) {
        try {
            var content = yield send_http_request(
                load_spec({uri: "http://www.imagemagick.org/script/command-line-options.php"}));
            completions = content.responseText
                .match(/([a-z]+)(?=\">-\1<\/a>)/g)
                .filter(remove_duplicates_filter());
            user_pref('conkeror.webjump.magick-options.cache', completions.join(' '));
        } catch (e) {
            completions = [];
        }
    }
    yield co_return(prefix_completer($completions = completions)
                    (input, cursor_position, conservative));
}
define_webjump("magick-options",
    "http://www.imagemagick.org/script/command-line-options.php#%s",
    $alternative = "http://www.imagemagick.org/script/command-line-options.php",
    $completer = magick_options_completer);


/* language */

define_webjump("anagram", "http://wordsmith.org/anagram/anagram.cgi?anagram=%s&t=1000&a=n");


/* math */

define_webjump("mathworld", "http://mathworld.wolfram.com/search/?query=%s&x=0&y=0");

/* news */
define_webjump("fefe", "http://blog.fefe.de");

define_webjump("news", "http://news.google.com/news/search?q=%s");

define_webjump("hackernews", "http://searchyc.com/%s",
               $alternative = "http://news.ycombinator.com/");

/* programming */

define_webjump("stackoverflow","http://stackoverflow.com/search?q=%s", $alternative="http://stackoverflow.com");

define_webjump("rfc", "http://www.ietf.org/rfc/rfc%s.txt");


/** latex **/

define_webjump("ctan-desc", "http://www.ctan.org/cgi-bin/search.py?"+
               "metadataSearch=%s&metadataSearchSubmit=Search");
define_webjump("ctan-pack", "http://www.ctan.org/cgi-bin/search.py?"+
               "tdsFilename=%s&tdsFilenameSearch=Search");
define_webjump("ctan-file", "http://www.ctan.org/cgi-bin/filenameSearch.py?"+
               "filename=%s&Search=Search");
define_webjump("ctan-doc", "http://www.ctan.org/cgi-bin/searchFullText.py?"+
               "fullTextSearch=%s&fullTextSearchSubmit=Search");


/** perl **/

define_webjump("perldoc", "http://perldoc.perl.org/search.html?q=%s");
// define_webjump("cpan", "http://search.cpan.org/search?query=%s&mode=all"); 
define_webjump("cpan", "https://metacpan.org/search?q=%s");

/** bash **/

define_webjump("bashfaq",
    "http://mywiki.wooledge.org/BashFAQ?action=fullsearch&context=180&value=%s&fullsearch=Text",
    $alternative = "http://mywiki.wooledge.org/BashFAQ");

define_webjump("commandlinefu", 
    function(term) {
        return 'http://www.commandlinefu.com/commands/matching/' +
            term.replace(/[^a-zA-Z0-9_\-]/g, '')
                .replace(/[\s\-]+/g, '-') +
            '/' + btoa(term);
    },
    $argument = 'optional',
    $alternative = "http://www.commandlinefu.com/");
define_webjump("mdc", "https://developer.mozilla.org/Special:Search?search=%s&type=fulltext&go=Search");

/* debian */

define_webjump("debpkg", "http://packages.debian.org/%s");
define_webjump("debfile", "http://packages.debian.org/?searchon=contents&keywords=%s&mode=path&suite=unstable&arch=any");
define_webjump("debbugs", "http://bugs.debian.org/%s");
define_webjump("debpts", "http://packages.qa.debian.org/%s");
define_webjump("debpopcon", "http://qa.debian.org/popcon.php?package=%s");
define_webjump("buildd", "https://buildd.debian.org/%s");
define_webjump("buildd-ports", "http://buildd.debian-ports.org/build.php?pkg=%s");
define_webjump("debqa", "http://qa.debian.org/developer.php?login=%s");

define_webjump("debianwiki",
    "http://wiki.debian.org/Suspend?action=fullsearch&context=180&value=%s&fullsearch=Text");

/* misc */

define_webjump("grlug-wiki", "http://wiki.grlug.org/index.php?search=%s&fulltext=Search");
define_webjump("kol", "http://www.kingdomofloathing.com");

/* search engines */

define_webjump("sogou", "http://www.sogou.com/web?query=%s");
define_webjump("ixquick", "http://ixquick.com/do/metasearch.pl?query=%s");
define_webjump("lmgtfy", "http://lmgtfy.com/?q=%s");
define_webjump("scroogle", "http://www.scroogle.org/cgi-bin/nbbw.cgi?Gw=%s");

/* network tools */


define_webjump("down?",
    function (url) {
        if (url)
            return "http://downforeveryoneorjustme.com/" + url;
        else
            return "javascript:window.location.href='http://downforeveryoneorjustme.com/'+window.location.href;";
    },
    $argument = "optional");

define_webjump("wayback",
    function (url) {
        if (url)
            return "http://web.archive.org/web/*/" + url;
        else
            return "javascript:window.location.href='http://web.archive.org/web/*/'+window.location.href;";
    },
    $argument = "optional");

define_webjump("validate",
    "http://validator.w3.org/check?uri=%s&charset=%28detect+automatically%29&doctype=Inline&group=0");

define_webjump("validate-css",
    "http://jigsaw.w3.org/css-validator/validator?uri=%s&profile=css21&usermedium=all&warning=1&lang=en");

define_webjump("friday?", "http://docgno.me/is-it-friday-yet.php");

define_webjump("gmane", "http://gmane.org/find.php?list=%s");

/* gitweb */

/*
 *  Call gitweb-webjump-get-opml to init completions info.
 */
/*
require("gitweb-webjump");
gitweb_webjumps_opml_directory = get_home_directory();
gitweb_webjumps_opml_directory.appendRelativePath(".conkerorrc/gitweb-webjumps-opml");

define_gitweb_summary_webjump("repo.or.cz", "http://repo.or.cz/w",
                              $alternative = "http://repo.or.cz/");
*/

/* entertainment */
webjumps.g = webjumps.google;
define_webjump("reads", "http://www.goodreads.com/search?query=%s");
define_webjump("imdb", "http://imdb.com/find?q=%s");
define_webjump("memory-alpha", "http://memory-alpha.org/wiki/Special:Search/?search=%s");
define_webjump("youtube", "http://www.youtube.com/results?search_query=%s&search=Search");
define_webjump("youtube-user", "http://youtube.com/profile_videos?user=%s");
define_webjump("knowyourmeme", "http://knowyourmeme.com/search?q=%s");

/* weather  */
define_webjump("wunderground", "http://www.wunderground.com/cgi-bin/findweather/getForecast?query=%s");

define_webjump("github", "http://github.com/search?q=%s&type=Everything");

