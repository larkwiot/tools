#  MIT License
#
#  Copyright (c) 2018 Diego Zamboni
#
#  Permission is hereby granted, free of charge, to any person obtaining a copy
#  of this software and associated documentation files (the "Software"), to deal
#  in the Software without restriction, including without limitation the rights
#  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#  copies of the Software, and to permit persons to whom the Software is
#  furnished to do so, subject to the following conditions:
#
#  The above copyright notice and this permission notice shall be included in all
#  copies or substantial portions of the Software.
#
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#  SOFTWARE.

use re
use ./util

fn decorate [@input &code-suffix='' &display-suffix='' &suffix='' &style='']{
  # &style is currently ignored because it is not supported by Elvish
  if (eq (count $input) 0) {
    input = [(all)]
  }
  if (not-eq $suffix '') {
    display-suffix = $suffix
    code-suffix = $suffix
  }
  each [k]{
    edit:complex-candidate &code-suffix=$code-suffix &display=$k$display-suffix $k
  } $input
}

fn empty { nop }

fn files [arg &regex='' &dirs-only=$false]{
  edit:complete-filename $arg | each [c]{
    x = $c[stem]
    if (or (-is-dir $x) (and (not $dirs-only) (or (eq $regex '') (re:match $regex $x)))) {
      put $c
    }
  }
}

fn dirs [arg &regex='']{
  files $arg &regex=$regex &dirs-only=$true
}

fn extract-opts [@cmd
  &regex='^\s*(?:-(\w),?\s*)?(?:--?([\w-]+))?(?:\[=(\S+)\]|[ =](\S+))?\s*?\s\s(\w.*)$'
  &regex-map=[&short=1 &long=2 &arg-optional=3 &arg-required=4 &desc=5]
  &fold=$false
]{
  -line = ''
  capture = $all~
  if $fold {
    capture = { each [l]{
        if (re:match '^\s+\w' $l) {
          put $-line$l
          -line = ''
        } else {
          put $-line
          -line = $l
        }
      }
    }
  }
  $capture | each [l]{ re:find $regex $l } | each [m]{
    g = $m[groups]
    opt = [&]
    keys $regex-map | each [k]{
      if (has-key $g $regex-map[$k]) {
        field = $g[$regex-map[$k]][text]
        if (not-eq $field '') {
          if (has-value [arg-optional arg-required] $k) {
            opt[$k] = $true
            opt[arg-desc] = $field
            opt[completer] = $files~
          } else {
            opt[$k] = $field
          }
        }
      }
    }
    if (or (has-key $opt short) (has-key $opt long)) {
      put $opt
    }
  }
}

fn -handler-arity [func]{
  fnargs = [ (count $func[arg-names]) (and (not-eq $func[rest-arg] '') (not-eq $func[rest-arg] -1))]
  if     (eq $fnargs [ 0 $false ]) { put no-args
  } elif (eq $fnargs [ 1 $false ]) { put one-arg
  } elif (eq $fnargs [ 0 $true  ]) { put rest-arg
  } else {                           put other-args
  }
}

fn -expand-item [def @cmd]{
  arg = $cmd[-1]
  what = (kind-of $def)
  if (eq $what 'fn') {
    [ &no-args=  { $def }
      &one-arg=  { $def $arg }
      &rest-arg= { $def $@cmd }
      &other-args= { put '<completion-fn-arity-error>' }
    ][(-handler-arity $def)]
  } elif (eq $what 'list') {
    all $def
  } else {
    echo (styled "comp:-expand-item: invalid item of type "$what": "(to-string $def) red) >/dev/tty
  }
}

fn -expand-sequence [seq @cmd &opts=[]]{

final-opts = [(
    -expand-item $opts $@cmd | each [opt]{
      if (eq (kind-of $opt) map) {
        if (has-key $opt arg-completer) {
          opt[completer] = [_]{ -expand-item $opt[arg-completer] $@cmd }
        }
        put $opt
      } else {
        put [&long= $opt]
      }
    }
)]

final-handlers = [(
    all $seq | each [f]{
      if (eq (kind-of $f) 'fn') {
        put [
          &no-args=  [_]{ $f }
          &one-arg=  $f
          &rest-arg= [_]{ $f $@cmd }
          &other-args= [_]{ put '<completion-fn-arity-error>' }
        ][(-handler-arity $f)]
      } elif (eq (kind-of $f) 'list') {
        put [_]{ all $f }
      } elif (and (eq (kind-of $f) 'string') (eq $f '...')) {
        put $f
      }
    }
)]

edit:complete-getopt $cmd[1:] $final-opts $final-handlers
  }

fn -expand-subcommands [def @cmd &opts=[]]{

subcommands = [(keys $def)]
n = (count $cmd)
kw = [(range 1 $n | each [i]{
      if (has-value $subcommands $cmd[$i]) { put $cmd[$i] $i }
})]

if (and (not-eq $kw []) (not-eq $kw[1] (- $n 1))) {
  sc sc-pos = $kw[0 1]
  if (eq (kind-of $def[$sc]) 'string') {
    cmd[$sc-pos] = $def[$sc]
    -expand-subcommands &opts=$opts $def $@cmd
  } else {
    $def[$sc] (all $cmd[{$sc-pos}:])
  }

      } else {
        top-def = [ { put $@subcommands } ]
        -expand-sequence &opts=$opts $top-def $@cmd
      }
    }

fn item [item &pre-hook=$nop~ &post-hook=$nop~]{
  put [@cmd]{
    $pre-hook $@cmd
    result = [(-expand-item $item $@cmd)]
    $post-hook $result $@cmd
    put $@result
  }
}

fn sequence [sequence &opts=[] &pre-hook=$nop~ &post-hook=$nop~]{
  put [@cmd]{
    $pre-hook $@cmd
    result = [(-expand-sequence &opts=$opts $sequence $@cmd)]
    $post-hook $result $@cmd
    put $@result
  }
}

fn subcommands [def &opts=[] &pre-hook=$nop~ &post-hook=$nop~]{
  put [@cmd]{
    $pre-hook $@cmd
    result = [(-expand-subcommands &opts=$opts $def $@cmd)]
    $post-hook $result $@cmd
    put $@result
  }
}
