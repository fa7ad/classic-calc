import React, {Component} from 'react'

import './Display.css'

class Display extends Component
  render: ->
    {children, memory, onChange} = @props
    <div className="display">
      <div className="memory">{memory}</div>
      <input type="text" className="screen" value={children}/>
    </div>

export default Display