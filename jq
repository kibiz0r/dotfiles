def dynamo_item:
  if type == "object" and  .NULL == true then
    null
  else
    # DynamoDB string type
    (objects | .S)

    # DynamoDB blob type
    // (objects | .B)

    # DynamoDB number type
    // (objects | .N | strings | tonumber)

    # DynamoDB boolean type
    // (objects | .BOOL)

    # DynamoDB map type, recursion on each item
    // (objects | .M | objects | with_entries(.value |= dynamo_item))

    # DynamoDB list type, recursion on each item
    // (objects | .L | arrays | map(dynamo_item))

    # DynamoDB typed list type SS, string set
    // (objects | .SS | arrays | map(dynamo_item))

    # DynamoDB typed list type NS, number set
    // (objects | .NS | arrays | map(tonumber))

    # DynamoDB typed list type BS, blob set
    // (objects | .BS | arrays | map(dynamo_item))

    # managing others DynamoDB output entries: "Count", "Items", "ScannedCount" and "ConsumedCapcity"
    // (objects | with_entries(.value |= dynamo_item))
    
    # recurse arrays
    // (arrays | map(dynamo_item))

    # leaves values
    // .
  end
  ;

def dynamo:
  (objects | .Items | arrays | map(dynamo_item))
  // .
  ;

def csv:
  map(with_entries(.value |= tostring)) | (map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @csv
  ;