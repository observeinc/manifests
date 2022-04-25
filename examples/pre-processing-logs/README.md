# Pre-processing logs 

To apply a set of filters to a subset of logs, you will need to use the
`rewrite_tag` filter to identify the subset of logs you are interested in. In
this example, we use the following filter:

```
[FILTER]
    Name          rewrite_tag
    Match         k8slogs
    Rule          $containerName ${CONTAINER_FILTER_REGEX} k8slogs.preprocessing false
```

In this case, all logs with tag `k8slogs` have their taggen rewritten to
`k8slogs.preprocessing` if their `containerName` matches the provided regex,
which in this case is loaded in via the `CONTAINER_FILTER_REGEX` environment
variable. The final argument of the filter rule is set to `false`, which
ensures that any matching log is discarded from the original input.

The base fluent-bit configuration ensures we emit logs with any tag starting
with `k8slogs`, so there is no need to write an additional output for this new
set of logs.

