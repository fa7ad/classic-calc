import React, {Component} from 'react'

import Display from './Display'

class App extends Component
  render: ->
    <div className="calc">
      <Display memory={123} screen={123} />
    </div>

export default App