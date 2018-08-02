import React, {Component} from 'react'

import './Display.css'

class Display extends Component
  render: ->
    {children, memory, onChange} = @props
    <div className="display">
      <div className="memory">{(''+memory).replace /\"/g, ''}</div>
      <input type="text" className="screen" disabled value={(''+children).replace /\"/g, ''}/>
    </div>

export default Display
