xquery version "1.0-ml";

import module namespace merging = "http://marklogic.com/smart-mastering/survivorship/merging"
  at "/com.marklogic.smart-mastering/survivorship/merging/options.xqy";

xdmp:directory-delete($merging:MERGING-OPTIONS-DIR)
