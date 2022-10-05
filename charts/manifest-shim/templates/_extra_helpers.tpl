{{/*
  Get a value by it's path in an object

  Example usage:
      {{- $value := (include "getByPath" (list .Values $path) | fromJson).result -}}
*/}}
{{- define "getByPath" -}}
  {{- $cursor := index . 0 -}}
  {{- $path := index . 1 -}}

  {{- $_ := required "getByPath must have a path set" $path -}}

  {{- range $_, $element := $path }}
    {{- if typeIsLike "string" $element -}}
      {{- if not (hasKey $cursor $element) -}}
        {{- fail (cat "getByPath received invalid path (key not found):" $element "\n" ($path |toYaml)) -}}
      {{- end -}}
      {{- $cursor = (get $cursor $element) -}}
    {{- else if or (typeIsLike "int" $element) (typeIsLike "float64" $element) -}}
      {{- if ge ($element|int) ($cursor|len) -}}
        {{- fail (cat "getByPath received invalid path (index out of range):" $element "\n" ($path |toYaml)) -}}
      {{- end -}}
      {{- $cursor = (index $cursor ($element|int)) -}}
    {{- else -}}
      {{- fail (cat "getByPath received invalid path:" $element "\n" ($path |toYaml)) -}}
    {{- end -}}
  {{- end -}}
  {{ dict "result" $cursor | toJson }}
{{- end -}}

{{/*
  Set a value by it's path in an object

  Example usage:
    {{- include "setByPath" (list $object $path $value) -}}
*/}}
{{- define "setByPath" -}}
  {{- $args := . -}}
  {{- $cursor := index $args 0 -}}
  {{- $path := index $args 1 -}}
  {{- $value := index $args 2 -}}

  {{- $_ := required "setByPath must have a path set" $path -}}
  {{- $_ := required "setByPath must have a value set" $value -}}

  {{- range $i, $element := $path }}
    {{- if eq (add 1 $i) ($path | len) -}}
      {{- $_ := set $cursor $element $value -}}
    {{- else if typeIsLike "string" $element -}}
      {{- $cursor = (get $cursor $element) -}}
    {{- else if or (typeIsLike "int" $element) (typeIsLike "float64" $element) -}}
      {{- $cursor = (index $cursor ($element | int)) -}}
    {{- else -}}
      {{- fail (cat "setByPath received invalid path:" $element "\n" ($path | toYaml)) -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
