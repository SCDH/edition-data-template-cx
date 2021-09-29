xquery version "3.1";

(: The following external variables are set by the repo:deploy function :)

(: file path pointing to the exist installation directory :)
declare variable $home external;
(: path to the directory containing the unpacked .xar package :)
declare variable $dir external;
(: the target collection into which the app is deployed :)
declare variable $target external;

xmldb:create-collection($target, "content"),
sm:chmod(xs:anyURI($target || "/content"), "rwxrwxr-x"),
sm:chown(xs:anyURI($target || "/content"), "tei"),
sm:chgrp(xs:anyURI($target || "/content"), "tei"),
xmldb:create-collection($target || "/content", "temp"),
sm:chmod(xs:anyURI($target || "/content/temp"), "rwxrwxr-x"),
sm:chown(xs:anyURI($target || "/content/temp"), "tei"),
sm:chgrp(xs:anyURI($target || "/content/temp"), "tei")