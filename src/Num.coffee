import React, {Component} from 'react'

import './Num.css'

class Num extends Component
  render: ->
    {children, onTap, className} = @props
    <button
      className={"number #{className or ''}"}
      onClick={-> onTap(children)}
    >{children}</button>

export default Num