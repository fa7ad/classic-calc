import React, {Component} from 'react'

import './Display.css'

class Display extends Component
  render: ->
    {children, memory} = @props
    <div className="display">
      <div className="memory">{memory}</div>
      <div className="screen">{children}</div>
    </div>

export default Display