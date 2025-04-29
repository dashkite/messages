import * as Fn from "@dashkite/joy/function"
import * as Obj from "@dashkite/joy/object"
import * as Val from "@dashkite/joy/value"
import * as Meta from "@dashkite/joy/metaclass"
import Generic from "@dashkite/generic"
import Format from "@dashkite/format-text"
import { interpolate as expand } from "@dashkite/joy/text"

Code =
  toString: do ->
    ( Generic.make "toString" )
      .define [ String ], ( code ) -> code
      .define [ Array ], ( code ) -> code.join " :: "
  
class Messages

  @make: ( options ) -> 
    Object.assign ( new @ ), 
      unresolved: ( options.unresolved ? Fn.identity )

  constructor: ->
    @codes = {}

  Meta.mixin @::, [
    Meta.properties
      prefix:
        get: -> @_prefix ? ""
        set: (prefix) -> @_prefix = "#{ prefix }: "
  ]

  add: ( codes ) ->
    # precedence based on order of addition allowing modules
    # to augment (ex: provide defaluts) but not overwrite
    @codes = Val.merge codes, @codes
    @

  has: ( code ) -> Obj.getx code, @codes

  get: ( code ) -> @expand code

  expand: ( code, context = {}) ->
    if ( template = Obj.getx code, @codes )?
      "#{ @prefix }#{ expand template, context }"
    else
      @unresolved Code.toString code

  failure: ( code, context = {} ) ->
    error = new Error "#{ @message code, context }"
    Object.assign error, { code, context }

  title: ( code, context = {}) ->
    Format.title @expand code, context

export { Messages }
export default Messages