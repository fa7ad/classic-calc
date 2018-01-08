import React, {Component} from 'react'

import './App.css'
import Display from './Display'

class App extends Component
  render: ->
    <div className="App calc">
      <Display memory={123} screen={123} />
    </div>

export default App