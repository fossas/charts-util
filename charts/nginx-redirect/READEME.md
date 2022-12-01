# nginx-redirect
This chart is usable as an easy to configure knob for redirects.

Here is a configuration example.
```yaml
redirects:
- host: try.example.com
  # a list of path prefixes to redirect for
  paths:
  - path: /
    # where to redirect to
    dest: https://app.example.com/try
  # (optional) enables tls and is used in determining a secret name
  sslSecret: try-example

- host: do.example.com
    path: /
    dest: https://app.example.com/do
  sslSecret: try-example

- host: get.example.com
    path: /
    dest: https://app.example.com/get
  sslSecret: try-example

- host: other.example.com
  - path: /
    dest: https://app.example.com/other
    type: 301
  sslSecret: other-example
```
