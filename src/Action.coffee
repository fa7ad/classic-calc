import React from 'react'

import './Action.css'

Action = (p, c) =>
  <button
    className={"action #{p.className or ''}"}
    onClick={p.onTap}
  >{p.children}</button>

export default Action