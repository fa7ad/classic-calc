import React, {Component} from 'react'

import './App.css'
import Display from './Display'
import Num from './Num'
import Action from './Action'

numbers = [
  "zero", "one",
  "two", "three",
  "four", "five",
  "six", "seven",
  "eight", "nine"
]

class App extends Component
  constructor: (p, c) ->
    super(p, c)
    @state =
      curr: []
      prev: []

  render: ->
    <div className="App calc">
      <Display memory={@state.prev.join ''}>{@state.curr.join ''}</Display>
      <Action className="clr" onTap={@reset}> C </Action>
      {numbers.map (n, i) => <Num className={n} key={n} onTap={@pushNumber}>{i}</Num>}
      <Num className="dot" onTap={@pushNumber}>.</Num>
      <Action className="div"> &divide; </Action>
      <Action className="mul"> &times; </Action>
      <Action className="min"> &minus; </Action>
      <Action className="add"> + </Action>
      <Action className="eql"> = </Action>
    </div>
  
  pushNumber: (num) =>
    if num is '.' and '.' in @state.curr
      return
    if @state.curr.length > 9
      return
    @setState (p) -> curr: p.curr.concat num
  
  reset: =>
    @setState
      curr: []
      prev: []


export default App