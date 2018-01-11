import React from 'react'

import './Action.css'

Action = (p, c) =>
  <button
    className={"action #{p.className or ''}"}
    onClick={(e) -> 
      e.preventDefault()
      p.onTap p.val or e
    }
    style={p.style}
  >{p.children}</button>

export default Action