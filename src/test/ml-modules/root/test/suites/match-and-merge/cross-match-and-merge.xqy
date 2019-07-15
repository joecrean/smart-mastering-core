xquery version "1.0-ml";

import module namespace constants = "http://marklogic.com/smart-mastering/constants"
  at "/com.marklogic.smart-mastering/constants.xqy";
import module namespace process = "http://marklogic.com/smart-mastering/process-records"
  at "/com.marklogic.smart-mastering/process-records.xqy";
import module namespace lib = "http://marklogic.com/smart-mastering/test" at "lib/lib.xqy";

import module namespace test = "http://marklogic.com/roxy/test-helper" at "/test/test-helper.xqy";

declare namespace es="http://marklogic.com/entity-services";
declare namespace sm="http://marklogic.com/smart-mastering";

declare option xdmp:update "true";

declare option xdmp:mapping "false";

let $actual :=
  xdmp:invoke-function(
    function() {
      process:process-match-and-merge(cts:uris((), (), cts:collection-query($constants:CONTENT-COLL)), $lib:CROSS-MERGE-OPTIONS-NAME)
    },
    $lib:INVOKE_OPTIONS
  )

let $merged-uri := cts:uris((), "limit=1", cts:collection-query($constants:MERGED-COLL))
let $merged-doc := fn:doc($merged-uri)

return (
  test:assert-same-values(($lib:CROSS-URI1, $lib:CROSS-URI2, $lib:CROSS-URI3), $merged-doc/es:envelope/es:headers/sm:merges/sm:document-uri/fn:string())
)
