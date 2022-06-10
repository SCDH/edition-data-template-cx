xquery version "3.1";

declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace svrl = "http://purl.oclc.org/dsdl/svrl";
declare namespace scdh = "http://scdh.wwu.de/quality-control";

declare variable $basedir external := '../../target/generated-resources/xml/xslt';
declare variable $suffix external := 'svrl';
declare variable $abspath external := '';

declare variable $mvnlog-file external := '../../target/mvnlog.xml';

(: $repo-slotname works with this default value in most places, but does not work with the default value of $mvnlog-file :)
declare variable $repo-slotname external := let $path-segments := tokenize($mvnlog-file, '/') return $path-segments[last() - 2];
declare variable $repo-branch-uri external := concat('file:../../', $repo-slotname);

declare variable $project-title external := 'Edition';

declare variable $col := collection(concat($abspath, $basedir, '?recurse=yes;select=*.', $suffix));

declare variable $reports := for $svrl in $col
return
    doc(document-uri($svrl));

declare variable $mvnlog := doc($mvnlog-file);

declare function scdh:count-errors($reports) as xs:integer
{
    for $report in $reports
    let $const := 'a'
    let $errors := count($report//svrl:successful-report | $report//svrl:failed-assert)
        group by $const
    let $total := sum($errors)
    return
        $total
};


<html>
    <head>
        <title>Continuous Quality Control Report for {$project-title}</title>
        <style>
            .pass {{
            background-color: #98FB98;
            }}
            .fail {{
            background-color: #ffcccb;
            }}
        </style>
    </head>
    <body>
        <section>
            <head>Summary</head>
            <p>TEI documents tested: {count(distinct-values($reports//svrl:active-pattern[@document][1]/@document))}</p>
            <p>Schematron-Reports: {count($col)}</p>
            <p>Errors: {
                    let $errors := count($mvnlog//entry[@level eq 'ERROR'][@document])
                    let $status := if ($errors eq 0) then
                        'pass'
                    else
                        'fail'
                    return
                        (<span
                            class="{$status}">{$errors}</span>)
                } (Relax NG), {
                    let $errors := scdh:count-errors($reports)
                    let $status := if ($errors eq 0) then
                        'pass'
                    else
                        'fail'
                    return
                        (<span
                            class="{$status}">{$errors}</span>)
                } (Schematron)</p>
        </section>
        <section>
            <head>Details</head>
            <table>
                <thead>
                    <td>Document</td>
                    <td>Relax NG</td>
                    <td>Schematron</td>
                </thead>
                {
                    for $report in $reports
                    let $tei-relpath := tokenize($report//svrl:active-pattern[@document][1]/@document, concat($repo-slotname, '/'))[last()]
                        group by $tei-relpath
                        order by $tei-relpath
                    let $tei-uri := string-join(($repo-branch-uri, $tei-relpath), '/')
                    let $errors := scdh:count-errors(($report))
                    let $rng-errors := count($mvnlog//entry[@level eq 'ERROR' and matches(@document, $tei-relpath)])
                    let $status := if ($errors eq 0 and $rng-errors eq 0) then
                        'pass'
                    else
                        'fail'
                    return
                        (
                        <tr
                            class="{$status}">
                            <td>
                                <a
                                    href="{$tei-uri}">{$tei-relpath}</a>
                            </td>
                            <td>{$rng-errors}</td>
                            <td>{$errors}</td>
                        </tr>)
                }
            </table>
        </section>
        <section style="margin-top: 5em;">
            <head>Technical Information:</head>
            <table>
                <tr>
                    <td>Repository branch:</td>
                    <td>{$repo-branch-uri}</td>
                </tr>
                <tr>
                    <td>Repository slot name / base folder name:</td>
                    <td>{$repo-slotname}</td>
                </tr>
            </table>
        </section>
    </body>
</html>