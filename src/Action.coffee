import React from 'react'

import './Action.css'

Action = (p, c) =>
  <button
    className={"action #{p.className or ''}"}
    onClick={p.onTap}
    style={p.style}
  >{p.children}</button>

export default Action